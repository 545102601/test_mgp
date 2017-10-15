//
//  MGUITool.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/14.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGUITool : NSObject

#pragma Mark - Label区

/// 快速创建Label
+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                      font:(UIFont *)font;


/// 快速创建Label
+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                      font:(UIFont *)font
             textAlignment:(NSTextAlignment)alignment;


#pragma Mark - Button区
/// 快速创建按钮 - 普通
+ (UIButton *)buttonWithBGColor:(UIColor *)bgColor
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor
                           font:(UIFont *)font
                         target:(id)target
                       selector:(SEL)sel;

+ (UIButton *)buttonWithNorBgImage:(UIImage *)norBgImage
                     selBgImage:(UIImage *)selBgImage
                       norImage:(UIImage *)norImage
                       selImage:(UIImage *)selImage
                         target:(id)target
                       selector:(SEL)sel;

/// 快速创建按钮 - 完整
+ (UIButton *)buttonWithBGColor:(UIColor *)bgColor
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor
                       selTitle:(NSString *)selTitle
                  selTitleColor:(UIColor *)selTitleColor
                           font:(UIFont *)font
                     norBgImage:(UIImage *)norBgImage
                     selBgImage:(UIImage *)selBgImage
                       norImage:(UIImage *)norImage
                       selImage:(UIImage *)selImage
                         target:(id)target
                       selector:(SEL)sel;

/// 设置 按钮 主题
+ (void)setButtonTheme:(UIButton *)btn
                 title:(NSString *)title
            titleColor:(UIColor *)titleColor
         bgImageNColor:(UIColor *)NColor
         bgImageHColor:(UIColor *)HColor;



#pragma mark - UITextField区

/// 快速创建UITextField - 普通
+ (UITextField *)textFieldWithTextColor:(UIColor *)textColor
                                   font:(UIFont *)font;
/// 快速创建UITextField - 带placeHolder
+ (UITextField *)textFieldWithTextColor:(UIColor *)textColor
                                   font:(UIFont *)font
                              placeText:(NSString *)placeText
                             placeColor:(UIColor *)placeColor
                              placeFont:(UIFont *)placeFont;
/// 快速创建UITextField - 带键盘
+ (UITextField *)textFieldWithTextColor:(UIColor *)textColor
                                   font:(UIFont *)font
                              placeText:(NSString *)placeText
                             placeColor:(UIColor *)placeColor
                              placeFont:(UIFont *)placeFont
                           keyboardType:(UIKeyboardType)type
                        clearButtonMode:(UITextFieldViewMode)mode;

/// 快速创建UITextField - 完整
+ (UITextField *)textFieldWithTextColor:(UIColor *)textColor
                                   font:(UIFont *)font
                              placeText:(NSString *)placeText
                             placeColor:(UIColor *)placeColor
                              placeFont:(UIFont *)placeFont
                           keyboardType:(UIKeyboardType)type
                        clearButtonMode:(UITextFieldViewMode)mode
                                 target:(id)target
                               selector:(SEL)sel;



#pragma mark - UIBarButtonItem
/// UIBarButtonItem - 用按钮创建
+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target selector:(SEL)selector;


+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

@end
