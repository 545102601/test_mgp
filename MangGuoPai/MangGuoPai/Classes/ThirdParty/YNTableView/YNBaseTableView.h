//
//  YNBaseTableView.h
//  052_对UITableView_UICollectionView封装
//
//  Created by ZYN on 17/1/22.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+YNRefreshHelper.h"
#import <UIScrollView+EmptyDataSet.h>

typedef void(^HeaderAndFooterRefreshBlock)(BOOL isHeader);
typedef void(^HeaderRefreshBlock)(void);
typedef void(^FooterRefreshBlock)(void);

typedef void (^DidSelectRowAtIndexPath) (UITableView *tableView, NSIndexPath *indexPath);

@interface YNBaseTableView : UITableView <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

/// 数据源
@property (nonatomic, strong) NSMutableArray *dataArrayM;
/// 默认 YES
@property (nonatomic, assign) BOOL emptyDataSetShouldAllowScroll;
/// 默认 YES
@property (nonatomic, assign) BOOL emptyDataSetShouldDisplay;
/// 无数据View 默认nil
@property (nonatomic, strong) UIView *emptyDataView;
/// 加载数据状态View 默认nil
@property (nonatomic, strong) UIView *loadingDataView;
/// 是否正在加载 默认NO
@property (nonatomic, assign) BOOL isLoading; 
/// 下拉刷新和加载更多回调
@property (nonatomic, copy) HeaderAndFooterRefreshBlock headerAndFooterRefreshBlock;
/// 下拉刷新回调
@property (nonatomic, copy) HeaderRefreshBlock headerRefreshBlock;
/// 加载更多回调
@property (nonatomic, copy) FooterRefreshBlock footerRefreshBlock;
/// 点击cell
@property (nonatomic, copy) DidSelectRowAtIndexPath didSelectedRowAtIndexPath;


- (void)prepareUI;

@end
