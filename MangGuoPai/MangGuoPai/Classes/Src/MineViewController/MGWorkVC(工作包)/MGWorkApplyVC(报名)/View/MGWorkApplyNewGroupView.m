//
//  MGWorkApplyNewGroupView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkApplyNewGroupView.h"
#import "MGMineSettingView.h"

@interface MGWorkApplyNewGroupView () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *topLineView;


/// 昵称
@property (nonatomic, strong) MGMineSettingView *nameSettingView;
@property (nonatomic, strong) UITextField *nameTextField;

/// 角色
@property (nonatomic, strong) MGMineSettingView *roleSettingView;
@property (nonatomic, strong) UITextField *roleTextField;

/// 暗号
@property (nonatomic, strong) MGMineSettingView *cipherSettingView;
@property (nonatomic, strong) UITextField *cipherTextField;

/// 公告
@property (nonatomic, strong) MGMineSettingView *bulletingSettingView;
@property (nonatomic, strong) UITextField *bulletingTextField;

@end

@implementation MGWorkApplyNewGroupView

- (void)prepareFrameViewUI:(CGRect)frame {
    
    _topLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), 0, kScreenWidth - SW(48), MGSepLineHeight)];
    _topLineView.backgroundColor = MGSepColor;
    
    
    _nameSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _topLineView.bottom, kScreenWidth, MineSettingViewHeight)];
    _nameSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"团队名称* : " attr:@{NSFontAttributeName : _nameSettingView.titleLabel.font, NSForegroundColorAttributeName : _nameSettingView.titleLabel.textColor}];
    
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _nameTextField.delegate = self;
    _nameTextField.textColor = MGThemeColor_Common_Black;
    _nameTextField.font = PFSC(28);
    _nameTextField.placeholder = @"起一个响亮好听的团队名字";
    _nameTextField.textAlignment = NSTextAlignmentRight;
    _nameSettingView.customSubView = _nameTextField;
    [_nameSettingView setArrowImageHidden];
    
    
    
    _roleSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _nameSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _roleSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"本人角色 : " attr:@{NSFontAttributeName : _roleSettingView.titleLabel.font, NSForegroundColorAttributeName : _roleSettingView.titleLabel.textColor}];
    
    _roleTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _roleTextField.delegate = self;
    _roleTextField.textColor = MGThemeColor_Common_Black;
    _roleTextField.font = PFSC(28);
    _roleTextField.placeholder = @"填写本人在团队中扮演的角色";
    _roleTextField.textAlignment = NSTextAlignmentRight;
    _roleSettingView.customSubView = _roleTextField;
    [_roleSettingView setArrowImageHidden];
    
    
    _cipherSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _roleSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _cipherSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"集结暗号* : " attr:@{NSFontAttributeName : _cipherSettingView.titleLabel.font, NSForegroundColorAttributeName : _cipherSettingView.titleLabel.textColor}];
    
    NSString *placeHoder = @"输入一个4位数字，作为其他成员入团口令";
    CGFloat placeHoderWidht = [placeHoder widthForFont:PFSC(28)];
    _cipherTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - placeHoderWidht, 0, placeHoderWidht, MineSettingViewHeight)];
    _cipherTextField.delegate = self;
    _cipherTextField.textColor = MGThemeColor_Common_Black;
    _cipherTextField.font = PFSC(28);
    _cipherTextField.placeholder = placeHoder;
    [_cipherTextField limitTextLength:4];
    _cipherTextField.textAlignment = NSTextAlignmentRight;
    _cipherSettingView.customSubView = _cipherTextField;
    [_cipherSettingView setArrowImageHidden];
    
    
    _bulletingSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _cipherSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _bulletingSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"公告 : " attr:@{NSFontAttributeName : _bulletingSettingView.titleLabel.font, NSForegroundColorAttributeName : _bulletingSettingView.titleLabel.textColor}];
    
    _bulletingTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.7, 0, kScreenWidth * 0.7, MineSettingViewHeight)];
    _bulletingTextField.delegate = self;
    _bulletingTextField.textColor = MGThemeColor_Common_Black;
    _bulletingTextField.font = PFSC(28);
    _bulletingTextField.placeholder = @"团队公告 (公开) , 报名后可修改";
    _bulletingTextField.textAlignment = NSTextAlignmentRight;
    _bulletingSettingView.customSubView = _bulletingTextField;
    [_bulletingSettingView setArrowImageHidden];
    
    [self sd_addSubviews:@[_topLineView, _nameSettingView, _roleSettingView, _cipherSettingView, _bulletingSettingView]];
    
    self.height = _bulletingSettingView.bottom;
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string stringContainsEmoji]) {
        return NO;
    }
    
    return YES;
}
#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

- (NSString *)teamName {
    return _nameTextField.text ?: @"";
}

- (NSString *)roleName {
    return _roleTextField.text ?: @"";
}

- (NSString *)ciperName {
    return _cipherTextField.text ?: @"";
}

- (NSString *)bluttingName {
    return _bulletingTextField.text ?: @"";
}

- (BOOL)checkCondition {
    
    NSMutableString *resultString = @"".mutableCopy;
    
    if ([self.teamName removeBlank].length == 0) {
        [resultString appendString:@"请输入团队名称、"];
    }
    
    if (self.ciperName.length == 0) {
        [resultString appendString:@"请输入集结暗号、"];
    }
    
    if (resultString.length > 0) {
        NSString *alertStr = [resultString substringToIndex:resultString.length - 1];
        DQAlertView *checkAlertView = [[DQAlertView alloc] initWithTitle:nil message:alertStr cancelButtonTitle:@"我知道了" otherButtonTitle:nil];
        [checkAlertView setAlertThemeMessageTip_OneButton];
        [checkAlertView show];
        return NO;
    }
    
    return YES;
    
}

@end
