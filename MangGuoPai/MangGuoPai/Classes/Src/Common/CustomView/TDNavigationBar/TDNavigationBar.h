//
//  TDNavigationBar.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/20.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//  自定义导航条 -》 固定大小 64

#import <UIKit/UIKit.h>

/// 自定义按钮宽高
#define NavigationLeftViewRect CGRectMake(getScaleWidth(24), 27, 24, 32)

#define firstViewXMaring 16 /// < 首页view X距
#define viewXMargin 8       /// < X距
#define viewYMargin 20        /// < y距

@interface TDNavigationBar : UIView

@property (nonatomic, copy) NSString *title; /// < 标题

@property (nonatomic, strong) UIColor *titleColor; /// < 标题颜色

@property (nonatomic, strong) UILabel *titleLabel; /// < 默认标题Label

@property (nonatomic, strong) UIView *titleView; /// < 标题view

@property (nonatomic, strong) UIView *leftView; /// < 左

@property (nonatomic, strong) UIView *rightView; /// < 右

@property (nonatomic, strong) NSArray<UIView *> *leftViews;

@property (nonatomic, strong) NSArray<UIView *> *rightViews;

@property (nonatomic, strong) UIImage *backgroundImage; /// < 背景图片

- (void)showWithAnimated:(BOOL)animated;
/**
 显示Navigation
 
 @param animated 动画
 @param completion block
 */
- (void)showWithAnimated:(BOOL)animated completion:(void(^)(void))completion;


- (void)hideWithAnimated:(BOOL)animated;
/**
 隐藏Navigation
 
 @param animated 动画
 @param completion block
 */
- (void)hideWithAnimated:(BOOL)animated completion:(void(^)(void))completion;

/**
 渐变背景颜色
 
 @param alpha 透明度
 */
- (void)gradientBackgroundViewColorWithAlpha:(CGFloat)alpha;

@end
