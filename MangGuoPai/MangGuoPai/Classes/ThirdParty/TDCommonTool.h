//
//  TDCommonTool.h
//  TDQianxiaoer
//
//  Created by zhenyong on 2017/3/7.
//  Copyright © 2017年 TDMarket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@interface TDCommonTool : NSObject<UIAlertViewDelegate>
//获取分割线
UIView* getSepLine(float y);
//画虚线
+ (UIImage *)drawLineByImageView:(UIImageView *)imageView;
#pragma mark-- 时间转换
//字符串转nsdate
+(NSDate *)getDateFromString:(NSString *)time;

//nsdate 转字符串
+(NSString *)getStringFromDate:(NSDate *)date;
+(NSString *)getStringFromDate:(NSDate *)date andFormatterStr:(NSString *)formatterStr;
+(NSDate *)getDateFromString:(NSString *)time andFormatterStr:(NSString *)formatterStr;
#pragma mark--日历
/** 某个月的第一天 */
+ (NSDate *)firstDayOfCurrentMonth:(NSDate *)date;
/** 获取第一天星期几 */
+ (NSUInteger)weeklyOrdinality:(NSDate *)date;
/** 获取一个月多少天 */
+(int)daysOfMonthFromDate:(NSDate *)date;
/** 获取上个月多少天 */
+(int)daysOfLastMonthFromDate:(NSDate *)date;
/*
 *
 获取上个月或者下个月的nsdate
 */
+(NSDate *)getMonthOfDate:(NSDate *)date isLastMonth:(BOOL)isLastMonth;
/** 获取年 */
+(NSInteger )getYearFromDate:(NSDate *)date;
/** 获取月 */
+(NSInteger )getMonthFromDate:(NSDate *)date;

/** 获取view对应的控制器 */
+ (UIViewController *)findViewController:(UIView *)sourceView;
/** 获取置顶的控制器 */
+ (UIViewController *)currentViewController;
#pragma mark--日程
+(EKEventStore *)shareEventStore;
+(void)createEventCalendarTitle:(NSString *)title location:(NSString *)location andUrlID:(NSString *)urlId startDate:(NSDate *)startDate endDate:(NSDate *)endDate allDay:(BOOL)allDay alarmArray:(NSArray *)alarmArray;
#pragma mark--是否2位数字
+ (BOOL)isNum:(NSString *)checkedNumString;
#pragma mark--判断是否位数字
+ (BOOL)isNumberText:(NSString *)str;
#pragma mark--是否为小写字母
+ (BOOL)isLowerLetter:(NSString *)str;
#pragma mark--邮箱验证
+ (BOOL) validateEmail:(NSString *)email;
+ (NSString *)adJustMoneyStr:(NSString *)money;
+(NSString *)inputMoneyStr:(NSString *)textString;
/** 时间戳 */
+ (NSString *)getTimeStamp;
/** 生成随机位数字符串 */
+ (NSString *)randomString:(NSInteger)length;



+ (BOOL)anySubViewScrolling:(UIView *)view;

/// 归档某个模型对象 实现copy
+ (BOOL)archiveWithModel:(id)model keyName:(NSString *)keyName;
/// 获取归档的模型 对象
+ (id)getArchiveWithKeyName:(NSString *)keyName;


#pragma mark--表情特殊字符计算文字长度
+ (BOOL)textFieldLimitConditionWithText:(NSString *)text length:(NSInteger)length outMaxText:(NSString **)outmaxText;
#pragma mark - 价格处理
+ (NSString *)formatPriceWithDoublePrice:(double)price;


@end
