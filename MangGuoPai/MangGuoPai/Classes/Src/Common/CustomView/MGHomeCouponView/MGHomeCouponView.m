//
//  MGHomeCouponView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/12.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGHomeCouponView.h"

@interface MGHomeCouponView ()
/// 背景
@property (nonatomic, strong) UIView *bgView;
/// 图
@property (nonatomic, strong) UIImageView *iconImageView;
/// 叉叉
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation MGHomeCouponView


- (void)prepareFrameViewUI:(CGRect)frame {

    self.hidden = YES;
    
    _bgView = [[UIView alloc] initWithFrame:self.bounds];
    _bgView.backgroundColor = RGBA(0, 0, 0, 0.2);
    _bgView.alpha = 0;
    [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTapOnClick)]];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.5 * (frame.size.width - SW(616)), 0, SW(616), SH(532))];
    _iconImageView.centerY = frame.size.height * 0.5 - 44;
    _iconImageView.userInteractionEnabled = YES;
    [_iconImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTapOnClick)]];
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setImage:[UIImage imageNamed:@"home_del"] forState:UIControlStateNormal];
    _closeButton.frame = CGRectMake(0, _iconImageView.bottom + SH(60), SW(70), SW(70));
    _closeButton.centerX = frame.size.width * 0.5;
    [_closeButton addTarget:self action:@selector(closeButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_bgView sd_addSubviews:@[ _iconImageView, _closeButton]];
    [self addSubview:_bgView];
}



#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

/// 关闭页面
- (void)closeButtonOnClick {
    
    [self dismissCouponViewWithAnimated:YES];
    
}


- (void)bgTapOnClick {
    
    [self dismissCouponViewWithAnimated:YES];
}

- (void)iconTapOnClick {
    /// 拦截登录
    InterceptLoginShowAlert
    
    if (_iconImageViewBlock) {
        _iconImageViewBlock(self.detaiModel);
    }
}

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

- (void)showCouponViewWithAnimated:(BOOL)animated inView:(UIView *)inView {
    
    [inView endEditing:YES];
    
    if (!self.hidden) return;
    self.hidden = NO;
    [inView addSubview:self];
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:self.detaiModel.file_path] placeholderImage:SDWEB_PLACEHODER_IMAGE(_iconImageView)];
    
    if (animated) {
        [UIView animateWithDuration:0.5 animations:^{
            self.bgView.alpha = 1;
        }];
    } else {
        self.bgView.alpha = 1;
    }
    
    
}

- (void)dismissCouponViewWithAnimated:(BOOL)animated {
    
    if (self.hidden) return;
    
    if (animated) {
        [UIView animateWithDuration:0.5 animations:^{
            self.bgView.alpha = 0;
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    } else {
        self.bgView.alpha = 0;
        self.hidden = YES;
        [self removeFromSuperview];
    }
    
}


#pragma mark - Private Function

#pragma mark - Getter and Setter




@end
