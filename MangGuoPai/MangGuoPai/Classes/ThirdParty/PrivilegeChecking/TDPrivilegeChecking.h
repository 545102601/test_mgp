//
//  TDPrivilegeChecking.h
//  TDQianxiaoer
//
//  Created by huijie on 2017/3/22.
//  Copyright © 2017年 TDMarket. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDPrivilegeChecking : NSObject
/*****************************
 * 系统权限检查
 *****************************/

/** 检查通知权限是否开启 */
+ (BOOL)checkNotification;
/** 检查日历权限是否开启 */
+ (BOOL)checkCalendar;
/** 检查是否开启了麦克风*/
+ (BOOL)checkMicrophone;


/*****************************
 * 系统设置跳转，需要先添加"URL Schema = prefs"
 *****************************/

/** 跳转到APP自身的设置页面， iOS 8+ */
+ (void)jumpToAppOwnSetting;
/** 跳转到 设置 - 通知 */
+ (void)jumpToNotification;

@end
