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

@interface MGMessageListVC ()
/// 消息列表
@property (nonatomic, strong) MGMessageListTableView *tableView;

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


@end
