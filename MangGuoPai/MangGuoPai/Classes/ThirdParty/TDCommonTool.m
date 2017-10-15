//
//  TDCommonTool.m
//  TDQianxiaoer
//
//  Created by zhenyong on 2017/3/7.
//  Copyright © 2017年 TDMarket. All rights reserved.
//

#import "TDCommonTool.h"
#import "TDPrivilegeChecking.h"
@implementation TDCommonTool

//单例
+(TDCommonTool *)shareTool{
    static TDCommonTool *manager = nil;
    @synchronized(self){
        if(manager == nil){
            manager = [[TDCommonTool alloc]init];
        }
    }
    return manager;
}
#pragma mark--ui类


//获取分割线


UIView* getSepLine(float y)
{
    UIView *sepLine = [[UIView alloc]initWithFrame:CGRectMake(0, y, Screen_Width, 1)];
    sepLine.backgroundColor = MGSepColor;
    return sepLine;
}
+ (UIImage *)drawLineByImageView:(UIImageView *)imageView{
    UIGraphicsBeginImageContext(imageView.frame.size); //开始画线 划线的frame
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // 5是每个虚线的长度 1是高度
    CGFloat lengths[] = {5,0.5};
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, [UIColor colorWithHexString:@"#e6e6e6"].CGColor);
    CGContextSetLineDash(line, 0, lengths, 1); //画虚线
    CGContextMoveToPoint(line, 0.0, 1.0); //开始画线
    CGContextAddLineToPoint(line,Screen_Width - 10, 1.0);
    
    CGContextStrokePath(line);
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}
#pragma mark--字符串nsdate时间转换
//字符串转nsdate
+(NSDate *)getDateFromString:(NSString *)time{
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:time];
    //时区转换，取得系统时区，取得格林威治时间差秒
    return date;
}
//nsdate 转字符串
+(NSString *)getStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    return currentDateString;
}

+(NSString *)getStringFromDate:(NSDate *)date andFormatterStr:(NSString *)formatterStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
    [dateFormatter setDateFormat:formatterStr];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    return currentDateString;
}
+(NSDate *)getDateFromString:(NSString *)time andFormatterStr:(NSString *)formatterStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
    [formatter setDateFormat:formatterStr];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:time];
    //时区转换，取得系统时区，取得格林威治时间差秒
    return date;
}
#pragma mark --日历数据处理
/** 某个月的第一天 */
+ (NSDate *)firstDayOfCurrentMonth:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear=[[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"MM"];
    NSInteger currentMonth=[[formatter stringFromDate:date]integerValue];
    NSDate *monthDate = [TDCommonTool getDateFromString:[NSString stringWithFormat:@"%lu-%lu-01",currentYear,currentMonth]];
    //时区转换，取得系统时区，取得格林威治时间差秒
    NSTimeInterval  timeZoneOffset=[[NSTimeZone systemTimeZone] secondsFromGMT];
//    NSLog(@"%f",timeZoneOffset/60.0/60.0);
    
    monthDate = [monthDate dateByAddingTimeInterval:timeZoneOffset];
    return monthDate;
    
}
/** 获取第一天星期几 */
+ (NSUInteger)weeklyOrdinality:(NSDate *)date

{
   
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:date];
}
/** 获取一个月多少天 */
+(int)daysOfMonthFromDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear=[[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"MM"];
    
    NSInteger currentMonth=[[formatter stringFromDate:date]integerValue];
    if (currentMonth == 1 || currentMonth == 3 || currentMonth == 5 || currentMonth == 7 || currentMonth == 8 || currentMonth == 10 || currentMonth == 12) {
        return 31;
    }
    if (currentMonth == 2) {
        if (currentYear % 4 == 0) {
            return 29;
        }
        return 28;
    }
    return 30;
}
/** 获取上个月多少天 */
+(int)daysOfLastMonthFromDate:(NSDate *)date{
    return [TDCommonTool daysOfMonthFromDate:[TDCommonTool getMonthOfDate:date isLastMonth:YES]];
}
/*
 *
 获取上个月或者下个月的nsdate
 */
