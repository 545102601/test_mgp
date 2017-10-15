//
//  TDNavigationBar.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/20.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#define kNavRect CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)
#define kOutNavRect CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, 64)

#import "TDNavigationBar.h"

@implementation TDNavigationBar


- (instancetype)init
{
    
    return [self initWithFrame:kNavRect];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:kNavRect];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth * 0.7, 44)];
        titleLabel.centerX = kScreenWidth * 0.5;
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment =NSTextAlignmentCenter;
        self.titleLabel = titleLabel;
        [self addSubview:self.titleLabel];
        
    }
    return self;
}



- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    self.titleLabel.text = title;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.height = 44;
    
    if (self.titleLabel.width > kScreenWidth * 0.7) {
        self.titleLabel.width = kScreenWidth * 0.7;
    }
    self.titleLabel.centerX = kScreenWidth * 0.5;
}



- (void)setTitleView:(UIView *)titleView {
    
    _titleView = titleView;
    
    if (!titleView) return;
    self.titleLabel.hidden = YES;
    
    _titleView.frame = CGRectMake(0, 20, titleView.frame.size.width, titleView.frame.size.height);
    
    _titleView.center = CGPointMake(self.center.x, _titleView.center.y);
    
    [self addSubview:_titleView];
    
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    self.titleLabel.textColor = titleColor;
    
}

- (void)setLeftView:(UIView *)leftView {
    
    _leftView = leftView;
    
    _leftView.frame = CGRectMake(firstViewXMaring, viewYMargin, leftView.frame.size.width, leftView.frame.size.height);
    
    [self addSubview:_leftView];
    
}

- (void)setRightView:(UIView *)rightView {
    
    _rightView = rightView;
    
    _rightView.frame = CGRectMake( [UIScreen mainScreen].bounds.size.width -firstViewXMaring - rightView.frame.size.width, viewYMargin, rightView.frame.size.width, rightView.frame.size.height);
    
    [self addSubview:_rightView];
}

- (void)setLeftViews:(NSArray<UIView *> *)leftViews {
    
    _leftViews = leftViews;
    
    for (int i = 0; i < leftViews.count; i++) {
        UIView *leftView = leftViews[i];
        CGFloat mariginX = i == 0 ? firstViewXMaring : viewXMargin;
        CGFloat mariginAddX = i == 0 ? 0 : CGRectGetMaxX(leftViews[i - 1].frame);
        leftView.frame = CGRectMake(mariginX + mariginAddX, viewYMargin, leftView.frame.size.width, leftView.frame.size.height);
        [self addSubview:leftView];
        
    }
    
}

- (void)setRightViews:(NSArray<UIView *> *)rightViews {
    
    _rightViews = rightViews;
    
    for (int i = 0; i < rightViews.count; i++) {
        UIView *rightView = rightViews[i];
        CGFloat marginX = i == 0 ? firstViewXMaring : viewXMargin;
        CGFloat mariginAddX = i == 0 ? rightView.frame.size.width : self.frame.size.width -  CGRectGetMinX(rightViews[i - 1].frame) + rightView.frame.size.width;
        
        rightView.frame = CGRectMake(self.frame.size.width - (marginX + mariginAddX), viewYMargin, rightView.frame.size.width, rightView.frame.size.height);
        
        [self addSubview:rightView];
        
    }
}


- (void)setBackgroundImage:(UIImage *)backgroundImage {
    
    _backgroundImage = backgroundImage;
    
    self.layer.contents = (id)backgroundImage.CGImage;
    
    
}

#pragma mark - Publick Method

- (void)showWithAnimated:(BOOL)animated {
    
    [self showWithAnimated:animated completion:nil];
    
}

- (void)showWithAnimated:(BOOL)animated completion:(void (^)(void))completion{
    
    if (!self.hidden) return;
    
    if (animated) {
        
        self.hidden = NO;
        
        self.frame = kOutNavRect;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.frame = kNavRect;
            
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    } else {
        
        self.hidden = NO;
        if (completion) {
            completion();
        }
    }
    
}

- (void)hideWithAnimated:(BOOL)animated {
    
    [self hideWithAnimated:animated completion:nil];
    
}

- (void)hideWithAnimated:(BOOL)animated completion:(void (^)(void))completion{
    
    if (self.hidden) return;
    if (animated) {
        
        self.frame = kNavRect;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.frame = kOutNavRect;
            
        } completion:^(BOOL finished) {
            
            self.hidden = YES;
            if (completion) {
                completion();
            }
        }];
    } else {
        
        self.hidden = YES;
        if (completion) {
            completion();
        }
    }
}

- (void)gradientBackgroundViewColorWithAlpha:(CGFloat)alpha {
    
    CGFloat r, g , b, a;
    
    [self.backgroundColor getRed:&r green:&g blue:&b alpha:&a];
    
    self.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:alpha];
    
}


@end
