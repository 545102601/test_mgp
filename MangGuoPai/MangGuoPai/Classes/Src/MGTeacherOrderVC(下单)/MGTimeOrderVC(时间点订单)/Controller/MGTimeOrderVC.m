//
//  MGTimeOrderVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTimeOrderVC.h"
#import "MGResOrderListModel.h"
#import "MGTimeOrderTableView.h"

@interface MGTimeOrderVC ()

@property (nonatomic, strong) MGTimeOrderTableView *tableView;

/// 底部view
@property (nonatomic, strong) UIView *bottomBgView;
@property (nonatomic, strong) UILabel *orderNumLabel;
@property (nonatomic, strong) UIButton *sendMsgButton;

@end

@implementation MGTimeOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@ %zd点订单",
                  [self.sct_date stringWithFormat:@"yyyy年MM月dd日"], self.time];
    
}

#pragma mark - 初始化控件
- (void)setupSubViews {

    [self setupBottomView];
    
    
    _tableView = [[MGTimeOrderTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - SH(100) - SH(50)) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];

    WEAK
    _tableView.headerAndFooterRefreshBlock = ^(BOOL isHeader) {
        STRONG
        [self loadDataWithIsHeader:isHeader];
    };
    
    [_tableView.mj_header beginRefreshing];
    
    
    self.tableView.rightOneButtonBlock = ^(MGResOrderListDataModel *dataModel, NSIndexPath *indexPath, MGGlobaOrderButtonTag tag){
        STRONG
        switch (tag) {
            case MGGlobaOrderButtonTagCancelSchedule: /// 取消安排
            {
                [self cancelScheduleOrderWithModel:dataModel];
            }
                break;
            default:
                break;
        }
    };
    
}

#pragma mark - 加载数据
- (void)loadDataWithIsHeader:(BOOL)isHeader {
    
    NSInteger pageNo = 1;
    if (isHeader) {
        pageNo = 1;
    } else {
        pageNo = self.pageNo == 0 ? 2 : self.pageNo + 1;
    }
    
    NSString *sct_date_str = [self.sct_date stringWithFormat:@"yyyy-MM-dd"];
    
    [MGBussiness loadOrderListWithParams:@{@"page_no" : @(pageNo),
                                           @"relation" : @(2),
                                           @"state" : @(MGGlobalOrderStateAlreadyPayAlreadyArrangement),
                                           @"sct_date" : sct_date_str,
                                           @"sct_time" : @(self.time)} completion:^(MGResOrderListModel *listModel) {
        
        _orderNumLabel.text = [NSString stringWithFormat:@"共%zd个订单", listModel.total_count];
        
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
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

- (void)sendMsgButtonOnClick {
    
    
}

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function


/// 取消安排
- (void)cancelScheduleOrderWithModel:(MGResOrderListDataModel *)dataModel {
    
    DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:nil message:@"您确定取消该订单的安排吗？" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    [alertView setAlertThemeMessageTip_TwoButton];
    alertView.otherButtonAction = ^{
        [MGBussiness loadOrder_Schedule_Cancel:@{@"order_id" : @(dataModel.id)} completion:^(id results) {
            if ([results boolValue]) {
                [self.tableView.mj_header beginRefreshing];
                /// 发出通知
                [[NSNotificationCenter defaultCenter] postNotificationName:TimeOrderScheduleRefreshView object:nil];
            }
        } error:nil];
    };
    
    [alertView show];
    
}

/// 初始化底部控件
- (void)setupBottomView {
    
    _bottomBgView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - SH(100), kScreenWidth, SH(100))];
    _bottomBgView.backgroundColor = [UIColor whiteColor];
    
    _orderNumLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _orderNumLabel.frame = CGRectMake(SW(30), 0, SW(300), _orderNumLabel.fontLineHeight);
    _orderNumLabel.centerY = _bottomBgView.height * 0.5;
    
    _sendMsgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendMsgButton.titleLabel.font = [UIFont boldSystemFontOfSize:getScaleHeight(36)];
    _sendMsgButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_sendMsgButton setTitle:@"群发短信" forState:UIControlStateNormal];
    [_sendMsgButton setTitleColor:MGThemeYellowColor forState:UIControlStateNormal];
    _sendMsgButton.frame = CGRectMake(kScreenWidth - SW(200), 0, SW(170), SH(40));
    _sendMsgButton.centerY = _bottomBgView.height * 0.5;
    [_sendMsgButton addTarget:self action:@selector(sendMsgButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _sendMsgButton.hidden = YES;
    
    [_bottomBgView sd_addSubviews:@[_orderNumLabel, _sendMsgButton]];
    [self.view addSubview:_bottomBgView];
    
}
#pragma mark - Getter and Setter

@end