+(NSDate *)getMonthOfDate:(NSDate *)date isLastMonth:(BOOL)isLastMonth{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear=[[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"MM"];
    NSInteger currentMonth=[[formatter stringFromDate:date]integerValue];
    NSInteger month = 0;
    NSInteger year = 0;
    if (isLastMonth) {
        if (currentMonth == 1) {
            month = 12;
            year = currentYear-1;
        }else{
            year = currentYear;
            month = currentMonth-1;
        }
    }else{
        if (currentMonth == 12) {
            month = 1;
            year = currentYear+1;
        }else{
            year = currentYear;
            month = currentMonth+1;
        }

    }
    NSDate *monthDate = [TDCommonTool getDateFromString:[NSString stringWithFormat:@"%lu-%lu-01",year,month]];
    //时区转换，取得系统时区，取得格林威治时间差秒
    NSTimeInterval  timeZoneOffset=[[NSTimeZone systemTimeZone] secondsFromGMT];
//    NSLog(@"%f",timeZoneOffset/60.0/60.0);
    
    monthDate = [monthDate dateByAddingTimeInterval:timeZoneOffset];
    return monthDate;
}
+(NSInteger )getYearFromDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear = [[formatter stringFromDate:date] integerValue];
    return currentYear;
    
}
+(NSInteger )getMonthFromDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
    [formatter setDateFormat:@"MM"];
    NSInteger currentMonth=[[formatter stringFromDate:date]integerValue];
    return currentMonth;
    
}



//vc
+ (UIViewController *)findViewController:(UIView *)sourceView {
    id target = sourceView;
    
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    
    return target;
}

+ (UIViewController *)currentViewController {
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    return [TDCommonTool findTopViewController:viewController];
}

#pragma mark - Private Function
+ (UIViewController *)findTopViewController:(UIViewController *)vc {
    
    if (vc.presentedViewController) {
        return [TDCommonTool findTopViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [TDCommonTool findTopViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [TDCommonTool findTopViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [TDCommonTool findTopViewController:svc.selectedViewController];
        else
            return vc;
        
    } else {
        return vc;
    }
}


#pragma mark--日程
+(EKEventStore *)shareEventStore{
    static EKEventStore *manager = nil;
    @synchronized(self){
        if(manager == nil){
            manager = [[EKEventStore alloc]init];
        }
    }
    return manager;
}
+(void)createEventCalendarTitle:(NSString *)title location:(NSString *)location andUrlID:(NSString *)urlId startDate:(NSDate *)startDate endDate:(NSDate *)endDate allDay:(BOOL)allDay alarmArray:(NSArray *)alarmArray {
    //    __weak typeof(self) weakSelf = self;
    
    EKEventStore *eventStore = [TDCommonTool shareEventStore];
    
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    [MBProgressHUD showOnlyText:@"添加失败,请重试"];
                    
                }else if (!granted){
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"尚未打开添加日程的权限" delegate:[TDCommonTool shareTool] cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [alert show];

                    
                }else{
                                        
                    [TDCommonTool setCalendarEventS:title location:location andUrlID:urlId startDate:startDate endDate:endDate allDay:YES alarmArray:alarmArray andEKEventStore:eventStore];
                    
                }
            });
        }];
    }
}
+(void)setCalendarEventS:(NSString *)title location:(NSString *)location andUrlID:(NSString *)urlId startDate:(NSDate *)startDate endDate:(NSDate *)endDate allDay:(BOOL)allDay alarmArray:(NSArray *)alarmArray andEKEventStore:(EKEventStore *)eventStore {
    
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    event.title     = title;
    event.location = location;
    
    event.notes = [NSString stringWithFormat:@"http://www.baidu.com?id=%@",urlId];
//    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
//    [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
    
    event.startDate = startDate;
    event.endDate   = endDate;
    event.allDay = allDay;
    
    //添加提醒
    if (alarmArray && alarmArray.count > 0) {
        
        for (NSString *timeString in alarmArray) {
            [event addAlarm:[EKAlarm alarmWithRelativeOffset:[timeString integerValue]]];
        }
    }
    
    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
    NSError *err;
    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
    
//    [MBProgressHUD showOnlyText:@"添加系统日程成功"];

}
#pragma mark--判断是否为数字
+ (BOOL)isNum:(NSString *)checkedNumString {
    NSString * regex        = @"^[0-9]+(\\.[0-9]{1,2})?$";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch            = [pred evaluateWithObject:checkedNumString];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
}
#pragma mark--判断是否为小写字母
+ (BOOL)isLowerLetter:(NSString *)str

{
    if ([str characterAtIndex:0] >= 'a' && [str characterAtIndex:0] <= 'z') {
        return YES;
    }
    return NO;
}
#pragma mark--判断是否位数字
+ (BOOL)isNumberText:(NSString *)str{
    NSString * regex        = @"^[0-9]*$";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch            = [pred evaluateWithObject:str];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
}
#pragma mark--邮箱验证
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
#pragma mark--金额统一处理
+(NSString *)adJustMoneyStr:(NSString *)money{
    
    NSMutableString *tempStr = money.mutableCopy;
    NSRange range = [money rangeOfString:@"."];
    NSInteger index = 0;
    if ([money floatValue] < 100000000000) {
        

        if(range.length > 0){
            index = range.location;
        }else{
            index = money.length;
        }
        while ((index-3)> 0) {
            index-=3;
            [tempStr insertString:@"," atIndex:index];
        }
        

        /// 去除 -，999，999.00 中的 逗号
        if (tempStr.length > 1 && [tempStr hasPrefix:@"-"] && [[tempStr substringWithRange:NSMakeRange(1, 1)] isEqualToString:@","]) {
            [tempStr replaceCharactersInRange:NSMakeRange(1, 1) withString:@""];
        }
        

        return tempStr;
    }

    return money;
}

