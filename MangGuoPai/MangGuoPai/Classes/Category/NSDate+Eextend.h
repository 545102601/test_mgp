//
//  NSDate+Eextend.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/17.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSecondsMinute      60
#define kSecondsHour		3600
#define kSecondsDay         86400
#define kSecondsWeek		604800
#define kSecondsYear		31556926


@interface NSDate (Eextend)


#pragma mark Comparing dates
- (BOOL) isTheSameDay: (NSDate *) aDate;
- (BOOL) isEarlierDate: (NSDate *) aDate;
- (BOOL) isLaterDate: (NSDate *) aDate;
- (BOOL) dateBetweenStartDate:(NSDate*)start andEndDate:(NSDate*)end;

#pragma mark Date formatting

- (NSString*)localeFormattedDateString;
- (NSString*)localeFormattedDateStringWithTime;
+ (NSDate *)localeFormatted;
- (NSDate *)dateFormattedLocale;
- (NSDate *)dateFormattedWithFormatString:(NSString *)formmat;


- (NSString *)formattedStringWithFormat:(NSString *)format;
- (NSDate *)dateWithoutTime;
+ (NSDate *)dateWithoutTime;

#pragma mark SQLite formatting

- (NSDate *) dateForSqlite;
+ (NSDate*) dateFromSQLString:(NSString*)dateStr;

#pragma mark Beginning and end of date components

- (NSDate *) startOfDay;

- (NSDate *) endOfDay;

- (NSDate *)beginningOfWeek;

- (NSDate *)beginningOfMonth;

- (NSDate *)beginningOfYear;

- (NSDate *)endOfWeek;

- (NSDate *)endOfMonth;

- (NSDate *)endOfYear;

- (NSDate *)dateWithHour:(NSUInteger)hour mintus:(NSInteger)minutes;

#pragma mark Date components

- (NSInteger) seconds;

- (NSInteger) minute;

- (NSInteger) hour;

- (NSInteger) day;

- (NSInteger) month;

- (NSInteger) week;

- (NSInteger) weekday;

- (NSInteger) year;

- (NSString*) monthName;

- (NSString*) yearFromDateStr;

/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 * 返回字符串
 */
- (NSString *)dateToStringYYMMDDHHMM;


/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;


//获取某个月有多少天
- (NSInteger)getNumberOfDaysInMonth;


/// 获取时刻时间
- (NSString *)getRefreshNowTime;

@end
