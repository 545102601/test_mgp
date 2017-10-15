//
//  UITextField+Extend.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "UITextField+Extend.h"
#import <objc/runtime.h>

@implementation UITextField (Extend)

static NSString *kLimitTextLengthKey = @"kLimitTextLengthKey";
- (void)limitTextLength:(int)length
{
    objc_setAssociatedObject(self, (__bridge const void *)(kLimitTextLengthKey), [NSNumber numberWithInt:length], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addTarget:self action:@selector(textFieldTextLengthLimit:) forControlEvents:UIControlEventEditingChanged];
    
}
- (void)textFieldTextLengthLimit:(id)sender
{
    NSNumber *lengthNumber = objc_getAssociatedObject(self, (__bridge const void *)(kLimitTextLengthKey));
    int length = [lengthNumber intValue];
    //下面是修改部分
    bool isChinese;//判断当前输入法是否是中文
    NSArray *currentar = [UITextInputMode activeInputModes];
    UITextInputMode *current = [currentar firstObject];
    //[[UITextInputMode currentInputMode] primaryLanguage]，废弃的方法
    if ([current.primaryLanguage isEqualToString: @"en-US"]) {
        isChinese = false;
    }
    else
    {
        isChinese = true;
    }
    
    if(sender == self) {
        // length是自己设置的位数
        NSString *str = [[self text] stringByReplacingOccurrencesOfString:@"?" withString:@""];
        if (isChinese) { //中文输入法下
            UITextRange *selectedRange = [self markedTextRange];
            //获取高亮部分
            UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                NSString *maxText;
                BOOL result = [TDCommonTool textFieldLimitConditionWithText:str length:length * 2 outMaxText:&maxText];
                
                if (result) {
                    
                    [self setText:maxText];
                }
            }
            else
            {
                TDLog(@"输入的");
                
            }
        }else{
            if ([str length]>=length) {
                NSString *strNew = [NSString stringWithString:str];
                [self setText:[strNew substringToIndex:length]];
            }
        }
    }
}


-(void)addLeftBlankViewWithWidth:(CGFloat )width{
    
    UIView *lockIv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, self.bounds.size.height)];
    
    self.leftView = lockIv;
    
    self.leftViewMode = UITextFieldViewModeAlways;
    
}

-(void)addLeftViewWithImage:(NSString *)image{
    
    UIImageView *lockIv = [[UIImageView alloc] init];
    
    // 设置尺寸
    CGRect imageBound = self.bounds;
    // 宽度高度一样
    imageBound.size.width = imageBound.size.height;
    lockIv.bounds = imageBound;
    
    // 设置图片
    lockIv.image = [UIImage imageNamed:image];
    
    
    // 添加TextFiled的左边视图
    self.leftView = lockIv;
    
    // 设置TextField左边的总是显示
    self.leftViewMode = UITextFieldViewModeAlways;
}




-(void)addRightViewWithImage:(NSString *)image target:(id)target selector:(SEL)selector{
    
    UIButton *lockIv = [[UIButton alloc] init];
    CGRect imageBound = self.bounds;
    imageBound.size.width = imageBound.size.height;
    lockIv.bounds = imageBound;
    [lockIv setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [lockIv addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    lockIv.contentMode = UIViewContentModeCenter;
    self.rightView = lockIv;
    self.rightViewMode = UITextFieldViewModeAlways;
}


@end
