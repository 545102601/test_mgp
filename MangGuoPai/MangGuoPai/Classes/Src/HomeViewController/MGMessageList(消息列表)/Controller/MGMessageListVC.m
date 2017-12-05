//
//  MGMessageListVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/13.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMessageListVC.h"
#import "MGMessageListTableView.h"
#import "MGResMessageModel.h"
#import "MGResMessageDetailModel.h"
#import "MGMessageRejectVC.h"

@interface MGMessageListVC ()
/// 消息列表
@property (nonatomic, strong) MGMessageListTableView *tableView;

@property (nonatomic, strong) DQAlertView *workAlertView;

@property (nonatomic, strong) MGResMessageDetailDataModel *detailDataModel;

@end

@implementation MGMessageListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息列表";
    
    
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    WEAK
    _tableView = [[MGMessageListTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    
    [self.view addSubview:_tableView];
    
    
    _tableView.headerAndFooterRefreshBlock = ^(BOOL isHeader) {
        STRONG
        [self loadDataWithIsHeader:isHeader];
    };
    
    [_tableView.mj_header beginRefreshing];
    
    _tableView.didSelectedRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
        STRONG
        MGResMessageDataModel *dataModel = self.tableView.dataArrayM[indexPath.section];
        
        [self loadReadMessageWithDataModel:dataModel indexPath:indexPath];
        
        if (dataModel.entity_type == MGGlobalEntityTypeWork) {
            [self loadMessageWorkDetailWithDataModel:dataModel];
        } else {
            NSMutableString *strM = [NSString stringWithFormat:@"%@", dataModel.result].mutableCopy;
            
            if (dataModel.remark.length > 0) {
                [strM appendFormat:@",%@",dataModel.remark];
            }
            
            DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:dataModel.title message:strM cancelButtonTitle:@"我知道了" otherButtonTitle:nil];
            [alertView setAlertThemeMessageTip_OneButton];
            [alertView show];

        }
        
    };
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.workAlertView) {
        [self.view bringSubviewToFront:self.workAlertView];
    }
}

/// 阅读消息
- (void)loadReadMessageWithDataModel:(MGResMessageDataModel *)dataModel
                           indexPath:(NSIndexPath *)indexPath{
    if (dataModel.state == 50) {
        [MGBussiness loadReadMessageData:@{@"id" : @(dataModel.id)} completion:^(id results) {
            if ([results boolValue]) {
                dataModel.state = 1;
                [self.tableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
            }
        } error:nil];
    }
    
}

/// 加载是工作包的消息
- (void)loadMessageWorkDetailWithDataModel:(MGResMessageDataModel *)dataModel {
    
    [MGBussiness loadMessageDetail:@{@"id" : @(dataModel.id)} completion:^(MGResMessageDetailDataModel *detailDataModel) {
        
        _detailDataModel = detailDataModel;
        _workAlertView = [[DQAlertView alloc] initWithTitle:nil message:nil cancelButtonTitle:nil otherButtonTitle:nil];
        
        [_workAlertView setAlertThemeMessageForWorkWithTitle:detailDataModel.title
                                                content:detailDataModel.result
                                              workTitle:detailDataModel.entity_name
                                                  state:dataModel.state
                                                 target:self
                                               agreeSel:@selector(agreeButtonOnClcik)
                                              rejectSel:@selector(rejectOnClcik)
                                              cancelSel:@selector(cancelSelector)];
        [_workAlertView showInView:self.view];
        
    } error:nil];
    
    
}
#pragma mark - 加载数据
- (void)loadDataWithIsHeader:(BOOL)isHeader {
    
    NSInteger pageNo = 1;
    if (isHeader) {
        pageNo = 1;
    } else {
        pageNo = self.pageNo == 0 ? 2 : self.pageNo + 1;
    }
    
    [MGBussiness loadMessage_ListDataWithPageNo:pageNo Completion:^(MGResMessageModel *listModel) {
        
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

- (void)agreeButtonOnClcik {
    
    [MGBussiness loadProject_Team_Apply_Reply:@{@"message_id" : @(self.detailDataModel.id),
                                               @"is_reject" : @"0"} completion:^(id results) {
                                                   if ([results boolValue]) {
                                                       [self showMBText:@"同意成功"];
                                                       [self.workAlertView dismiss];
                                                   }
                                               } error:nil];
    
}

- (void)rejectOnClcik {
    
    MGMessageRejectVC *vc = [MGMessageRejectVC new];
    vc.detailDataModel = self.detailDataModel;
    WEAK
    vc.completionBlock = ^{
        STRONG
        [self.workAlertView dismiss];
    };
    PushVC(vc)
    
}

- (void)cancelSelector {
    
    [self.workAlertView dismiss];
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

@end
