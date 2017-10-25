//
//  MGColletionListVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGFavListVC.h"
#import "MGFavListTableView.h"
#import <MJRefresh.h>
#import "MGResFavListModel.h"

@interface MGFavListVC ()

@property (nonatomic, strong) MGFavListTableView *tableView;

@end

@implementation MGFavListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收藏";
    
}


#pragma mark - 初始化控件
- (void)setupSubViews {

    _tableView = [[MGFavListTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    
    [self.view addSubview:_tableView];
    
    WEAK
    
    _tableView.didSelectedRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
      STRONG
        MGResFavListDataModel *dataModel = self.tableView.dataArrayM[indexPath.section];
        
        [self routerWithEntityType:dataModel.entity_type_id id:dataModel.entity_id];
        
    };
    
    /// 删除收藏
    _tableView.deleteFavBlock = ^(NSIndexPath *indexPath){
      STRONG
        MGResFavListDataModel *dataModel = self.tableView.dataArrayM[indexPath.section];
        
        [MGBussiness loadFav_Del:@{@"entity_id" : @(dataModel.entity_id), @"entity_type_id" : @(dataModel.entity_type_id)} completion:^(id results) {
            if ([results boolValue]) {
                
                [self.tableView.dataArrayM removeObjectAtIndex:indexPath.section];
                [self.tableView deleteSection:indexPath.section withRowAnimation:UITableViewRowAnimationLeft];
                memberDataModelInstance.fav_count;
                if (memberDataModelInstance.fav_count > 0) {
                    memberDataModelInstance.fav_count -= 1;
                    [[NSNotificationCenter defaultCenter] postNotificationName:MineReloadRefreshView object:nil];
                }
                
                if (memberDataModelInstance.fav_count == 0) {
                    [self.tableView reloadEmptyDataSet];
                }
            } else {
                [self showMBText:@"取消失败"];
            }
        } error:nil];
        
    };
    
    
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
    
    [MGBussiness loadFav_ListDataWithPageNo:pageNo Completion:^(MGResFavListModel *listModel) {
        
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
