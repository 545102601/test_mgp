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

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *phoneTipLabel;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UIView *phoneLineView;


@property (nonatomic, strong) UILabel *qqTipLabel;
@property (nonatomic, strong) UITextField *qqTextField;
@property (nonatomic, strong) UIView *qqLineView;

@property (nonatomic, strong) UITextView *textView;

@end

@implementation MGWorkMyIntroVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自我介绍";
    [self setRightButtonWithTitle:@"保存" target:self selector:@selector(saveButtonOnClick)];
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, SH(490))];
    _bgView.backgroundColor = [UIColor whiteColor];
    
    _phoneTipLabel = [MGUITool labelWithText:@"手机号"
                                    textColor:MGThemeColor_Title_Black
                                         font:PFSC(30)];
    _phoneTipLabel.frame = CGRectMake(SW(30), SH(30), SW(120), _phoneTipLabel.fontLineHeight);
    
    _phoneTextField = [MGUITool textFieldWithTextColor:MGThemeColor_Title_Black
                                                  font:MGThemeFont_28
                                             placeText:@"请输入11位手机号码"
                                            placeColor:MGTextPlaceholderColor
                                             placeFont:MGThemeFont_28
                                          keyboardType:UIKeyboardTypeNumberPad
                                       clearButtonMode:UITextFieldViewModeWhileEditing];
    [_phoneTextField limitTextLength:11];
    _phoneTextField.frame = CGRectMake(_phoneTipLabel.right, 0, SW(580), SH(60));
    _phoneTextField.centerY = _phoneTipLabel.centerY;
    _phoneTextField.text = self.resultDictM[@"mobile"];
    
    _phoneLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), SH(100), kScreenWidth - SW(48), MGSepLineHeight)];
    _phoneLineView.backgroundColor = MGSepColor;
    
    _qqTipLabel = [MGUITool labelWithText:@"QQ号"
                                textColor:MGThemeColor_Title_Black
                                     font:PFSC(30)];
    _qqTipLabel.frame = CGRectMake(SW(30), _phoneLineView.bottom + SH(30), SW(120), _qqTipLabel.fontLineHeight);
    
    _qqTextField = [MGUITool textFieldWithTextColor:MGThemeColor_Title_Black
                                               font:MGThemeFont_28
                                          placeText:@"请输入QQ号"
                                         placeColor:MGTextPlaceholderColor
                                          placeFont:MGThemeFont_28
                                       keyboardType:UIKeyboardTypeNumberPad
                                    clearButtonMode:UITextFieldViewModeWhileEditing];
    
    _qqTextField.frame = CGRectMake(_qqTipLabel.right, 0, SW(580), SH(60));
    _qqTextField.centerY = _qqTipLabel.centerY;
    [_qqTextField limitTextLength:13];
    _qqTextField.text = self.resultDictM[@"qq"];
    _qqLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), SH(200), kScreenWidth - SW(48), MGSepLineHeight)];
    _qqLineView.backgroundColor = MGSepColor;
    
    [_bgView sd_addSubviews:@[_phoneTipLabel, _phoneTextField, _phoneLineView,
                                _qqTipLabel, _qqTextField, _qqLineView]];
    
    
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(SW(30), _qqLineView.bottom + SH(30), kScreenWidth - SW(60), SH(230))];
    _textView.font = PFSC(28);
    _textView.placeholder = @"个人特长";
    _textView.text = self.resultDictM[@"content"];
    _textView.placeholderColor = MGThemeColor_Common_Black;
    _textView.textColor = MGThemeColor_Title_Black;
    _textView.delegate = self;
    
    [_bgView addSubview:_textView];
    
    [self.view addSubview:_bgView];
}

#pragma mark - 加载数据
- (void)loadData {

}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
- (void)saveButtonOnClick {
    
    [self.view endEditing:YES];
    
    NSString *mobile = _phoneTextField.text;
    NSString *qq = _qqTextField.text.length > 0 ? _qqTextField.text : @"";
    NSString *content = _textView.text;
    
    NSMutableString *resultString = @"".mutableCopy;
    
    if (mobile.length == 0) {
        [resultString appendString:@"请输入手机号码、"];
    }
    if (mobile.length > 0) {
        if (![mobile checkPhoneNum]) {
            [resultString appendString:@"请输入正确的手机号码、"];
        }
    }
    if (content.length == 0) {
        [resultString appendString:@"请输入个人特长、"];
    }
    
    if (resultString.length > 0) {
        NSString *alertStr = [resultString substringToIndex:resultString.length - 1];
        DQAlertView *checkAlertView = [[DQAlertView alloc] initWithTitle:nil message:alertStr cancelButtonTitle:@"我知道了" otherButtonTitle:nil];
        [checkAlertView setAlertThemeMessageTip_OneButton];
        [checkAlertView show];
        return;
    } else {
        [self.resultDictM setObject:mobile forKey:@"mobile"];
        [self.resultDictM setObject:qq forKey:@"qq"];
        [self.resultDictM setObject:content forKey:@"content"];
        if (_saveCompletionBlock) {
            _saveCompletionBlock();
        }
        PopVC
    }
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string stringContainsEmoji]) {
        return NO;
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text stringContainsEmoji]) {
        return NO;
    }
    return YES;
}

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

@end
