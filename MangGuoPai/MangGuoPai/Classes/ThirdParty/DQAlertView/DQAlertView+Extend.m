//
//  DQAlertView+Extend.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "DQAlertView+Extend.h"
#import "UITextField+Extend.h"

#import "RegexKitLite.h"
@interface DQAlertView () <UITextFieldDelegate>

@end

@implementation DQAlertView (Extend)


- (void)setAlertThemeMessageTip_OneButton {
    
    
    self.shouldDismissOnActionButtonClicked = NO;
    
    self.appearAnimationType = DQAlertViewAnimationTypeZoomIn;
    self.disappearAnimationType = DQAlertViewAnimationTypeFaceOut;
    self.appearTime = 0.25;
    self.disappearTime = 0.25;
    self.dimAlpha = 0.6;
    
    [self.cancelButton setTitleColor:MGThemeBackgroundColor  forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = PFSC(32);
    self.messageLabel.font = PFSC(26);
    self.messageLabel.textColor = MGThemeColor_Common_Black;
    self.titleLabel.font = PFSC(32);
    self.titleLabel.textColor = MGThemeColor_Common_Black;
    
    self.separatorColor = MGSepColor;
    
    [self setBackgroundColor:[UIColor whiteColor]];
}


- (void)setAlertThemeMessageTip_TwoButton {
    
//    self.shouldDismissOnActionButtonClicked = NO;
    
    self.appearAnimationType = DQAlertViewAnimationTypeZoomIn;
    self.disappearAnimationType = DQAlertViewAnimationTypeFaceOut;
    self.appearTime = 0.25;
    self.disappearTime = 0.25;
    self.dimAlpha = 0.6;
    
    [self.cancelButton setTitleColor:MGThemeColor_subTitle_Black forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = PFSC(32);
    
    [self.otherButton setTitleColor:MGThemeBackgroundColor forState:UIControlStateNormal];
    self.otherButton.titleLabel.font = PFSC(32);
    
    
    self.messageLabel.font = PFSC(26);
    self.messageLabel.textColor = MGThemeColor_Common_Black;
    
    self.titleLabel.font = PFSC(32);
    self.titleLabel.textColor = MGThemeColor_Common_Black;
    
    self.separatorColor = MGSepColor;
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    
}

- (void)setAlertThemeWithTextFieldForApplyWork {
    
    /// 背景
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SW(592), SH(240))];
    
    UILabel *titleLabel = [MGUITool labelWithText:@"集结暗号" textColor:MGThemeColor_Title_Black font:PFSC(30) textAlignment:NSTextAlignmentCenter];
    titleLabel.frame = CGRectMake(SW(52), SH(50), tempView.width - 2 * SW(52) , titleLabel.fontLineHeight);
    
    UITextField *inputTextFiled = [[UITextField alloc] init];
    inputTextFiled.frame = CGRectMake(SW(22),titleLabel.bottom + SH(38), tempView.width - 2 * SW(22), SH(70));
    inputTextFiled.tag = 100001;
    inputTextFiled.font = PFSC(28);
    inputTextFiled.textColor = MGThemeColor_Title_Black;
    inputTextFiled.layer.borderColor = MGSepColor.CGColor;
    inputTextFiled.layer.borderWidth = MGSepLineHeight;
    inputTextFiled.layer.cornerRadius = SW(3);
    inputTextFiled.placeholder = @"请输入集结暗号";
    inputTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    inputTextFiled.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SW(20), inputTextFiled.height)];
    inputTextFiled.leftViewMode = UITextFieldViewModeAlways;
    /// 限制数字
    [inputTextFiled limitTextLength:4];
    
    inputTextFiled.delegate = self;
    
    [tempView addSubview:titleLabel];
    [tempView addSubview:inputTextFiled];
    
    self.contentView = tempView;
    
    self.shouldDimBackgroundWhenShowInView = YES;
    self.shouldDismissOnActionButtonClicked = NO;
}


#pragma mark - UITextFiedlDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    /// 屏蔽表情
    if ([string stringContainsEmoji]) {
        return NO;
    }
    
    return YES;
}


@end
