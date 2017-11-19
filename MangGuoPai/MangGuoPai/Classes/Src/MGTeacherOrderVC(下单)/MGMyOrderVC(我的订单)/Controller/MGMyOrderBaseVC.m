//
//  MGMyOrderBaseVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/3.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMyOrderBaseVC.h"
#import <MJRefresh.h>
#import "MGResOrderListModel.h"
#import "MGPayOrderWayVC.h"
#import "MGOrderDetailVC.h"
#import "MGScheduleVC.h"

@interface MGMyOrderBaseVC ()

/// 页码
@property (nonatomic, assign) NSInteger pageNo;

/// 安排时间按钮
@property (nonatomic, strong) UIButton *sctButton;

@end

@implementation MGMyOrderBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    WEAK
    self.tableView.headerAndFooterRefreshBlock = ^(BOOL isHeader) {
        STRONG
        [self loadDataWithIsHeader:isHeader];
    };
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.menuTag = self.menuTag;
    
    
    /// 调整 内容
    if (self.menuTag == 2) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, SH(100), 0);
        [self.view addSubview:self.sctButton];
        
    }
    
    
    if (self.menuTag == 1) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderReloadMySendOrderRefreshView) name:OrderReloadMySendOrderRefreshView object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderPayFinishRefreshView) name:OrderPayFinishRefreshView object:nil];
        
    } else {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderReloadMyReciveOrderRefreshView) name:OrderReloadMyReciveOrderRefreshView object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timeOrderScheduleRefreshView) name:TimeOrderScheduleRefreshView object:nil];
    }
    
    
    self.tableView.rightOneButtonBlock = ^(MGResOrderListDataModel *dataModel, NSIndexPath *indexPath, MGGlobaOrderButtonTag tag){
        STRONG
        switch (tag) {
            case MGGlobaOrderButtonTagCancel:  /// 取消订单
            {
                [self cancelOrderWithModel:dataModel];
            }
                break;
            case MGGlobaOrderButtonTagPay:      /// 去支付
            {
                MGPayOrderWayVC *vc = [MGPayOrderWayVC new];
                vc.listDataModel = dataModel;
                PushVC(vc)
            }
                break;
            case MGGlobaOrderButtonTagSchedule:   /// 安排日程
            {
                MGScheduleVC *vc = [MGScheduleVC new];
                vc.orderId = dataModel.id;
                vc.sourceType = MGScheduleVCSourceTypeAdd;
                PushVC(vc)
            }
                break;
            case MGGlobaOrderButtonTagCancelSchedule: /// 取消安排
            {
                [self cancelScheduleOrderWithModel:dataModel];
            }
                
                break;
            default:
                break;
        }
    };
    
    
    /// 取消订单
    self.tableView.rightTwoButtonBlock = ^(MGResOrderListDataModel *dataModel , NSIndexPath *indexPath, MGGlobaOrderButtonTag tag){
      STRONG
        [self cancelOrderWithModel:dataModel]; /// 取消订单
        
    };
    /// 订单详情
    self.tableView.didSelectedRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
      STRONG
        MGResOrderListDataModel *dataModel = self.tableView.dataArrayM[indexPath.section];
        MGOrderDetailVC *vc = [MGOrderDetailVC new];
        vc.menuTag = self.menuTag;
        vc.dataModel = dataModel;
        PushVC(vc)
        
    };
    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _sctButton.frame = CGRectMake(0, self.view.height - SH(100), kScreenWidth, SH(100));
}

#pragma mark - 加载数据
- (void)loadDataWithIsHeader:(BOOL)isHeader {
    
    NSInteger pageNo = 1;
    if (isHeader) {
        pageNo = 1;
    } else {
        pageNo = self.pageNo == 0 ? 2 : self.pageNo + 1;
    }
    
    [MGBussiness loadOrderListWithParams:@{@"page_no" : @(pageNo), @"relation" : @(self.menuTag)} completion:^(MGResOrderListModel *listModel) {
        
        self.pageNo = pageNo;
        if (isHeader) {
            self.tableView.dataArrayM = listModel.data.mutableCopy;
           
        } else {
            NSMutableArray *oldArray = self.tableView.dataArrayM.mutableCopy;
            /// 追加
            [oldArray addObjectsFromArray:listModel.data];
         
            self.tableView.dataArrayM = [oldArray copy];
        }
        
        [self.tableView reloadData];
        
        BOOL condition = listModel.total_count == self.tableView.dataArrayM.count ? NO : YES;
        [self.tableView endRefreshingWithDataCondition:condition isHeader:isHeader];
        
    } error:^(NSError *error) {
        [self.tableView endRefreshingWithIsHeader:isHeader];
    }];
}

- (MGMyOrderBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MGMyOrderBaseTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
    }
    return _tableView;

}

#pragma mark - 收到刷新页面通知

- (void)orderReloadMySendOrderRefreshView {
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)orderPayFinishRefreshView {
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)orderReloadMyReciveOrderRefreshView {
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)timeOrderScheduleRefreshView {
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 安排时间事件
- (void)sctButtonOnClick {
    
    MGScheduleVC *vc = [MGScheduleVC new];
    vc.sourceType = MGScheduleVCSourceTypeLook;
    PushVC(vc)
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

/// 取消订单
- (void)cancelOrderWithModel:(MGResOrderListDataModel *)dataModel {
    
    DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:nil message:@"您确定取消该订单吗？" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    [alertView setAlertThemeMessageTip_TwoButton];
    alertView.otherButtonAction = ^{
        [MGBussiness loadOrderCancelWithParams:@{@"id" : @(dataModel.id)} completion:^(id results) {
            if ([results boolValue]) {
                /// 设置取消
                [self.tableView.mj_header beginRefreshing];
            }
        } error:nil];
    };
    
    [alertView show];
    
}
/// 取消安排
- (void)cancelScheduleOrderWithModel:(MGResOrderListDataModel *)dataModel {
    
    DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:nil message:@"您确定取消该订单的安排吗？" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    [alertView setAlertThemeMessageTip_TwoButton];
    alertView.otherButtonAction = ^{
        [MGBussiness loadOrder_Schedule_Cancel:@{@"order_id" : @(dataModel.id)} completion:^(id results) {
            if ([results boolValue]) {
                /// 设置取消安排
                [self.tableView.mj_header beginRefreshing];
            }
        } error:nil];
    };
    
    [alertView show];
    
}

/// 申请售后
- (void)applyOrderWithModel:(MGResOrderListDataModel *)dataModel {

    [MGBussiness loadOrder_Apply:@{@"id" : @(dataModel.id)} completion:^(id results) {
        
    } error:nil];
    
}
#pragma mark - Getter and Setter

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIButton *)sctButton {
    
    if (!_sctButton) {
        
        _sctButton = [MGUITool buttonWithBGColor:[UIColor whiteColor] title:@"查看我的安排日程" titleColor:MGThemeShenYellowColor font:PFSC(36) target:self selector:@selector(sctButtonOnClick)];
        
    }
    return _sctButton;

}

@end
