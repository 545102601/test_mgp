//
//  MGLevelUpgradeSuccessVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/23.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGLevelUpgradeSuccessVC.h"
#import "MGLevelUpgradeVC.h"

@interface MGLevelUpgradeSuccessVC ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation MGLevelUpgradeSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleString;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64 + SH(240), SW(170), SW(170))];
    _iconImageView.centerX = kScreenWidth * 0.5;
    _iconImageView.image = [UIImage imageNamed:@"mine_icon_success"];
    
    
    _contentLabel = [MGUITool labelWithText:@"信息已经提交成功 , 请等候系统确认" textColor:MGThemeColor_Title_Black font:PFSC(36)];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.frame = CGRectMake(0, _iconImageView.bottom + SH(54), kScreenWidth, _contentLabel.fontLineHeight);
    
    
    _backButton = [MGUITool buttonWithBGColor:nil title:@"返回" titleColor: MGThemeColor_Title_Black font:MGThemeFont_36 target:self selector:@selector(backButtonAction:)];
    _backButton.frame = CGRectMake(SW(75), kScreenHeight - 64 - SH(100), SW(600), SH(84));
    [_backButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_backButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    _backButton.layer.masksToBounds = YES;
    _backButton.layer.cornerRadius = MGButtonLayerCorner;
    
    [self.view sd_addSubviews:@[_iconImageView, _contentLabel, _backButton]];
    
}

- (void)backButtonAction:(UIButton *)button {

    UIViewController *VC = nil;
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[MGLevelUpgradeVC class]]) {
            VC = vc;
            break;
        }
    }
    
    if (VC) {
        [self.navigationController popToViewController:VC animated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


@end
