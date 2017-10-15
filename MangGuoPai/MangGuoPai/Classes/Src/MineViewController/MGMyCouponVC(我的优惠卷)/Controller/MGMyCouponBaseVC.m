//
//  MGMyCouponBaseVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/12.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMyCouponBaseVC.h"
#import "MGCouponOwnsModel.h"

@interface MGMyCouponBaseVC ()

@property (nonatomic, assign) NSInteger pageNo;

@end

@implementation MGMyCouponBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAK
    _tableView = [[MGMyCouponBaseTableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    
    [self.view addSubview:_tableView];
    
    
    _tableView.headerAndFooterRefreshBlock = ^(BOOL isHeader) {
        
        STRONG
        [self loadDataWithIsHeader:isHeader];
        
    };
    
    [_tableView.mj_header beginRefreshing];
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function
#pragma mark - 加载数据
- (void)loadDataWithIsHeader:(BOOL)isHeader {
    
    NSInteger pageNo = 1;
    if (isHeader) {
        pageNo = 1;
    } else {
        pageNo = self.pageNo == 0 ? 2 : self.pageNo + 1;
    }
    
    [MGBussiness loadCoupon_Owns:@{@"page_no" : @(pageNo), @"state" : @(self.state)} completion:^(MGCouponOwnsModel *listModel) {
        
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

#pragma mark - Getter and Setter




@end
