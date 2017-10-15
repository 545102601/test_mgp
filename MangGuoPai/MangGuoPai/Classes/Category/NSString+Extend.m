//
//  NSString+Extend.m
//  TDQianxiaoer
//
//  Created by huijie on 2017/3/10.
//  Copyright © 2017年 TDMarket. All rights reserved.
//

#import "NSString+Extend.h"
#import "RegexKitLite.h"

@implementation NSString (Extend)

#pragma mark - Public Function
- (CGSize)stringSizeWithFont:(UIFont *)font Size:(CGSize)size {
    
    CGSize resultSize;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
        
        //段落样式
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineBreakMode = NSLineBreakByWordWrapping;
        
        //字体大小，换行模式
        NSDictionary *attributes = @{NSFontAttributeName:font,
                                     NSParagraphStyleAttributeName:style};
        
        resultSize = [self boundingRectWithSize:size
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attributes
                                        context:nil].size;
        
    } else {
        resultSize = [self sizeWithFont:font
                      constrainedToSize:size
                          lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    return resultSize;
}

- (BOOL)checkEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)checkPhoneNum{
    
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";//@"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    
    BOOL isPhone = [self isMatchedByRegex:phoneRegex];
    
    return isPhone;
}

- (BOOL)checkAllPhoneNum{
    
    //检查座机
    NSString *phoneRegex = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    BOOL isPhone = [self isMatchedByRegex:phoneRegex];
    
    if (!isPhone) {
        return [self checkPhoneNum];
    }
    
    return isPhone;
}

- (BOOL)checkID
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

+ (BOOL)validateBankCardNumber:(NSString *)bankCardNumber
{
    BOOL flag;
    if (bankCardNumber.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{15,30})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}


- (BOOL)checkPassword {
    
    NSString *phoneRegex = @"^(?=.*?[A-Z,a-z])(?=.*?[0-9])[a-zA-Z0-9]{6,18}$";// 6-18位 数字 字母
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

// 转义字符
- (NSString *)urlEncode {
    return [(__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                         (CFStringRef)self,
                                                                         NULL,
                                                                         (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                         kCFStringEncodingUTF8) encodeAgain];
}

- (CGSize)calculateFontOfSize:(CGFloat)size width:(CGFloat)width {
    //    return [self sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    
    return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:size]}
                              context:nil].size;
}

+ (BOOL)isContainsEmoji:(NSString *)string {
    
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         //         NSLog(@"hs++++++++%04x",hs);
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f)
                 {
                     isEomji = YES;
                 }
                 //                 NSLog(@"uc++++++++%04x",uc);
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3|| ls ==0xfe0f) {
                 isEomji = YES;
             }
             //             NSLog(@"ls++++++++%04x",ls);
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
         
     }];
    return isEomji;
}

- (NSString *)removeBlank {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr {
    
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}

#pragma mark - Private Function
- (NSString *)encodeAgain {
    return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                        (CFStringRef)self,
                                                                        NULL,
                                                                        (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                        kCFStringEncodingUTF8);
    
    
}

//判断是否含有非法字符 yes 有  no没有
- (BOOL)JudgeTheillegalCharacter {  /// -> 因为后台 传递++ -- 会变为 “  ”
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}


- (BOOL)checkIncludeString {
    NSString *regex   = @"^([a-zA-Z0-9]|[._@!?,:;/\\-\\+\\=\\{\\}\\(\\)|#$%^&*~]){6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}


- (NSDate *)stringToCommonDate {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return [formatter dateFromString:self];
    
}


/// 转化为年月日
- (NSString *)stringToYYYYMMDDsString {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:self];
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter stringFromDate:date];
}

- (BOOL)stringContainsEmoji {
    
    if ([self isEqualToString:@"➋"] || [self isEqualToString:@"➌"] || [self isEqualToString:@"➍"] || [self isEqualToString:@"➎"] || [self isEqualToString:@"➏"] ||  [self isEqualToString:@"➐"] || [self isEqualToString:@"➑"] ||     [self isEqualToString:@"➒"]) {
        return NO;
    }
    
   return [self isMatchedByRegex:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"];

}
/// 判断字符是否包含字母 对于超长字符，会卡线程~ 采用正则，对于超长可能会好些~
- (BOOL)stringContainsEnglish {
    for(int i = 0;i < self.length; i++){
        unichar c = [self characterAtIndex:i];
        if((c<'A'||c>'Z')&&(c<'a'||c>'z'))
            return NO;
    }
    return YES;
}

/// 判断字符是否包含中文
- (BOOL)stringContainsChinese {
    return [self isMatchedByRegex:@"[\u2E80-\u9FFF]+"];
}



- (NSMutableAttributedString *)addLineSpaceWithfont:(UIFont *)font lineSpace:(CGFloat)lineSpace color:(UIColor *)color {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName : font,NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle}];
    return string;
}




@end
