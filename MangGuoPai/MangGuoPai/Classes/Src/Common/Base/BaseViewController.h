//
//  BaseViewController.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDNavigationBar.h"


@interface BaseViewController : UIViewController

/// 返回按钮
@property (nonatomic, strong) TDNotHighlightButton *backBtn;
@property (nonatomic, strong) UIView *topLineView;
/// 自定义导航条
@property (nonatomic, strong)  TDNavigationBar *navigationBar;

/// 页码
@property (nonatomic, assign) NSInteger pageNo;

/// 状态栏 默认为白色  默认 YES
@property (nonatomic, assign) BOOL statusBarIsWhite;

#pragma mark - 初始化数据
- (void)initData;

#pragma mark - 初始化控件
- (void)setupSubViews;

#pragma mark - 加载数据
- (void)loadData;

#pragma mark - 布局控件
- (void)setupSubViewsFrame;

#pragma mark - 注册通知
- (void)registerNotification;

/// 返回按钮事件
- (void)backButtonAction:(UIButton *)button;

#pragma mark - 导航条方法
/// 导航条主题 灰色主题 默认
- (void)setNavigationBarGrayAndBlackBackButton;
/// 导航条主题 黄色主题
- (void)setNavigationBarYellowAndWhiteBackButton;
/// 右边按钮 - 纯文字
- (UIButton *)setRightButtonWithTitle:(NSString *)title
                         target:(id)target
                       selector:(SEL)selector;
@end
