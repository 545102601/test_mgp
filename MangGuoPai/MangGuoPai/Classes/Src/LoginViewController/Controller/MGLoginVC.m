//
//  MGLoginVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/6/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGLoginVC.h"
#import <YYText.h>
#import "MGRegisterVC.h"
#import "MGLoginModel.h"
#import "UIButton+countDown.h"
#import "MGResLoginModel.h"
#import "MGCommonWKWebViewVC.h"
#import "MGRegisterInfoVC.h"

@interface MGLoginVC ()
/// 顶部背景图
@property (nonatomic, strong) UIImageView *bananerImageView;
/// 内容
@property (nonatomic, strong) UIView *contentView;
/// 账号
@property (nonatomic, strong) UIView *phoneBgView;
@property (nonatomic, strong) UIImageView *phoneImageView;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UIView *phoneLineView;

/// 短信
@property (nonatomic, strong) UIView *msgBgView;
@property (nonatomic, strong) UIImageView *msgImageView;
@property (nonatomic, strong) UITextField *msgTextField;
@property (nonatomic, strong) UIView *msgVLineView;
@property (nonatomic, strong) UIButton *msgButton;
@property (nonatomic, strong) UIView *msgLineView;

/// 登录按钮
@property (nonatomic, strong) UIButton *loginButton;


@property (nonatomic, strong) UIView *thirdPartyLoginView;
@property (nonatomic, strong) UILabel *thirdLabel;
@property (nonatomic, strong) UIButton *thirdWeChatButton;

/// 协议
@property (nonatomic, strong) YYLabel *serviceLabel;

/// 第三方登录模型
@property (nonatomic, strong) MGLoginModel *loginModel;

@end

@implementation MGLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录芒果派";
    
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    
    _bananerImageView = [[UIImageView alloc] init];
    _bananerImageView.image = [UIImage imageNamed:@"login_bg_login"];
    
    _contentView = [[UIView alloc] init];
    
    _phoneBgView = [[UIView alloc] init];
    
    _phoneImageView = [[UIImageView alloc] init];
    _phoneImageView.image = [UIImage imageNamed:@"login_iphone"];
    
    _phoneTextField = [MGUITool textFieldWithTextColor:MGThemeColor_Common_Black font:MGThemeFont_28 placeText:@"请输入11位手机号码" placeColor:MGTextPlaceholderColor placeFont:MGThemeFont_28 keyboardType:UIKeyboardTypeNumberPad
                                       clearButtonMode:UITextFieldViewModeWhileEditing];
    [_phoneTextField limitTextLength:11];
    
    
    _phoneLineView = [UIView new];
    _phoneLineView.backgroundColor = MGSepColor;
    
    
    _msgBgView = [[UIView alloc] init];
    
    _msgImageView = [[UIImageView alloc] init];
    _msgImageView.image = [UIImage imageNamed:@"login_yanzhengma"];
    
    _msgTextField = [MGUITool textFieldWithTextColor:MGThemeColor_Common_Black font:MGThemeFont_28 placeText:@"请输入验证码" placeColor:MGTextPlaceholderColor placeFont:MGThemeFont_28 keyboardType:UIKeyboardTypeNumberPad
                                     clearButtonMode:UITextFieldViewModeWhileEditing];
    
    _msgButton = [MGUITool buttonWithBGColor:nil title:@"获取验证码" titleColor:MGThemeShenYellowColor font:MGThemeFont_28 target:self selector:@selector(msgButtonOnClick)];
    _msgButton.contentMode = UIViewContentModeRight;
    
    
    _msgVLineView = [UIView new];
    _msgVLineView.backgroundColor = MGSepColor;
    
    
    _msgLineView = [UIView new];
    _msgLineView.backgroundColor = MGSepColor;
    
    
    _loginButton = [MGUITool buttonWithBGColor:nil title:@"登录" titleColor:MGThemeColor_Black font:MGThemeFont_36 target:self selector:@selector(loginButtonOnClick)];
    [_loginButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    
    _thirdPartyLoginView = [[UIView alloc] init];
    
    _thirdLabel = [MGUITool labelWithText:@"使用微信登录" textColor:colorHex(@"#bfbfbf") font:MGThemeFont_24];
    _thirdLabel.textAlignment = NSTextAlignmentCenter;
    /// 微信登录
    _thirdWeChatButton = [MGUITool buttonWithNorBgImage:nil selBgImage:nil norImage:[UIImage imageNamed:@"login_wechat"] selImage:nil target:self selector:@selector(weChatButtonOnClick:)];
    _thirdWeChatButton.tag = 1001;
    /// 协议
    _serviceLabel = [[YYLabel alloc] init];
    _serviceLabel.userInteractionEnabled = YES;
    [self prepareServiceLabel];
    
    [_phoneBgView sd_addSubviews:@[_phoneImageView, _phoneTextField, _phoneLineView]];
    
    [_msgBgView sd_addSubviews:@[_msgImageView, _msgTextField, _msgButton, _msgVLineView, _msgLineView]];
    
    [_thirdPartyLoginView sd_addSubviews:@[_thirdLabel, _thirdWeChatButton]];
    
    [_contentView sd_addSubviews:@[_phoneBgView, _msgBgView, _loginButton, _thirdPartyLoginView]];
    
    [self.view sd_addSubviews:@[_bananerImageView, _contentView, _serviceLabel]];
    
    
}

