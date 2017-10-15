//
//  NSDate+Eextend.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/17.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "NSDate+Eextend.h"

@implementation NSDate (Eextend)

#define kCalendar [NSCalendar currentCalendar]

#define kDateComponents (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)


#pragma mark -
#pragma mark Comparing dates
- (BOOL) isTheSameDay: (NSDate *) aDate
{
    if (!aDate)
    {
        return NO;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString* selfFormatstr = [formatter stringFromDate:self];
    NSString* adateFormatstr= [formatter stringFromDate:aDate];
    return [selfFormatstr isEqualToString:adateFormatstr];
}

- (BOOL) isEarlierDate: (NSDate *) aDate
{
    return ([[self earlierDate:aDate] isEqualToDate:self]);
}

- (BOOL) isLaterDate: (NSDate *) aDate
{
    return ([[self laterDate:aDate] isEqualToDate:self]);
}

- (BOOL) dateBetweenStartDate:(NSDate*)start andEndDate:(NSDate*)end {
    
    BOOL isEarlier = [self isLaterDate:start];
    BOOL isLater = [self isEarlierDate:end];
    
    if (isLater && isEarlier) {
        return YES;
    } else
        return NO;
}

#pragma mark -
#pragma mark Date formatting

- (NSString*)localeFormattedDateString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSString *ret = [formatter stringFromDate:self];
    
    return ret;
}

- (NSString*)localeFormattedDateStringWithTime {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, yyyy HH:mm"];
    [formatter setLocale:[NSLocale currentLocale]];
    //   [formatter setDateStyle:NSDateFormatterShortStyle];
    NSString *ret = [formatter stringFromDate:self];
    return ret;
}

+ (NSDate *)localeFormatted {
    
    return [[NSDate date] dateFormattedLocale];
}

- (NSDate *)dateFormattedLocale {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    NSString *ret = [formatter stringFromDate:self];
    
    return [formatter dateFromString:ret];
}


- (NSDate *)dateFormattedWithFormatString:(NSString *)formmat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:formmat];
    NSString *ret = [formatter stringFromDate:self];
    
    return [formatter dateFromString:ret];
    
}

- (NSString *)formattedStringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *ret = [formatter stringFromDate:self];
    
    return ret;
}

- (NSDate *)dateWithoutTime
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *ret = [formatter stringFromDate:self];
    
    return [formatter dateFromString:ret];
}

+ (NSDate *)dateWithoutTime
{
    return [[NSDate date] dateWithoutTime];
}


#pragma mark -
#pragma mark SQLite formatting

- (NSDate *) dateForSqlite {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *ret = [formatter stringFromDate:self];
    
    NSDate *date = [formatter dateFromString:ret];
    
    return date;
}

+ (NSDate*) dateFromSQLString:(NSString*)dateStr {
    
    NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
    [dateForm setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    NSDate *date = [dateForm dateFromString:dateStr];
    return date;
}


#pragma mark -
#pragma mark Beginning and end of date components

- (NSDate *) startOfDay
{
    
    
    NSDateComponents *components = [kCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                fromDate:self];
    [components setHour: 0];
    [components setMinute: 0];
    [components setSecond: 0];
    
    return [kCalendar dateFromComponents:components];
}

- (NSDate *) endOfDay
{
    NSDateComponents *components = [kCalendar components: NSUIntegerMax fromDate: self];
    [components setHour: 23];
    [components setMinute: 59];
    [components setSecond: 59];
    
    return [kCalendar dateFromComponents:components];
}


- (NSDate *)beginningOfWeek {
    NSDate *now = self;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit
                                         fromDate:now];
    
    // 1 是周日，2是周一 3.以此类推
    NSInteger weekDay = [comp weekday] - 1;
    if (weekDay == 0) {
        weekDay = 7;
    }

    
    return [self dateByAddingDays:-(weekDay - 1)];

}

