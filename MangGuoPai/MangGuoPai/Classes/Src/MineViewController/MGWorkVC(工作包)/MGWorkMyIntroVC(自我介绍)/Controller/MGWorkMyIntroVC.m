//
//  MGWorkMyIntroVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/11/15.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkMyIntroVC.h"
#import "UITextView+Placeholder.h"

@interface MGWorkMyIntroVC () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UILabel *phoneTipLabel;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UIView *phoneLineView;


@property (nonatomic, strong) UILabel *qqTipLabel;
@property (nonatomic, strong) UITextField *qqTextField;
@property (nonatomic, strong) UIView *qqLineView;

@property (nonatomic, strong) UITextView *introTextView;

@end

@implementation MGWorkMyIntroVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    _phoneTipLabel = [MGUITool labelWithText:@"如果你有团队的集结号，直接加入: "
                                    textColor:MGThemeColor_Black
                                         font:PFSC(30)];
    _phoneTipLabel.frame = CGRectMake(SW(30), SH(30) + 64, SW(120), _phoneTipLabel.fontLineHeight);
    
    _phoneTextField = [MGUITool textFieldWithTextColor:MGThemeColor_Common_Black
                                                  font:MGThemeFont_28
                                             placeText:@"请输入11位手机号码"
                                            placeColor:MGTextPlaceholderColor
                                             placeFont:MGThemeFont_28
                                          keyboardType:UIKeyboardTypeNumberPad
                                       clearButtonMode:UITextFieldViewModeWhileEditing];
    [_phoneTextField limitTextLength:11];
    _phoneTextField.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    
    
}

#pragma mark - 加载数据
- (void)loadData {

}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

@end
