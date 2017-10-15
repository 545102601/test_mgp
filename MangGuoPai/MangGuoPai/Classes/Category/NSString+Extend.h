//
//  NSString+Extend.h
//  TDQianxiaoer
//
//  Created by huijie on 2017/3/10.
//  Copyright © 2017年 TDMarket. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)
/**
 *  根据字符串的字体和size(此处size设置为字符串宽和MAXFLOAT)返回多行显示时的字符串size
 */
- (CGSize)stringSizeWithFont:(UIFont *)font Size:(CGSize)size;

/**
 *  邮箱校验
 */
- (BOOL)checkEmail;

/**
 *  电话校验
 */
- (BOOL)checkPhoneNum;
/**
 *  手机/电话号码校验
 */
- (BOOL)checkAllPhoneNum;

/**
 *  身份证校验
 */
- (BOOL)checkID;

/**
 *  银行卡号检测
 */
+ (BOOL)validateBankCardNumber: (NSString *)bankCardNumber;

/**
 *  校验密码
 */
- (BOOL)checkPassword;

/**
 *  转义字符
 */
- (NSString *)urlEncode;

/**
 *  计算文字尺寸
 */
- (CGSize)calculateFontOfSize:(CGFloat)size width:(CGFloat)width;

/**
 *  检测字符串是否包含表情
 */
+ (BOOL)isContainsEmoji:(NSString *)string;

/**
 *  去除字符串空格
 */
- (NSString *)removeBlank;

/**
 *  获取URL参数
 */
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr;

/// 判断是否含有非法字符 yes 有  no没有
- (BOOL)JudgeTheillegalCharacter;

/// 检查包含字符
- (BOOL)checkIncludeString;

#pragma mark - 字符串转换时间
/// 字符串时间转换为标准时间
- (NSDate *)stringToCommonDate;
/// 转化为年月日
- (NSString *)stringToYYYYMMDDsString;

/// 判断字符串是否包含表情
- (BOOL)stringContainsEmoji;

/// 判断字符是否包含字母
- (BOOL)stringContainsEnglish;

/// 判断字符是否包含中文
- (BOOL)stringContainsChinese;


/// 添加文字间距
- (NSMutableAttributedString *)addLineSpaceWithfont:(UIFont *)font lineSpace:(CGFloat)lineSpace color:(UIColor *)color;


@end
