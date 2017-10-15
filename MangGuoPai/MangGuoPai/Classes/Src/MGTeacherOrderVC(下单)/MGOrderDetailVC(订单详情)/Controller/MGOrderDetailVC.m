//
//  MGOrderDetailVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/3.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGOrderDetailVC.h"
#import "MGResOrderDetailModel.h"
#import "MGOrderInfoView.h"
#import "MGOrderDetailCalView.h"
#import "MGOrderDetailFileView.h"
#import "MGOrderDetailAfterSaleView.h"
#import "MGOrderDetailCommentView.h"
#import "MGOrderDetailBottomView.h"
#import "MGPayOrderWayVC.h"


@interface MGOrderDetailVC ()

/// 内容
@property (nonatomic, strong) UIScrollView *scrollView;

/// 订单info
@property (nonatomic, strong) MGOrderInfoView *orderInfoView;

/// 计算价格
@property (nonatomic, strong) MGOrderDetailCalView *calView;

/// 附件
@property (nonatomic, strong) MGOrderDetailFileView *fileView;

/// 售后信息
@property (nonatomic, strong) MGOrderDetailAfterSaleView *afterSaleView;

/// 评论
@property (nonatomic, strong) MGOrderDetailCommentView *commentView;

/// 底部
@property (nonatomic, strong) MGOrderDetailBottomView *bottomView;

@end

@implementation MGOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - 初始化控件
- (void)setupSubViews {
    WEAK
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - SH(140))];
    
    /// 订单信息
    _orderInfoView = [[MGOrderInfoView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    _orderInfoView.type = _type;
    
    /// 订单计算价格信息
    _calView = [[MGOrderDetailCalView alloc] initWithFrame:CGRectMake(0, _orderInfoView.bottom, kScreenWidth, 0)];
    
    
    _fileView = [[MGOrderDetailFileView alloc] initWithFrame:CGRectMake(0, _calView.bottom, kScreenWidth, 0)];
    
    /// 售后信息
    _afterSaleView = [[MGOrderDetailAfterSaleView alloc] initWithFrame:CGRectMake(0, _calView.bottom, kScreenWidth, 0)];
    
    /// 评论
    _commentView = [[MGOrderDetailCommentView alloc] initWithFrame:CGRectMake(0, _calView.bottom, kScreenWidth, 0)];
    
    
    [_scrollView sd_addSubviews:@[_orderInfoView, _calView, _fileView, _afterSaleView, _commentView]];
    
    [self.view addSubview:_scrollView];
    
    
    _bottomView = [[MGOrderDetailBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight - SH(140), kScreenWidth, SH(140))];
    /// 立即支付
    _bottomView.rightOneButtonBlock = ^(MGResOrderListDataModel *dataModel, NSIndexPath *indexPath){
        STRONG
        MGPayOrderWayVC *vc = [MGPayOrderWayVC new];
        vc.listDataModel = dataModel;
        PushVC(vc)
    };
    /// 取消订单
    _bottomView.rightTwoButtonBlock = ^(MGResOrderDetailDataModel *dataModel){
        STRONG
        DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:nil message:@"您确定取消该订单吗？" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
        [alertView setAlertThemeMessageTip_TwoButton];
        alertView.otherButtonAction = ^{
            [MGBussiness loadOrderCancelWithParams:@{@"id" : @(dataModel.id)} completion:^(id results) {
                if ([results boolValue]) {
                    /// 设置取消
                    dataModel.state = MGGlobalOrderStateOrderCancelForUser;
                    
                    self.bottomView.detailDataModel = dataModel;
                    /// 刷新页面
                    if (self.type == 1) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:OrderReloadMySendOrderRefreshView object:nil];
                    } else {
                        [[NSNotificationCenter defaultCenter] postNotificationName:OrderReloadMyReciveOrderRefreshView object:nil];
                    }
                }
            } error:nil];
        };
        
        [alertView show];
        
    };
    
    
    [self.view addSubview:_bottomView];
    
    
}

#pragma mark - 加载数据
- (void)loadData {
    
    _scrollView.hidden = YES;
    _bottomView.hidden = YES;
    [MGBussiness loadOrderDetailWithParams:@{@"id" : @(self.dataModel.id)} completion:^(MGResOrderDetailDataModel *dataModel) {
        _scrollView.hidden = NO;
        _bottomView.hidden = NO;
        
        self.orderInfoView.detailDataModel = dataModel;
        
        self.calView.detailDataModel = dataModel;
    
        self.fileView.detailDataModel = dataModel;
        
        self.afterSaleView.detailDataModel = dataModel;
        
        self.afterSaleView.top = self.calView.bottom + self.fileView.height;
        
        self.commentView.detailDataModel = dataModel;
        
        self.commentView.top = self.calView.bottom + self.fileView.height + self.afterSaleView.height;
        
        self.bottomView.detailDataModel = dataModel;
        
        CGFloat maxHeight = 0;
        for (UIView *subView in self.scrollView.subviews) {
            if (subView.bottom > maxHeight) {
                maxHeight = subView.bottom;
            }
        }
        self.scrollView.contentSize = CGSizeMake(kScreenWidth, maxHeight);
        
    } error:nil];
}

@end
