//
//  MGMineSettingVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/23.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMineSettingVC.h"
#import "MGMineSettingView.h"
#import "MGCommonWKWebViewVC.h"
#import "MGMineInfoVC.h"
#import "MGResMemberModel.h"
#import "TDUMShareAlertView.h"

@interface MGMineSettingVC ()
/// 资料
@property (nonatomic, strong) MGMineSettingView *infoView;
/// 电话
@property (nonatomic, strong) MGMineSettingView *phoneView;
/// 密码
@property (nonatomic, strong) MGMineSettingView *payPwdView;

/// 关于
@property (nonatomic, strong) MGMineSettingView *aboutView;
/// 分享
@property (nonatomic, strong) MGMineSettingView *shareView;
/// 清除
@property (nonatomic, strong) MGMineSettingView *clearCacheView;

/// 个人信息模型
@property (nonatomic, strong) MGResMemberDataModel *dataModel;


/// 退出按钮
@property (nonatomic, strong) UIButton *outButton;

@end

@implementation MGMineSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    
}

- (void)initData {
    
    _dataModel = memberDataModelInstance;
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    
    WEAK
    _infoView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, MineSettingViewHeight)];
    _infoView.titleLabel.text = @"个人资料";
    _infoView.subTitlelabel.text = @"点击编辑";
    _infoView.backgroundTapBlock = ^{
      STRONG
        MGMineInfoVC *vc = [MGMineInfoVC new];
        PushVC(vc)
    };
    
    _phoneView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _infoView.bottom, kScreenWidth, MineSettingViewHeight)];
    _phoneView.titleLabel.text = @"手机号";
    _phoneView.subTitlelabel.text = self.dataModel.mobile;
    [_phoneView setArrowImageHidden];
    
    
//    /// 未处理交易密码
//    _payPwdView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _phoneView.bottom, kScreenWidth, MineSettingViewHeight)];
//    _payPwdView.titleLabel.text = @"交易密码";
//    _payPwdView.subTitlelabel.text = @"未设置";
//    [_payPwdView setBottomLineHidden];
//    _payPwdView.backgroundTapBlock = ^{
//        STRONG
//        
//    };
    
    _aboutView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _phoneView.bottom + SH(20), kScreenWidth, MineSettingViewHeight)];
    _aboutView.titleLabel.text = @"关于我们";
    _aboutView.backgroundTapBlock = ^{
        STRONG
        MGCommonWKWebViewVC *vc = [MGCommonWKWebViewVC new];
        vc.titleString = @"关于我们";
        vc.urlString = @"https://www.baidu.com";
        PushVC(vc);
    };
    
    _shareView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _aboutView.bottom, kScreenWidth, MineSettingViewHeight)];
    _shareView.titleLabel.text = @"分享给好友";
    _shareView.backgroundTapBlock = ^{
        STRONG
        TDUMShareAlertView *alertView = [TDUMShareAlertView showUMengShareViewWithTitle:@"乐享芒果派" shareContent:@"乐享芒果派内容" shareImage:[UIImage imageNamed:@"mine_manguo_fx"] imageUrl:nil shareUrl:@"http://www.baidu.com"];
        
        [alertView show];
    };
    
    _clearCacheView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _shareView.bottom, kScreenWidth, MineSettingViewHeight)];
    _clearCacheView.titleLabel.text = @"清除缓存";
    NSUInteger cacheSize = [[SDImageCache sharedImageCache] getSize];
    
    _clearCacheView.subTitlelabel.text = [NSString stringWithFormat:@"%0.2fM",cacheSize/1000000.0];
    [_clearCacheView setBottomLineHidden];
    _clearCacheView.backgroundTapBlock = ^{
        STRONG
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            [self showMBText:@"清除成功"];
            self.clearCacheView.subTitlelabel.text = @"0.00M";
        }];
    };
    
    _outButton = [MGUITool buttonWithBGColor:nil title:@"退出登录" titleColor:MGThemeColor_Black font:MGThemeFont_36 target:self selector:@selector(outButtonOnClick)];
    [_outButton setBackgroundImage:[UIImage imageWithColor:MGButtonBlankDefaultColor] forState:UIControlStateNormal];
    [_outButton setBackgroundImage:[UIImage imageWithColor:MGButtonBlankHighLightedColor] forState:UIControlStateHighlighted];
    
    _outButton.frame = CGRectMake(SW(75), _clearCacheView.bottom + SH(100), SW(600), SH(84));
    _outButton.layer.cornerRadius = MGButtonLayerCorner;
    _outButton.layer.masksToBounds = YES;
    
    [self.view sd_addSubviews:@[_infoView, _phoneView, _payPwdView, _aboutView, _shareView, _clearCacheView, _outButton]];
    
}


#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 退出的登录
- (void)outButtonOnClick {
    
    
    [MGBussinessRequest postLoginOut:nil successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if (isSuccess) {
            [self showMBText:@"退出成功"];
            
            /// 清缓存
            memberDataModelInstance = nil;
            
            /// 发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:OutSuccessRefreshTable object:nil];
            
        } else {
            [self showMBText:message];
        }
        
    } errorBlock:nil];
    
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

@end
