//
//  MGRegisterInfoVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/1.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGRegisterInfoVC.h"

@interface MGRegisterInfoVC () <UITextFieldDelegate>

/// 头像
@property (nonatomic, strong) UIButton *leftIconButton;
@property (nonatomic, strong) UIButton *rightIconButton;

/// 名称
@property (nonatomic, strong) UIView *nameBgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIView *lineView;

/// 完成
@property (nonatomic, strong) UIButton *finishButton;


@end

@implementation MGRegisterInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"你离芒果派只差一步";
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 初始化控件
- (void)setupSubViews {

    
    _leftIconButton = [MGUITool buttonWithBGColor:nil title:nil titleColor:nil selTitle:nil selTitleColor:nil font:nil norBgImage:[UIImage imageNamed:@"mine_user_women"] selBgImage:nil norImage:nil selImage:nil target:self selector:@selector(leftIconButtonOnClick)];
    [self changeButton:_leftIconButton];
    
    _rightIconButton = [MGUITool buttonWithBGColor:nil title:nil titleColor:nil selTitle:nil selTitleColor:nil font:nil norBgImage:[UIImage imageNamed:@"mine_user_man"] selBgImage:nil norImage:nil selImage:nil target:self selector:@selector(rightIconButtonOnClick)];
    
    _nameBgView = [UIView new];
    
    _nameLabel = [MGUITool labelWithText:@"昵称  : " textColor:MGThemeColor_Common_Black font:MGThemeFont_30];
    
    _nameTextField = [MGUITool textFieldWithTextColor:MGThemeColor_Common_Black font:MGThemeFont_30 placeText:@"昵称不能超过20个字符或10个中文" placeColor:MGTextPlaceholderColor placeFont:MGThemeFont_30];
    [_nameTextField limitTextLength:10];
    _nameTextField.delegate = self;
    [_nameTextField addTarget:self
                        action:@selector(textFiledChange:)
              forControlEvents:UIControlEventAllEditingEvents];
    _lineView = [UIView new];
    _lineView.backgroundColor = MGSepColor;
    
    
    _finishButton = [MGUITool buttonWithBGColor:nil title:@"完成" titleColor:MGThemeColor_Black font:MGThemeFont_36 target:self selector:@selector(finishOnClick)];
    [_finishButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_finishButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    [_finishButton setBackgroundImage:[UIImage imageWithColor:colorHex(@"#f5f5f6")] forState:UIControlStateDisabled];
    _finishButton.enabled = NO;
    
    [_nameBgView sd_addSubviews:@[_nameLabel, _nameTextField, _lineView]];
    
    [self.view sd_addSubviews:@[_leftIconButton, _rightIconButton, _nameBgView, _finishButton]];
    
}

#pragma mark - 布局控件
- (void)setupSubViewsFrame {

    
    _leftIconButton.sd_layout
    .topSpaceToView(self.view, 64 + SH(84))
    .leftSpaceToView(self.view, SW(182))
    .widthIs(SW(168))
    .heightEqualToWidth();
    
    _rightIconButton.sd_layout
    .topSpaceToView(self.view, 64 + SH(84))
    .leftSpaceToView(_leftIconButton, SW(54))
    .widthIs(SW(168))
    .heightEqualToWidth();
    
    
    _nameBgView.sd_layout
    .topSpaceToView(_leftIconButton, SH(152))
    .leftSpaceToView(self.view, SW(74))
    .rightSpaceToView(self.view, SW(74))
    .heightIs(SH(64));
    
    
    _nameLabel.sd_layout
    .topEqualToView(_nameBgView)
    .leftEqualToView(_nameBgView)
    .widthIs(SW(100))
    .heightIs(SH(40));
    
    _nameTextField.sd_layout
    .topEqualToView(_nameLabel)
    .leftSpaceToView(_nameLabel, 0)
    .rightEqualToView(_nameBgView)
    .heightIs(SH(40));
    
    _lineView.sd_layout
    .bottomEqualToView(_nameBgView)
    .leftEqualToView(_nameBgView)
    .rightEqualToView(_nameBgView)
    .heightIs(MGSepLineHeight);
    
    
    _finishButton.sd_layout
    .topSpaceToView(_nameBgView, SH(216))
    .leftSpaceToView(self.view, SW(74))
    .rightSpaceToView(self.view, SW(74))
    .heightIs(SH(84));

    
    _leftIconButton.sd_cornerRadiusFromWidthRatio = @0.5;
    
    _rightIconButton.sd_cornerRadiusFromWidthRatio = @0.5;
    
    _finishButton.sd_cornerRadius = @(MGButtonLayerCorner);
}



#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 左边
- (void)leftIconButtonOnClick {
    
    [self changeButton:_leftIconButton];
    
    
}
/// 右边
- (void)rightIconButtonOnClick {
    
    [self changeButton:_rightIconButton];
}

- (void)changeButton:(UIButton *)button {
    
    _leftIconButton.selected = NO;
    
    _rightIconButton.selected = NO;
    
    
    _leftIconButton.layer.borderColor = [UIColor clearColor].CGColor;
    _leftIconButton.layer.borderWidth = SW(0);
    
    
    _rightIconButton.layer.borderColor = [UIColor clearColor].CGColor;
    _rightIconButton.layer.borderWidth = SW(0);
    
    button.selected = YES;
    button.layer.borderColor = MGThemeYellowColor.CGColor;
    button.layer.borderWidth = SW(3);
    
    
}
- (void)textFiledChange:(UITextField *)textField {
    NSString *text = [self.nameTextField.text removeBlank];
    _finishButton.enabled = text.length > 0;
    
}
/// 完成
- (void)finishOnClick {
    NSString *text = [self.nameTextField.text removeBlank];
    if (text.length == 0) {
        [self showMBText:@"请填写昵称~"];
    }
    NSInteger gender = self.leftIconButton.isSelected ? 0 : 1;
    
    [MGBussinessRequest postUpdate_Member:@{@"nick_name" : text, @"gender" : @(gender)} isNeedHUD:YES successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            
            /// 发送登录成功通知
            [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessRefreshTable object:nil];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self showMBText:message];
        }
    } errorBlock:nil];
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string stringContainsEmoji]) {
        return NO;
    }
    return  YES;
}


#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

@end
