//
//  TDLoading.h
//  TDQianxiaoer
//
//  Created by zhenyong on 2017/3/31.
//  Copyright © 2017年 TDMarket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDLoading : UIView

/** system loading */
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;


/** loading imageView*/
//@property (strong , nonatomic) UIImageView *loadingImageView;
/** 背景 */
@property (strong , nonatomic) UIView *bgView;

/// 显示在对应的View
+ (instancetype)showViewInView:(UIView *)inView;
+ (void)hideViewInView:(UIView *)inView;



/// 显示在主窗体
+ (instancetype)showViewInKeyWindow;
+ (void)hideViewInKeyWindow;

@end
