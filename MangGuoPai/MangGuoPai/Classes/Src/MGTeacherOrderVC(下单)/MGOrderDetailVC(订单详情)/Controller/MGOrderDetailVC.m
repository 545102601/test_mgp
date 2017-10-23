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
#import "MGTeacherClassDetailVC.h"
#import "MGOrderCommentVC.h"
#import "MGOrderDetailPriceView.h"
#import "MGScheduleVC.h"

@interface MGOrderDetailVC ()

/// 内容
@property (nonatomic, strong) UIScrollView *scrollView;

/// 订单info
@property (nonatomic, strong) MGOrderInfoView *orderInfoView;

/// 学生 - 计算价格
@property (nonatomic, strong) MGOrderDetailCalView *calView;
/// 老师 - 显示价格
@property (nonatomic, strong) MGOrderDetailPriceView *priceView;

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

- (void)registerNotification {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderPayFinishRefreshView) name:OrderPayFinishRefreshView object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timeOrderScheduleRefreshView) name:TimeOrderScheduleRefreshView object:nil];
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    WEAK
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - SH(140))];
    
    /// 订单信息
    _orderInfoView = [[MGOrderInfoView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    _orderInfoView.sourceType = MGOrderInfoViewSourceTypeOrderDetail;
    _orderInfoView.menuTag = self.menuTag;
    
    _orderInfoView.orderNameTapBlock = ^(long id){
        STRONG
        MGTeacherClassDetailVC *vc = [MGTeacherClassDetailVC new];
        vc.id = id;
        PushVC(vc)
    };
    _orderInfoView.phoneTapBlock = ^(NSString *phone){
        STRONG
        if (phone.length == 0) return;
        if (self.orderInfoView.sourceType == MGOrderInfoViewSourceTypeOrderDetail && self.orderInfoView.menuTag == MGGlobaMenuTagRight) {
            if (SystemVersion >= 10.2) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]]];
            } else {
                
                DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:nil message:phone cancelButtonTitle:@"取消" otherButtonTitle:@"呼叫"];
                [alertView setAlertThemeMessageTip_TwoButton];
                alertView.otherButtonAction = ^{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]]];
                };
                [alertView show];
            }
        }
    };
    
    
    
    /// 订单计算价格信息
    _calView = [[MGOrderDetailCalView alloc] initWithFrame:CGRectMake(0, _orderInfoView.bottom, kScreenWidth, 0)];
    _calView.hidden = YES;
    
    _priceView = [[MGOrderDetailPriceView alloc] initWithFrame:CGRectMake(0, _orderInfoView.bottom, kScreenWidth, 0)];
    _priceView.hidden = YES;
    
    
    _fileView = [[MGOrderDetailFileView alloc] initWithFrame:CGRectMake(0, _calView.bottom, kScreenWidth, 0)];
    
    /// 售后信息
    _afterSaleView = [[MGOrderDetailAfterSaleView alloc] initWithFrame:CGRectMake(0, _calView.bottom, kScreenWidth, 0)];
    
    /// 评论
    _commentView = [[MGOrderDetailCommentView alloc] initWithFrame:CGRectMake(0, _calView.bottom, kScreenWidth, 0)];
    
    
    [_scrollView sd_addSubviews:@[_orderInfoView, _calView, _priceView, _fileView, _afterSaleView, _commentView]];
    
    [self.view addSubview:_scrollView];
    
    
    _bottomView = [[MGOrderDetailBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight - SH(140), kScreenWidth, SH(140))];
    _bottomView.menuTag = self.menuTag;
    
    _bottomView.rightOneButtonBlock = ^(MGResOrderDetailDataModel *dataModel, MGGlobaOrderButtonTag tag){
        STRONG
        
        switch (tag) {
            case MGGlobaOrderButtonTagComment: /// 点评
            {
                MGOrderCommentVC *vc = [MGOrderCommentVC new];
                vc.dataModel = dataModel;
                vc.completiomBlock = ^{
                    [self loadData];
                    [self sendNotificationReloadOrderListTable];
                };
                PushVC(vc)

            }
                break;
            case MGGlobaOrderButtonTagPay: /// 立即支付
            {
                MGPayOrderWayVC *vc = [MGPayOrderWayVC new];
                vc.listDataModel = dataModel;
                PushVC(vc)
            }
                break;
            case MGGlobaOrderButtonTagCancel: /// 取消订单
            {
                [self cancelOrderWithModel:dataModel];
                
                [self sendNotificationReloadOrderListTable];
            }
                break;
            case MGGlobaOrderButtonTagCancelSchedule: /// 取消安排
            {
                [self cancelScheduleOrderWithModel:dataModel];
            }
                break;
            case MGGlobaOrderButtonTagSchedule: /// 安排日程
            {
                MGScheduleVC *vc = [MGScheduleVC new];
                vc.orderId = dataModel.id;
                vc.sourceType = MGScheduleVCSourceTypeAdd;
                
                vc.completionSchedule = ^{
                    [self loadData];
                };
                PushVC(vc)
            }
                break;
            case MGGlobaOrderButtonTagReplyComment: /// 回复点评
            {
                MGOrderCommentVC *vc = [MGOrderCommentVC new];
                vc.commentType = MGOrderCommentTypeReply;
                vc.dataModel = dataModel;
                vc.completiomBlock = ^{
                    [self loadData];
                    [self sendNotificationReloadOrderListTable];
                };
                
                PushVC(vc)
            }
                break;
            default:
                break;
        }
        
        
    };
    /// 取消订单
    _bottomView.rightTwoButtonBlock = ^(MGResOrderDetailDataModel *dataModel, MGGlobaOrderButtonTag tag){
        STRONG
        [self cancelOrderWithModel:dataModel];
        
    };
    
    
    [self.view addSubview:_bottomView];
    
    
    
    _scrollView.hidden = YES;
    _bottomView.hidden = YES;
}