+ (NSString *)randomString:(NSInteger)length {
    
    if (length <= 0) {
        return @"";
    }
    
    char data[length];
    for (int x=0; x<length; data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:length encoding:NSUTF8StringEncoding];
}

+ (NSString *)getTimeStamp {
    
    // 精确到毫秒
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *timeStamp         = [NSString stringWithFormat:@"%.0f", timeInterval];
    
    return timeStamp;
}
+(NSString *)inputMoneyStr:(NSString *)textString{
    NSArray *strArr = [textString componentsSeparatedByString:@"."];
    if (strArr.count > 1) {

        NSString *floatStr = strArr[1];
        NSString *value1 = strArr[0];
        
        if (value1.length == 0) { //没写0补0操作
            value1 = @"0";
        }else{//整数部分有0去0操作
            value1 = [NSString stringWithFormat:@"%d",[value1 intValue]];
        }
        if([value1 integerValue] >= 10000000){
            value1 = [value1 substringWithRange:NSMakeRange(0, value1.length -1)];
        }
        
        if (floatStr.length > 2) {
            NSString *floatValueStr = [floatStr substringWithRange:NSMakeRange(0, 2)];
            
            textString = [NSString stringWithFormat:@"%@.%@",value1,floatValueStr];
            
            return textString;
            
        }else{
            if (![TDCommonTool isNum:textString] && floatStr.length > 0) {
                return @"";
            }

            textString = [NSString stringWithFormat:@"%@.%@",value1,floatStr];
            
            return textString;
        }
        
    }else if(strArr.count == 1){
        if (![TDCommonTool isNumberText:textString]) {
            return @"";
        }
        NSString *value1 = strArr[0];
        if (value1.length == 0) { //没写0补0操作
            
        }else{//整数部分有0去0操作
            value1 = [NSString stringWithFormat:@"%d",[value1 intValue]];
        }
        if([value1 integerValue] >= 10000000){
            value1 = [value1 substringWithRange:NSMakeRange(0, value1.length -1)];
        }
        return value1;
    }
    return textString;
}

+ (BOOL)anySubViewScrolling:(UIView *)view{
    if ([view isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)view;
        if (scrollView.dragging || scrollView.decelerating) {
            return YES;
        }
    }
    for (UIView *theSubView in view.subviews) {
        if ([self anySubViewScrolling:theSubView]) {
            return YES;
        }
    }
    return NO;
}

/// 归档某个模型对象 实现copy
+ (BOOL)archiveWithModel:(id)model keyName:(NSString *)keyName {
    /// 利用 归档 实现 copy
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:keyName];
    return [NSKeyedArchiver archiveRootObject:model toFile:filePath];
}
/// 获取归档的模型 对象
+ (id)getArchiveWithKeyName:(NSString *)keyName {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:keyName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

#pragma mark--delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [TDPrivilegeChecking jumpToAppOwnSetting];
    }
}

#pragma mark--表情特殊字符计算文字长度
+ (BOOL)textFieldLimitConditionWithText:(NSString *)text length:(NSInteger)length outMaxText:(NSString **)outmaxText {
    
    NSMutableString *outStringM = @"".mutableCopy;
    
    NSInteger currentLength = 0;
    NSRange rangeStr;
    for (int i  = 0; i < text.length; i += rangeStr.length) {
        rangeStr = [text rangeOfComposedCharacterSequenceAtIndex:i];
        NSString *str = [text substringWithRange:rangeStr];
        if ([str stringContainsEmoji]) {
            currentLength+=2;
        }
        else if ([str stringContainsChinese]){
            currentLength+=2;
        }
        else if ([str stringContainsEnglish]) {
            currentLength+=1;
        }else{
            currentLength+=2;
        }
        
        if (currentLength > length) {
            *outmaxText = outStringM;
            return YES;
        } else {
            [outStringM appendString:str];
        }
    }
    return NO;
}
#pragma mark - 价格处理
+ (NSString *)formatPriceWithDoublePrice:(double)price {
    NSString *result = [NSString stringWithFormat:@"¥%0.2f",price];
    return result;
}

@end
