//
//  TDSelectListDataViewContentView.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/7/6.
//  Copyright © 2017年 梦创. All rights reserved.
//

#import "BaseView.h"
@class TDCategoryModel;
typedef void(^DidSelectListDataViewContentViewRow)(NSInteger row);

typedef void(^DidBackgroundViewOnClick)(void);

@interface TDSelectListDataViewContentView : BaseView

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

@property (nonatomic, strong) NSArray *array;
/// In View
@property (nonatomic, weak) UIView *inView;

@property (nonatomic, assign) CGFloat tableViewWidth;

/// 列表
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) DidBackgroundViewOnClick didBackgroundViewOnClick;

@property (nonatomic, copy) DidSelectListDataViewContentViewRow didSelectListDataViewContentViewRow;

+ (instancetype)selectListDataViewContentViewWithDataArray:(NSArray *)array tableViewWidth:(CGFloat)tableViewWidth inView:(UIView *)inView;
/// 显示
- (void)showSelectListDataViewContentViewWithAnimated:(BOOL)animated;
/// 隐藏
- (void)hideSelectListDataViewContentViewWithAnimated:(BOOL)animated;

/// 隐藏
- (void)hideSelectListDataViewContentViewWithAnimated:(BOOL)animated
                                            comletion:(void(^)(void))completion;

@end
