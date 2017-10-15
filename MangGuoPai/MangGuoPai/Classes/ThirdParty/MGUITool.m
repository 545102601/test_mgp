//
//  MGUITool.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/14.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGUITool.h"

@implementation MGUITool


+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                      font:(UIFont *)font {
    return [self.class labelWithText:text textColor:textColor font:font textAlignment:0];
}

+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                      font:(UIFont *)font
             textAlignment:(NSTextAlignment)alignment {
    UILabel *label = [[UILabel alloc] init];
    if (textColor) {
        label.textColor = textColor;
    }
    if (font) {
        label.font = font;
    }
    if (text) {
        label.text = text;
    }
    label.textAlignment = alignment;
    label.numberOfLines = 0;
    
    return label;
}

+ (UIButton *)buttonWithBGColor:(UIColor *)bgColor
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor
                           font:(UIFont *)font
                         target:(id)target
                       selector:(SEL)sel {
    
    return [self.class buttonWithBGColor:bgColor title:title titleColor:titleColor selTitle:nil selTitleColor:nil font:font norBgImage:nil selBgImage:nil norImage:nil selImage:nil target:target selector:sel];
    
}


+ (UIButton *)buttonWithNorBgImage:(UIImage *)norBgImage
                        selBgImage:(UIImage *)selBgImage
                          norImage:(UIImage *)norImage
                          selImage:(UIImage *)selImage
                            target:(id)target
                          selector:(SEL)sel {
   return [self.class buttonWithBGColor:nil title:nil titleColor:nil selTitle:nil selTitleColor:nil font:nil norBgImage:norBgImage selBgImage:selBgImage norImage:norImage selImage:selImage target:target selector:sel];
}
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
                       selector:(SEL)sel {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (bgColor) {
        button.backgroundColor = bgColor;
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (selTitle) {
        [button setTitle:selTitle forState:UIControlStateSelected];
    }
    if (selTitleColor) {
        [button setTitleColor:selTitleColor forState:UIControlStateSelected];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    
    if (norBgImage) {
        [button setBackgroundImage:norBgImage forState:UIControlStateNormal];
    }
    
    if (selBgImage) {
        [button setBackgroundImage:selBgImage forState:UIControlStateSelected];
    }
    if (norImage) {
        [button setImage:norImage forState:UIControlStateNormal];
    }
    
    if (selImage) {
        [button setImage:selImage forState:UIControlStateSelected];
    }
    
    if (target && sel) {
        [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}


/// 设置 按钮 主题
+ (void)setButtonTheme:(UIButton *)btn
                 title:(NSString *)title
            titleColor:(UIColor *)titleColor
         bgImageNColor:(UIColor *)NColor
         bgImageHColor:(UIColor *)HColor {

    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:NColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:HColor] forState:UIControlStateHighlighted];
}
#pragma mark - UITextField


+ (UITextField *)textFieldWithTextColor:(UIColor *)textColor
                                   font:(UIFont *)font {
    return [self.class textFieldWithTextColor:textColor font:font placeText:nil placeColor:nil placeFont:nil];
}

+ (UITextField *)textFieldWithTextColor:(UIColor *)textColor
                                   font:(UIFont *)font
                              placeText:(NSString *)placeText
                             placeColor:(UIColor *)placeColor
                              placeFont:(UIFont *)placeFont {

    return [self.class textFieldWithTextColor:textColor font:font placeText:placeText placeColor:placeColor placeFont:placeFont keyboardType:UIKeyboardTypeDefault clearButtonMode:UITextFieldViewModeNever];
}

+ (UITextField *)textFieldWithTextColor:(UIColor *)textColor
                                   font:(UIFont *)font
                              placeText:(NSString *)placeText
                             placeColor:(UIColor *)placeColor
                              placeFont:(UIFont *)placeFont
                           keyboardType:(UIKeyboardType)type
                        clearButtonMode:(UITextFieldViewMode)mode {
    return [self.class textFieldWithTextColor:textColor font:font placeText:placeText placeColor:placeColor placeFont:placeFont keyboardType:type clearButtonMode:mode target:nil selector:nil];
}



+ (UITextField *)textFieldWithTextColor:(UIColor *)textColor
                                   font:(UIFont *)font
                              placeText:(NSString *)placeText
                             placeColor:(UIColor *)placeColor
                              placeFont:(UIFont *)placeFont
                           keyboardType:(UIKeyboardType)type
                        clearButtonMode:(UITextFieldViewMode)mode
                                 target:(id)target
                               selector:(SEL)sel {

    UITextField *textField = [[UITextField alloc] init];
    if (font) {
        textField.font = font;
    }
    if (textColor) {
        textField.textColor = textColor;
    }
    if (placeText) {
        textField.placeholder = placeText;
    }
    
    if (placeColor) {
        [textField setValue:placeColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    if (placeFont) {
        [textField setValue:placeFont forKeyPath:@"_placeholderLabel.font"];
    }
    if (type != UIKeyboardTypeDefault) {
        textField.keyboardType = type;
    }
    if (mode != UITextFieldViewModeNever) {
        textField.clearButtonMode = mode;
    }
    if (target && sel) {
        
        [textField addTarget:target
                      action:sel
            forControlEvents:UIControlEventAllEditingEvents];
        
    }
    
    return textField;
}



#pragma mark - UIBarButtonItem

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target selector:(SEL)selector {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    if (font) {
        button.titleLabel.font = font;
    }
    [button sizeToFit];
    if (target && selector) {
        [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barItem;
    
}


+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setBounds:lineView.bounds];
    
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    
    //  设置虚线颜色为blackColor
    
    [shapeLayer setStrokeColor:lineColor.CGColor];
    
    //  设置虚线宽度
    
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    //  设置路径
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 0, 0);
    
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    
    [shapeLayer setPath:path];
    
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    
    [lineView.layer addSublayer:shapeLayer];
    
}
@end