#pragma mark - 布局控件
- (void)setupSubViewsFrame {

    _bananerImageView.sd_layout
    .topSpaceToView(self.view, 64)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(SH(325));

    
    _phoneBgView.sd_layout
    .topSpaceToView(_contentView, SH(110))
    .leftSpaceToView(_contentView, SW(74))
    .rightSpaceToView(_contentView, SW(74))
    .heightIs(SH(64));
    
    
    _phoneImageView.sd_layout
    .topSpaceToView(_phoneBgView, 0)
    .leftSpaceToView(_phoneBgView, SW(52))
    .widthIs(SW(44))
    .heightEqualToWidth();
    
    
    _phoneTextField.sd_layout
    .leftSpaceToView(_phoneImageView, SW(50))
    .rightSpaceToView(_phoneBgView, 0)
    .centerYEqualToView(_phoneImageView)
    .heightIs(SH(40));
    
    _phoneLineView.sd_layout
    .bottomEqualToView(_phoneBgView)
    .leftEqualToView(_phoneBgView)
    .rightEqualToView(_phoneBgView)
    .heightIs(MGSepLineHeight);
    
    
    _msgBgView.sd_layout
    .topSpaceToView(_phoneBgView, SH(68))
    .leftSpaceToView(_contentView, SW(74))
    .rightSpaceToView(_contentView, SW(74))
    .heightIs(SH(64));
    
    
    _msgImageView.sd_layout
    .topSpaceToView(_msgBgView, 0)
    .leftSpaceToView(_msgBgView, SW(52))
    .widthIs(SW(44))
    .heightEqualToWidth();
    
    
    _msgButton.sd_layout
    .centerYEqualToView(_msgImageView)
    .rightSpaceToView(_msgBgView, 0)
    .widthIs(SW(150))
    .heightIs(SH(44));
    
    
    _msgVLineView.sd_layout
    .centerYEqualToView(_msgImageView)
    .rightSpaceToView(_msgButton, SW(40))
    .widthIs(MGSepLineHeight)
    .heightIs(SH(40));
    
    _msgTextField.sd_layout
    .leftSpaceToView(_msgImageView, SW(50))
    .rightSpaceToView(_msgVLineView, SW(40))
    .centerYEqualToView(_msgImageView)
    .heightIs(SH(40));
    
    _msgLineView.sd_layout
    .bottomEqualToView(_msgBgView)
    .leftEqualToView(_msgBgView)
    .rightEqualToView(_msgBgView)
    .heightIs(MGSepLineHeight);
    
    
    _loginButton.sd_layout
    .topSpaceToView(_msgBgView, SH(60))
    .leftSpaceToView(_contentView, SW(74))
    .rightSpaceToView(_contentView, SW(74))
    .heightIs(SH(84));
    

    _thirdLabel.sd_layout
    .topSpaceToView(_thirdPartyLoginView, 0)
    .leftEqualToView(_thirdPartyLoginView)
    .rightEqualToView(_thirdPartyLoginView)
    .heightIs(_thirdLabel.fontLineHeight);
    
    _thirdWeChatButton.sd_layout
    .topSpaceToView(_thirdLabel, SH(40))
    .centerXEqualToView(_thirdPartyLoginView)
    .widthIs(SW(112))
    .heightIs(SW(112));
    
    _thirdPartyLoginView.sd_layout
    .topSpaceToView(_loginButton, SH(50))
    .leftEqualToView(_contentView)
    .rightEqualToView(_contentView)
    .heightIs(SH(200));
    
    _contentView.sd_layout
    .topSpaceToView(_bananerImageView, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(SH(972));
    
    _loginButton.sd_cornerRadius = @(MGButtonLayerCorner);
    
    
    _serviceLabel.sd_layout
    .bottomSpaceToView(self.view, SH(60))
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(_serviceLabel.attributedText.yy_font.lineHeight);
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 获取短信验证码
- (void)msgButtonOnClick {
    
    [self.view endEditing:YES];
    
    NSString *phone = self.phoneTextField.text;
    
    if (phone.length == 0) {
        [self showMBText:@"请输入手机号码"];
        return;
    }
    
    if (![[phone removeBlank] checkPhoneNum]) {
        [self showMBText:@"手机号码格式有误，请检查！"];
        return ;
    }

    MGLoginModel *loginModel = [MGLoginModel new];
    loginModel.mobile = phone;
 
    [self requestLoginWithModal:loginModel];
    
}
/// 普通登录
- (void)loginButtonOnClick {
    
    [self.view endEditing:YES];
    
    NSString *phone = self.phoneTextField.text;
    NSString *code = self.msgTextField.text;
    if (phone.length == 0) {
        [self showMBText:@"请输入手机号码"];
        return;
    }
    
    if (![[phone removeBlank] checkPhoneNum]) {
        [self showMBText:@"手机号码格式有误，请检查！"];
        return ;
    }
    
    if (code.length == 0) {
        [self showMBText:@"请输入短信验证码"];
        return;
    }
    
    
    MGLoginModel *loginModel = [MGLoginModel new];
    loginModel.mobile = phone;
    loginModel.sms_code = code;
    loginModel.lst_sessid = [SESSION_MANAGER getSessionId];
    
    [self requestLoginWithModal:loginModel];

    
}
/// 微信登录
- (void)weChatButtonOnClick:(UIButton *)button {
    
    [self.view endEditing:YES];

    if(![PPShareManager isWXAppInstalled]) {
        [self showMBText:@"请先安装微信"];
        return;
    }
    
    [self thirdPartLoginButtonClick:button];
    
//    MGRegisterVC *reigsterVc = [[MGRegisterVC alloc] init];
//    PushVC(reigsterVc);
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

- (void)requestLoginWithModal:(MGLoginModel *)loginModel {
    
    /// 设置已经登录
    [SESSION_MANAGER setLogin:YES];
    
    /// 存 Uid
//    [SESSION_MANAGER setCurrentUserUid:@"16"];
    
//    [SESSION_MANAGER setSessionId:@"aa994a74-d7b4-47bf-b427-9b5e6545ebba"];
    
    /// 存 Uid
    [SESSION_MANAGER setCurrentUserUid:@"14"];
    
    [SESSION_MANAGER setSessionId:@"a84c38c1-a57d-4587-a7a7-e1c2bac58cf5"];
   
    /// 存 Uid
//    [SESSION_MANAGER setCurrentUserUid:@"17"];
    
//    [SESSION_MANAGER setSessionId:@"bab864d3-55d5-43f5-bb5d-fc7452de002a"];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    /// 发送登录成功通知
    [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessRefreshTable object:nil];

    [SESSION_MANAGER setUpgradeView:NO];
    
    
    return;
    WEAK
    [MGBussinessRequest postUserQuickLogin:loginModel successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        STRONG
        if (isSuccess) { /// 登录成功
//            [self showMBText:@"登录成功"];
            MGResLoginModel *resLoginModel = [MGResLoginModel mj_objectWithKeyValues:dic];
          
            /// 设置已经登录
            [SESSION_MANAGER setLogin:YES];
            
            /// 存 Uid
            [SESSION_MANAGER setCurrentUserUid:[NSString stringWithFormat:@"%ld",resLoginModel.data.member.id]];
          
            /// 存 session_id
            if (resLoginModel.data.lst_sessid.length > 0) {
                [SESSION_MANAGER setSessionId:resLoginModel.data.lst_sessid];
            }
            
            /// 去设置昵称
            if (resLoginModel.data.member.nick_name.length == 0) {
                MGRegisterInfoVC *vc = [MGRegisterInfoVC new];
                PushVC(vc);
            } else {
                [self dismissViewControllerAnimated:YES completion:nil];
                
                /// 发送登录成功通知
                [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessRefreshTable object:nil];
            }
            [SESSION_MANAGER setUpgradeView:NO];
            
            
        } else {
            if(![MGLoginModel loginShowErrorCode:code]) {
                [self showMBText:message];
            };
            /// 发送短信成功 开启倒计时
            if ([code isEqualToString:BIZ_ERR_LOGIN_SMSCODE_SEND]) {
                [self.msgButton startWithTime:60 title:@"获取验证码" countDownTitle:@"s" mainColor:nil countColor:nil];
                NSDictionary *dict = dic[@"data"];
                /// 存 session_id
                NSString *session_id = dict[@"lst_sessid"];
                if (session_id.length > 0) {
                    [SESSION_MANAGER setSessionId:session_id];
                }
            }
        }
    } errorBlock:nil];
}


- (void)thirdPartLoginButtonClick:(UIButton *)sender {
    WEAK
    if (sender.tag == 1001) { // 微信
        [[PPShareManager shareInstance] loginWithPlatformType:UMSocialPlatformType_WechatSession
                                        presentViewController:nil
                                                 onCompletion:^(UMSocialUserInfoResponse *accountInfo) {
                                                     STRONG
                                                     TDDetialLog(@"微信第三方登录 - %@", accountInfo);
                                                     self.loginModel.mobile = @"";
                                                     // 保存信息
                                                     self.loginModel.type     = 2;
                                                     self.loginModel.platform = accountInfo.accessToken;
                                                     self.loginModel.open_id  = accountInfo.openid;
                                                     self.loginModel.nickname = accountInfo.name;
                                                     self.loginModel.head_img = accountInfo.iconurl;
                                                     
                                                     // 微信登录
                                                     MGLoginModel *modal = [[MGLoginModel alloc] init];
                                                     modal.type          = 2;
                                                     modal.platform      = accountInfo.accessToken;
                                                     modal.open_id       = accountInfo.openid;
                                                     modal.nickname = accountInfo.name;
                                                     modal.head_img = accountInfo.iconurl;
                                                     
                                                     [self loadWeChatUnionIdWithToken:modal.platform openId:modal.open_id];
//                                                     
//                                                     NSString *weixinHttp = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",modal.platform, modal.open_id];
                                                     
                                                     
                                                 } onError:^(id error) {
                                                     TDDetialLog(@" --- %@", error);
                                                 }];
        
    } else if (sender.tag == 1002) { // QQ
        [[PPShareManager shareInstance] loginWithPlatformType:UMSocialPlatformType_QQ
                                        presentViewController:nil
                                                 onCompletion:^(UMSocialUserInfoResponse *accountInfo) {
                                                     STRONG
                                                     TDDetialLog(@"QQ第三方登录 - %@", accountInfo);
                                                     
                                                     // 保存信息
                                                     
                                                     self.loginModel.mobile = @"";
                                                     self.loginModel.type     = 3;
                                                     self.loginModel.platform = accountInfo.accessToken;
                                                     self.loginModel.open_id  = accountInfo.openid;
                                                     self.loginModel.nickname = accountInfo.name;
                                                     self.loginModel.head_img = accountInfo.iconurl;
                                                     
                                                     // QQ登录
                                                     MGLoginModel *modal = [[MGLoginModel alloc] init];
                                                     modal.type          = 3;
                                                     modal.platform      = accountInfo.accessToken;
                                                     modal.open_id       = accountInfo.openid;
                                                     modal.nickname = accountInfo.name;
                                                     modal.head_img = accountInfo.iconurl;
                                                     [self requestLoginWithModal:modal];
                                                     
                                                 } onError:^(id error) {
                                                     TDDetialLog(@" --- %@", error);
                                                 }];
        
    } else if (sender.tag == 1003) { // 新浪
        [[PPShareManager shareInstance] loginWithPlatformType:UMSocialPlatformType_Sina
                                        presentViewController:nil
                                                 onCompletion:^(UMSocialUserInfoResponse *accountInfo) {
                                                     STRONG
                                                     TDDetialLog(@"新浪第三方登录 - %@", accountInfo);
                                                     
                                                     // 保存信息
                                                     self.loginModel.mobile = @"";
                                                     self.loginModel.type     = 1;
                                                     self.loginModel.platform = accountInfo.accessToken;
                                                     self.loginModel.open_id  = accountInfo.uid;
                                                     self.loginModel.nickname = accountInfo.name;
                                                     self.loginModel.head_img = accountInfo.iconurl;
                                                     
                                                     // 新浪登录
                                                     MGLoginModel *modal = [[MGLoginModel alloc] init];
                                                     modal.type          = 1;
                                                     modal.platform      = accountInfo.accessToken;
                                                     modal.open_id       = accountInfo.uid;
                                                     modal.nickname = accountInfo.name;
                                                     modal.head_img = accountInfo.iconurl;
                                                     [self requestLoginWithModal:modal];
                                                     
                                                 } onError:^(id error) {
                                                     TDDetialLog(@" --- %@", error);
                                                 }];
        
    }
}




- (void)prepareServiceLabel {
    
    NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc] initWithString:@"点击登录即表示已经阅读并接受"];
    attrM.yy_color = colorHex(@"#bfbfbf");
    
    YYTextHighlight *highlight = [YYTextHighlight new];
    [highlight setColor:colorHex(@"#14b2ec")];
    
    
    NSMutableAttributedString *attrM2 = [[NSMutableAttributedString alloc] initWithString:@"《用户服务协议》"];
    attrM2.yy_color = colorHex(@"#14b2ec");
    
    [attrM2 yy_setTextHighlight:highlight range:attrM2.yy_rangeOfAll];
    [attrM appendAttributedString:attrM2];
    
    
#pragma mark - Label点击
    WEAK
    _serviceLabel.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        STRONG
        MGCommonWKWebViewVC *vc = [MGCommonWKWebViewVC new];
        vc.titleString = @"用户服务协议";
        vc.urlString = @"https://www.baidu.com";
        PushVC(vc);
    };
    
    
    attrM.yy_font = MGThemeFont_24;
    attrM.yy_alignment = NSTextAlignmentCenter;
    
    _serviceLabel.attributedText = attrM;
    
}


#pragma mark - 获取微信unionId
- (void)loadWeChatUnionIdWithToken:(NSString *)token openId:(NSString *)openId {
    [TDLoading showViewInKeyWindow];
    [MGBussinessRequest postWXUnionID:@{@"access_token" : token, @"openid" : openId} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        NSString *unionid = dic[@"unionid"];
        if (unionid.length > 0) { /// 请求成功
            [MGBussinessRequest postWXLogin:@{@"open_id" : openId, @"union_id" : unionid} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
                [TDLoading hideViewInKeyWindow];
                
                if (isSuccess) {
                    [self showMBText:@"登录成功"];
                } else {
                    [self showMBText:message];
                }
            } errorBlock:nil];
        } else {
            [TDLoading hideViewInKeyWindow];
        }
        
    } errorBlock:nil];

}

#pragma mark - Getter and Setter

@end
