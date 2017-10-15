//
//  MGTeacherCategoryBaseDetailVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/23.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherCategoryBaseDetailVC.h"
#import "MGResCourseListModel.h"
#import "MGTeacherDetailVC.h"
#import "MGTeacherClassDetailVC.h"

@interface MGTeacherCategoryBaseDetailVC ()

@property (nonatomic, assign) NSInteger pageNo;

@end

@implementation MGTeacherCategoryBaseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAK
    _tableView = [[MGTeacherCategoryBaseDetailTableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
  
    [self.view addSubview:_tableView];
    
    
    _tableView.headerAndFooterRefreshBlock = ^(BOOL isHeader) {
        
        STRONG
        [self loadDataWithIsHeader:isHeader];
        
    };
    
    /// 点击头像
    _tableView.iconImageTapBlock = ^(MGResCourseListDataModel *model) {
        STRONG
        MGTeacherDetailVC *vc = [MGTeacherDetailVC new];
        vc.model = model;
        PushVC(vc)
    };
    // 点击课程
    _tableView.didSelectedRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
        STRONG
            MGResCourseListDataModel *model = self.tableView.dataArrayM[indexPath.row];
            MGTeacherClassDetailVC *vc = [MGTeacherClassDetailVC new];
            vc.dataModel = model;
            PushVC(vc);
        
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
    
    [MGBussiness loadTeacherCourseListDataWithParams:@{@"page_no" : @(pageNo), @"classify_id" : @(self.detailModel.id)} completion:^(MGResCourseListModel *listModel) {
        
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
