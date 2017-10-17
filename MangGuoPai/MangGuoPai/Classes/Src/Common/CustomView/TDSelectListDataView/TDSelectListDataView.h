//
//  TDSelectListDataView.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/7/6.
//  Copyright © 2017年 梦创. All rights reserved.
//

#import "BaseView.h"
#import "TDSelectListDataViewContentModel.h"

@protocol TDSelectListDataViewDelegate <NSObject>
@optional
/// 点击父类事件
- (void)didTapSelectListDataViewOnClick;

@end


typedef void(^DidSelectListDataViewContentViewRow)(NSInteger row);

@interface TDSelectListDataView : BaseView


/// 列表数据源
@property (nonatomic, strong) NSArray *dataArray;

/// 代理
@property (nonatomic, weak) id <TDSelectListDataViewDelegate> delegate;
/// 选择cell 代理
@property (nonatomic, copy) DidSelectListDataViewContentViewRow didSelectListDataViewContentViewRow;

/// 设置 是否 可点击
- (void)setListDataViewisAllowClick:(BOOL)isAllow;

/// 显示 动画 isShowRow 是否展开
- (void)changeArrowImageWithAnimated:(BOOL)animated isShowRow:(BOOL)isShowRow;

/// 设置标题
- (void)setTitleLabelWithTitle:(NSString *)title;

- (void)reloadTableView;

@end
