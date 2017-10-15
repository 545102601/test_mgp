//
//  MGMineSettingView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/23.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"

#define MineSettingViewHeight SH(98)

typedef void(^BackgroundTapBlock)(void);

typedef void(^BackgroundTapWithTagBlock)(NSInteger tag);

@interface MGMineSettingView : BaseView
/// 图标
@property (nonatomic, strong) UIImageView *iconImageView;
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 子标题
@property (nonatomic, strong) UILabel *subTitlelabel;
/// 箭头
@property (nonatomic, strong, readonly) UIImageView *arrowImageView;
/// 底部线条
@property (nonatomic, strong, readonly) UIView *bottomLine;

/// 自定义右边View
@property (nonatomic, strong) UIView *customSubView;

/// 背景点击回调
@property (nonatomic, copy) BackgroundTapBlock backgroundTapBlock;

@property (nonatomic, copy) BackgroundTapWithTagBlock backgroundTapWithTagBlock;

/// 隐藏右边按钮
- (void)setArrowImageHidden;
/// 隐藏底部线条隐藏
- (void)setBottomLineHidden;
/// 显示icon图片
- (void)setIconImageNotHidden;


@end