#pragma mark - 加载数据
- (void)loadData {
    
    [MGBussiness loadOrderDetailWithParams:@{@"id" : @(self.dataModel.id)} completion:^(MGResOrderDetailDataModel *dataModel) {
        _scrollView.hidden = NO;
        _bottomView.hidden = NO;
        
        self.orderInfoView.detailDataModel = dataModel;
        
        self.fileView.detailDataModel = dataModel;
        
        self.afterSaleView.detailDataModel = dataModel;
        
        self.commentView.detailDataModel = dataModel;
        
        self.bottomView.detailDataModel = dataModel;
        
        CGFloat princeOrCalBottom = 0;
        
        if (self.menuTag == MGGlobaMenuTagLeft) {
            self.calView.hidden = NO;
            self.calView.detailDataModel = dataModel;
            princeOrCalBottom = self.calView.bottom;
            
        } else {
            self.priceView.hidden = NO;
            self.priceView.detailDataModel = dataModel;
            princeOrCalBottom = self.priceView.bottom;
        }
        
        
        self.fileView.top = princeOrCalBottom;
        
        self.afterSaleView.top = princeOrCalBottom + self.fileView.height;
        
        self.commentView.top = princeOrCalBottom + self.fileView.height + self.afterSaleView.height;
        
        
        
        
        CGFloat maxHeight = 0;
        for (UIView *subView in self.scrollView.subviews) {
            if (subView.bottom > maxHeight) {
                maxHeight = subView.bottom;
            }
        }
        self.scrollView.contentSize = CGSizeMake(kScreenWidth, maxHeight);
        
    } error:nil];
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

/// 订单支付完成
- (void)orderPayFinishRefreshView {
    
    [self loadData];
    
}
/// 时间点 安排 订单 取消
- (void)timeOrderScheduleRefreshView {
    
    [self loadData];
    
}

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function
/// 取消订单
- (void)cancelOrderWithModel:(MGResOrderDetailDataModel *)dataModel {
    
    DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:nil message:@"您确定取消该订单吗？" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    [alertView setAlertThemeMessageTip_TwoButton];
    alertView.otherButtonAction = ^{
        [MGBussiness loadOrderCancelWithParams:@{@"id" : @(dataModel.id)} completion:^(id results) {
            if ([results boolValue]) {
                [self loadData];
                [self sendNotificationReloadOrderListTable];
            }
        } error:nil];
    };
    
    [alertView show];
    
}
/// 取消安排
- (void)cancelScheduleOrderWithModel:(MGResOrderDetailDataModel *)dataModel {
    
    DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:nil message:@"您确定取消该订单的安排吗？" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    [alertView setAlertThemeMessageTip_TwoButton];
    alertView.otherButtonAction = ^{
        [MGBussiness loadOrder_Schedule_Cancel:@{@"order_id" : @(dataModel.id)} completion:^(id results) {
            if ([results boolValue]) {
                [self loadData];
                [self sendNotificationReloadOrderListTable];
            }
        } error:nil];
    };
    
    [alertView show];
    
}
#pragma mark - Getter and Setter

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)sendNotificationReloadOrderListTable {
    
    if (self.menuTag == MGGlobaMenuTagLeft) {
        [[NSNotificationCenter defaultCenter] postNotificationName:OrderReloadMySendOrderRefreshView object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:OrderReloadMyReciveOrderRefreshView object:nil];
    }
    
}


@end
