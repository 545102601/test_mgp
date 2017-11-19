//
//  MGWorkApplyNewGroupView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#define kSettingViewHeight SH(128)

#import "MGWorkApplyNewGroupView.h"
#import "MGMineSettingView.h"
#import "UITextView+Placeholder.h"

@interface MGWorkApplyNewGroupView () <UITextViewDelegate>

@property (nonatomic, strong) UIView *topLineView;


/// 昵称
@property (nonatomic, strong) MGMineSettingView *nameSettingView;
@property (nonatomic, strong) UITextView *nameTextView;

/// 角色
@property (nonatomic, strong) MGMineSettingView *roleSettingView;
@property (nonatomic, strong) UITextView *roleTextView;

/// 暗号
@property (nonatomic, strong) MGMineSettingView *cipherSettingView;
@property (nonatomic, strong) UITextView *cipherTextView;

/// 公告
@property (nonatomic, strong) MGMineSettingView *bulletingSettingView;
@property (nonatomic, strong) UITextView *bulletingTextView;

@end

@implementation MGWorkApplyNewGroupView

- (void)prepareFrameViewUI:(CGRect)frame {
    
    _topLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), 0, kScreenWidth - SW(48), MGSepLineHeight)];
    _topLineView.backgroundColor = MGSepColor;
    
    
    _nameSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _topLineView.bottom, kScreenWidth, kSettingViewHeight)];
    _nameSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"团队名称* : " attr:@{NSFontAttributeName : _nameSettingView.titleLabel.font, NSForegroundColorAttributeName : _nameSettingView.titleLabel.textColor}];
    
    _nameTextView = [[UITextView alloc] initWithFrame:CGRectMake(SW(200), 0, kScreenWidth - SW(230), kSettingViewHeight - MGSepLineHeight)];
    _nameTextView.textContainerInset = UIEdgeInsetsMake(SH(47), 0, 0, 0);
    _nameTextView.placeCenterY = @(_nameTextView.height * 0.5);
    _nameTextView.delegate = self;
    _nameTextView.textColor = MGThemeColor_Common_Black;
    _nameTextView.font = PFSC(28);
    _nameTextView.placeholder = @"填写你认为有趣的队名，会公开出来的哦，例如：芒小派伐木累";
    _nameTextView.placeholderColor = colorHex(@"#cccccc");
    _nameTextView.textAlignment = NSTextAlignmentLeft;
    _nameSettingView.customSubView = _nameTextView;
    [_nameSettingView setArrowImageHidden];
    
    
    
    _roleSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _nameSettingView.bottom, kScreenWidth, kSettingViewHeight)];
    _roleSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"本人角色 : " attr:@{NSFontAttributeName : _roleSettingView.titleLabel.font, NSForegroundColorAttributeName : _roleSettingView.titleLabel.textColor}];
    
    _roleTextView = [[UITextView alloc] initWithFrame:CGRectMake(SW(200), 0, kScreenWidth - SW(230), kSettingViewHeight - MGSepLineHeight)];
    _roleTextView.textContainerInset = UIEdgeInsetsMake(SH(47), 0, 0, 0);
    _roleTextView.placeCenterY = @(_roleTextView.height * 0.5);
    _roleTextView.delegate = self;
    _roleTextView.textColor = MGThemeColor_Common_Black;
    _roleTextView.font = PFSC(28);
    _roleTextView.placeholder = @"填写本人在团队中的角色，如队员or队长，或者写自己的专业";
    _roleTextView.placeholderColor = colorHex(@"#cccccc");
    _roleTextView.textAlignment = NSTextAlignmentLeft;
    _roleSettingView.customSubView = _roleTextView;
    [_roleSettingView setArrowImageHidden];
    
    
    _cipherSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _roleSettingView.bottom, kScreenWidth, kSettingViewHeight)];
    _cipherSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"集结暗号* : " attr:@{NSFontAttributeName : _cipherSettingView.titleLabel.font, NSForegroundColorAttributeName : _cipherSettingView.titleLabel.textColor}];
    
    NSString *placeHoder = @"填写一个4位数字组成的暗号，例如：1234，方便队友加入你的团队，显得很神秘";
    
    _cipherTextView = [[UITextView alloc] initWithFrame:CGRectMake(SW(200), 0, kScreenWidth - SW(230), kSettingViewHeight - MGSepLineHeight)];
    _cipherTextView.textContainerInset = UIEdgeInsetsMake(SH(47), 0, 0, 0);
    _cipherTextView.placeCenterY = @(_cipherTextView.height * 0.5);
    _cipherTextView.delegate = self;
    _cipherTextView.textColor = MGThemeColor_Common_Black;
    _cipherTextView.font = PFSC(28);
    _cipherTextView.placeholder = placeHoder;
    _cipherTextView.placeholderColor = colorHex(@"#cccccc");
    
    _cipherTextView.textAlignment = NSTextAlignmentLeft;
    _cipherSettingView.customSubView = _cipherTextView;
    [_cipherSettingView setArrowImageHidden];
    
    
    _bulletingSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _cipherSettingView.bottom, kScreenWidth, kSettingViewHeight)];
    _bulletingSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"公告 : " attr:@{NSFontAttributeName : _bulletingSettingView.titleLabel.font, NSForegroundColorAttributeName : _bulletingSettingView.titleLabel.textColor}];
    
    _bulletingTextView = [[UITextView alloc] initWithFrame:CGRectMake(SW(140), 0, kScreenWidth - SW(170), kSettingViewHeight - MGSepLineHeight)];
    _bulletingTextView.textContainerInset = UIEdgeInsetsMake(SH(47), 0, 0, 0);
    _bulletingTextView.placeCenterY = @(_bulletingTextView.height * 0.5);
    _bulletingTextView.delegate = self;
    _bulletingTextView.textColor = MGThemeColor_Common_Black;
    _bulletingTextView.font = PFSC(28);
    _bulletingTextView.placeholder = @"可填写团队内部需求等，报名后可修改";
    _bulletingTextView.placeholderColor = colorHex(@"#cccccc");
    _bulletingTextView.textAlignment = NSTextAlignmentLeft;
    _bulletingSettingView.customSubView = _bulletingTextView;
    [_bulletingSettingView setArrowImageHidden];
    
    [self sd_addSubviews:@[_topLineView, _nameSettingView, _roleSettingView, _cipherSettingView, _bulletingSettingView]];
    
    self.height = _bulletingSettingView.bottom;
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text stringContainsEmoji]) {
        return NO;
    }
    if (text.length > 0 && textView == self.cipherTextView) {
        NSInteger length = textView.text.length + text.length;
        if (length > 4) {
            return NO;
        }
    }
    
    return YES;

}

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

- (NSString *)teamName {
    return _nameTextView.text ?: @"";
}

- (NSString *)roleName {
    return _roleTextView.text ?: @"";
}

- (NSString *)ciperName {
    return _cipherTextView.text ?: @"";
}

- (NSString *)bluttingName {
    return _bulletingTextView.text ?: @"";
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
