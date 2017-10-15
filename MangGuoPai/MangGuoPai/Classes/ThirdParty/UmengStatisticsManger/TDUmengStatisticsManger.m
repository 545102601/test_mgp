//
//  TDUmengStatisticsManger.m
//  TDQianxiaoer
//
//  Created by huijie on 2017/4/5.
//  Copyright © 2017年 TDMarket. All rights reserved.
//

#import "TDUmengStatisticsManger.h"

@implementation TDUmengStatisticsManger
#pragma mark - Public Function
+ (TDUmengStatisticsManger *)sharedManager {
    static TDUmengStatisticsManger *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        instance = [[self alloc] init];
        NSString *configPlistPath = [[NSBundle mainBundle] pathForResource:@"UmengStatistics" ofType:@"plist"];
        instance.configPlistInfo = [[NSMutableDictionary alloc] initWithContentsOfFile:configPlistPath];
        TDDetialLog(@"configPlistInfo - %@", instance.configPlistInfo);
    });
    
    return instance;
}

+ (void)numberOfStatistics:(NSString *)eventID {
    if (eventID.length > 0) {
        [MobClick event:eventID];
    }
}


/** 次数统计 plist key*/
+ (void)numberOfStatisticsInfoPlistKey:(NSString *)key {
    NSMutableDictionary *plistInfo = [UMENG_MANAGER configPlistInfo];
    NSString *eventID = plistInfo[@"event"][@"event_time"][key];
    [self numberOfStatistics:eventID];
}


+ (void)beginEvent:(NSString *)eventID {
    if (eventID.length > 0) {
        [MobClick beginEvent:eventID];
    }
}

+ (void)endEvent:(NSString *)eventID {
    if (eventID.length > 0) {
        [MobClick endEvent:eventID];
    }
}

/** 停留时长统计，begin和End配对使用 plist key */
+ (void)beginEventWithKey:(NSString *)key {
    NSMutableDictionary *plistInfo = [UMENG_MANAGER configPlistInfo];
    NSString *eventID = plistInfo[@"event"][@"event_duration"][key];
    [self beginEvent:eventID];
}
+ (void)endEventWithKey:(NSString *)key {
    NSMutableDictionary *plistInfo = [UMENG_MANAGER configPlistInfo];
    NSString *eventID = plistInfo[@"event"][@"event_duration"][key];
    [self endEvent:eventID];
}


#pragma mark - Private Function

#pragma mark - Getter and Setter
- (NSMutableDictionary *)configPlistInfo {
    return _configPlistInfo;
}

@end
