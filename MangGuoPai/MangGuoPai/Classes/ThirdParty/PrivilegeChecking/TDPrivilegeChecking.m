//
//  TDPrivilegeChecking.m
//  TDQianxiaoer
//
//  Created by huijie on 2017/3/22.
//  Copyright © 2017年 TDMarket. All rights reserved.
//

#import "TDPrivilegeChecking.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
@import CoreTelephony;
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#import <EventKit/EventKit.h>

#define System_Version [[[UIDevice currentDevice] systemVersion] floatValue]

@implementation TDPrivilegeChecking
#pragma mark - Public Function
+ (BOOL)checkNotification {
    
    if (System_Version >= 8.0f) {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        
        if (UIUserNotificationTypeNone == setting.types) {
            return NO;
        }
        
    } else {
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        
        if(UIRemoteNotificationTypeNone == type) {
            return NO;
        }
    }
    
    return YES;
}

+ (BOOL)checkCalendar {
    EKAuthorizationStatus EKstatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    
    if (EKstatus != EKAuthorizationStatusAuthorized) {
        return NO;
    }
    
    return YES;
}


//判断是否允许使用麦克风7.0新增的方法requestRecordPermission
+ (BOOL)checkMicrophone {
    __block BOOL bCanRecord = YES;
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                }
                else {
                    bCanRecord = NO;
                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [[[UIAlertView alloc] initWithTitle:nil
//                                                    message:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"
//                                                   delegate:nil
//                                          cancelButtonTitle:@"关闭"
//                                          otherButtonTitles:nil] show];
                        DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:@"提示" message:@"请启用麦克风-设置/隐私/麦克风" cancelButtonTitle:@"取消" otherButtonTitle:@"去设置"];
                        [alertView setAlertThemeMessageTip_TwoButton];
                        alertView.otherButtonAction = ^{
                            [self jumpToAppOwnSetting];
                        };
                        [alertView show];
                        
                    });
                }
            }];
        }

    
    return bCanRecord;
}

+ (void)jumpToAppOwnSetting {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

+ (void)jumpToNotification {
    NSURL *url = [NSURL URLWithString:@"App-Prefs:root=NOTIFICATIONS_ID"];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark - Private Function

@end
