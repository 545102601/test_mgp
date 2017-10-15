//
//  MGRegisterVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/1.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGRegisterVC.h"
#import "MGRegisterInfoVC.h"

@interface MGRegisterVC ()
/// 背景
@property (nonatomic, strong) UIView *bgView;

/// 手机
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UIView *lineView;
/// 短信
@property (nonatomic, strong) UILabel *msgLabel;
@property (nonatomic, strong) UITextField *msgTextField;
@property (nonatomic, strong) UIButton *msgButton;
/// 下一步
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation MGRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"初次注册";
    
}



#pragma mark - 初始化控件
- (void)setupSubViews {

    
    _bgView = [UIView new];
    _bgView.backgroundColor = [UIColor whiteColor];
    
    
    _phoneLabel = [MGUITool labelWithText:@"手机号码：" textColor:MGThemeColor_Common_Black font:MGThemeFont_28];
    
    _phoneTextField = [MGUITool textFieldWithTextColor:MGThemeColor_Common_Black font:MGThemeFont_28 placeText:@"请输入手机号码" placeColor:MGTextPlaceholderColor placeFont:MGThemeFont_28 keyboardType:UIKeyboardTypeNumberPad
                                       clearButtonMode:UITextFieldViewModeWhileEditing];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = MGSepColor;
    
    
    _msgLabel = [MGUITool labelWithText:@"验证码：" textColor:MGThemeColor_Common_Black font:MGThemeFont_28];
    
    _msgTextField = [MGUITool textFieldWithTextColor:MGThemeColor_Common_Black font:MGThemeFont_28 placeText:@"请输入短信验证码" placeColor:MGTextPlaceholderColor placeFont:MGThemeFont_28 keyboardType:UIKeyboardTypeNumberPad
                                     clearButtonMode:UITextFieldViewModeWhileEditing];
    
    _msgButton = [MGUITool buttonWithBGColor:nil title:@"获取验证码" titleColor:MGThemeShenYellowColor font:MGThemeFont_28 target:self selector:@selector(msgButtonOnClick)];
    _msgButton.contentMode = UIViewContentModeRight;
    
    
    _nextButton = [MGUITool buttonWithBGColor:nil title:@"下一步" titleColor:MGThemeColor_Black font:MGThemeFont_36 target:self selector:@selector(nextButtonOnClick)];
    [_nextButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_nextButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    
    
    
    [_bgView sd_addSubviews:@[ _phoneLabel, _phoneTextField, _lineView, _msgLabel, _msgTextField, _msgButton]];
    
    [self.view addSubview:_bgView];
    [self.view addSubview:_nextButton];
    
}

#pragma mark - 布局控件
- (void)setupSubViewsFrame {

    
    _bgView.sd_layout
    .topSpaceToView(self.view, 64)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(SH(98) * 2);
    
    
    
    
    _phoneLabel.sd_layout
    .centerYIs(SH(98) * 0.5)
    .leftSpaceToView(_bgView, SW(30))
    .widthIs(SW(150))
    .heightIs(SH(40));
    
    
    _phoneTextField.sd_layout
    .centerYEqualToView(_phoneLabel)
    .leftSpaceToView(_phoneLabel, SW(10))
    .rightSpaceToView(_bgView, SW(30))
    .heightIs(SH(40));
    
    _lineView.sd_layout
    .topSpaceToView(_bgView, SH(98))
    .leftSpaceToView(_bgView, SW(24))
    .rightSpaceToView(_bgView, SW(24))
    .heightIs(MGSepLineHeight);
    
    
    _msgLabel.sd_layout
    .centerYIs(SH(98) + SH(98) * 0.5)
    .leftEqualToView(_phoneLabel)
    .widthIs(SW(120))
    .heightIs(SH(40));
    
    
    _msgButton.sd_layout
    .centerYEqualToView(_msgLabel)
    .rightSpaceToView(_bgView, SW(10))
    .widthIs(SW(150))
    .heightIs(SH(44));
    
    _msgTextField.sd_layout
    .centerYEqualToView(_msgLabel)
    .leftSpaceToView(_msgLabel, SW(30))
    .rightSpaceToView(_msgButton, SW(10))
    .heightIs(SH(40));
    
    
    _nextButton.sd_layout
    .topSpaceToView(_bgView, SH(60))
    .leftSpaceToView(self.view, SW(74))
    .rightSpaceToView(self.view, SW(74))
    .heightIs(SH(84));
    
    
    _nextButton.sd_cornerRadius = @(MGButtonLayerCorner);
}


#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 短信验证码
- (void)msgButtonOnClick {
    
    
}
/// 下一步
- (void)nextButtonOnClick {
    
    MGRegisterInfoVC *vc = [MGRegisterInfoVC new];
    PushVC(vc)
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

@end
