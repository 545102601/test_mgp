//
//  MGUpgradeIDView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/14.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGUpgradeIDView.h"

@interface MGUpgradeIDView ()
/// 提示
@property (nonatomic, strong) UILabel *upgradeLabel;
@property (nonatomic, strong) UIButton *upgradeButton;
@property (nonatomic, strong) UIButton *closeButton;




@end

@implementation MGUpgradeIDView



- (void)prepareFrameViewUI:(CGRect)frame {

    self.backgroundColor = MGThemeBackgroundColor;
    
    
    _closeButton = [TDExpendClickButtonNotHightLight buttonWithType:UIButtonTypeCustom];
    [_closeButton setImage:[UIImage imageNamed:@"home_dele_white"] forState:UIControlStateNormal];
    _closeButton.frame = CGRectMake(frame.size.width - SW(64), 0, SW(44), SW(44));
    _closeButton.centerY = frame.size.height * 0.5;
    [_closeButton addTarget:self action:@selector(closeButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _upgradeButton = [TDNotHighlightButton buttonWithType:UIButtonTypeCustom];
    [_upgradeButton setImage:[UIImage imageNamed:@"home_mashang_sj"] forState:UIControlStateNormal];
    _upgradeButton.frame = CGRectMake(_closeButton.left - SW(138) - SW(26), 0, SW(138), SW(60));
    _upgradeButton.centerY = frame.size.height * 0.5;
    [_upgradeButton addTarget:self action:@selector(upgradeButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _upgradeLabel = [MGUITool labelWithText:@"升级您的身份,享受更多专业服务" textColor:MGThemeColor_Black font:PFSC(28)];
    _upgradeLabel.frame = CGRectMake(SW(30), 0, _upgradeButton.left - SW(60), _upgradeLabel.fontLineHeight);
    _upgradeLabel.right = _upgradeButton.left - SW(30);
    _upgradeLabel.centerY = frame.size.height * 0.5;
    
    [self sd_addSubviews:@[_closeButton, _upgradeButton, _upgradeLabel]];
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
- (void)closeButtonOnClick {
    if (_didCloseBlock) {
        _didCloseBlock();
    }
    
}
- (void)upgradeButtonOnClick {
    if (_didUpgradeBlock) {
        _didUpgradeBlock();
    }
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

@end