- (NSDate *)beginningOfMonth {
    
    NSDateComponents *comps = [kCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
    [comps setDay:1];
    
    return [kCalendar dateFromComponents:comps];
    
}

- (NSDate *)beginningOfYear {
    
    NSDateComponents *comps = [kCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
    [comps setDay:1];
    [comps setMonth:1];
    
    return [kCalendar dateFromComponents:comps];
    
}

- (NSDate *)endOfWeek {
    
    NSDate *now = self;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit
                                         fromDate:now];
    
    // 1 是周日，2是周一 3.以此类推
    NSInteger weekDay = [comp weekday] - 1;
    if (weekDay == 0) {
        weekDay = 7;
    }
    
    
    return [self dateByAddingDays:7 - weekDay];

}

- (NSDate *)endOfMonth {
    
    NSRange daysRange = [kCalendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
    
    NSDateComponents *components = [kCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
    [components setDay:daysRange.length];
    
    return [kCalendar dateFromComponents:components];
}

- (NSDate *)endOfYear {
    
    NSUInteger days = 0;
    NSDateComponents *components = [kCalendar components:NSYearCalendarUnit fromDate:self];
    NSUInteger months = [kCalendar rangeOfUnit:NSMonthCalendarUnit
                                        inUnit:NSYearCalendarUnit
                                       forDate:self].length;
    for (int i = 1; i <= months; i++) {
        components.month = i;
        NSDate *month = [kCalendar dateFromComponents:components];
        days += [kCalendar rangeOfUnit:NSDayCalendarUnit
                                inUnit:NSMonthCalendarUnit
                               forDate:month].length;
    }
    
    NSDateComponents *comps = [kCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];;
    
    [comps setMonth:12];
    
    return [[kCalendar dateFromComponents:comps] endOfMonth];
}


- (NSDate *)dateWithHour:(NSUInteger)hour mintus:(NSInteger)minutes
{
    NSDateComponents *comps = [kCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit| NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:self];
    [comps setHour:hour];
    [comps setMinute:minutes];
    return [kCalendar dateFromComponents:comps];
}


#pragma mark Date components

- (NSInteger) hour
{
    NSDateComponents *components = [kCalendar components:kDateComponents fromDate:self];
    return [components hour];
}

- (NSInteger) minute
{
    NSDateComponents *components = [kCalendar components:kDateComponents fromDate:self];
    return [components minute];
}

- (NSInteger) seconds
{
    NSDateComponents *components = [kCalendar components:kDateComponents fromDate:self];
    return [components second];
}

- (NSInteger) day
{
    NSDateComponents *components = [kCalendar components:kDateComponents fromDate:self];
    return [components day];
}

- (NSInteger) month
{
    NSDateComponents *components = [kCalendar components:kDateComponents fromDate:self];
    return [components month];
}

- (NSInteger) week
{
    NSDateComponents *components = [kCalendar components:kDateComponents fromDate:self];
    return [components week];
}

- (NSInteger) weekday
{
    NSDateComponents *components = [kCalendar components:kDateComponents fromDate:self];
    return [components weekday];
}

- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [kCalendar components:kDateComponents fromDate:self];
    return [components weekdayOrdinal];
}
- (NSInteger) year
{
    NSDateComponents *components = [kCalendar components:kDateComponents fromDate:self];
    return [components year];
}


- (NSString*) monthName {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    [formatter setLocale:[NSLocale currentLocale]];
    
    NSString *stringFromDate = [formatter stringFromDate:self];
    
    return stringFromDate;
}

- (NSString*) yearFromDateStr {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY"];
    [formatter setLocale:[NSLocale currentLocale]];
    
    NSString *stringFromDate = [formatter stringFromDate:self];
    
    return stringFromDate;
}

//================郑永能 add====================
/**
 *  是否为今天
 */
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}

/**
 *  是否为昨天
 */
- (BOOL)isYesterday
{
    // 2014-05-01
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    // 2014-04-30
    NSDate *selfDate = [self dateWithYMD];
    
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

/**
 * 返回字符串
 */
- (NSString *)dateToStringYYMMDDHHMM {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *selfStr = [fmt stringFromDate:self];
    return selfStr;
}
/**
 *  是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

- (NSInteger)getNumberOfDaysInMonth {
        
    NSCalendar * calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange  range = [calendar rangeOfUnit: NSCalendarUnitDay  inUnit:NSCalendarUnitMonth forDate:self];
    return range.length;
    
}

/// 获取时刻时间
- (NSString *)getRefreshNowTime {
    
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc]init];
    });
    
    NSDate *createDate = self;
    //真机调试必须加上此句
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    
    //判断是否为今年
    if(createDate.isThisYear){
        
        if (createDate.isToday) {//今天
            
            NSDateComponents *cmps = [createDate deltaWithNow];
            
            if (cmps.hour >= 1) {//至少是一小时前发的
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if(cmps.minute >= 1){//1~59分钟之前发的
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
                
            }else{
                return @"刚刚";
            }
            
        }else if(createDate.isYesterday){//昨天
            
            formatter.dateFormat = @"昨天 HH:mm";
            return [formatter stringFromDate:createDate];
            
        }else{//至少是前天
            formatter.dateFormat = @"MM-dd";
            return [formatter stringFromDate:createDate];
        }
    }else{//非今年
        formatter.dateFormat = @"yyyy-MM-dd";
        return [formatter stringFromDate:createDate];
    }
    
}

@end
