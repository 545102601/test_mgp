//
//  MGMyLessonBaseVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/1.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMyLessonBaseVC.h"
#import <MJRefresh.h>
#import "MGResCourseListModel.h"
#import "YNPageScrollViewController.h"
#import "MGTeacherClassDetailVC.h"


@interface MGMyLessonBaseVC ()

/// 页码
@property (nonatomic, assign) NSInteger pageNo;

@end

@implementation MGMyLessonBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WEAK
    self.tableView.headerAndFooterRefreshBlock = ^(BOOL isHeader) {
        STRONG
        [self loadDataWithIsHeader:isHeader];
    };
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.viewControllerType = self.menuTag;
    
    self.tableView.buttonEventBlock = ^(MGResCourseListDataModel *dataModel, NSInteger tag){
        STRONG
        [self loadOpeationWithParamsId:dataModel.id tag:tag];
    };
    
    self.tableView.didSelectedRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
      STRONG
        MGResCourseListDataModel *dataModel = self.tableView.dataArrayM[indexPath.section];
        MGTeacherClassDetailVC *vc = [MGTeacherClassDetailVC new];
        vc.dataModel = dataModel;
        PushVC(vc)
        
    };
    
    if (self.menuTag == MGGlobaMenuTagLeft) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addLessonCompletionReloadRefreshView) name:AddLessonCompletionReloadRefreshView object:nil];
    }
    
    
}

#pragma mark - 加载数据
- (void)loadDataWithIsHeader:(BOOL)isHeader {
    
    NSInteger pageNo = 1;
    if (isHeader) {
        pageNo = 1;
    } else {
        pageNo = self.pageNo == 0 ? 2 : self.pageNo + 1;
    }
    
    NSMutableDictionary *dictM = @{@"page_no" : @(pageNo), @"is_self" : @(1)}.mutableCopy;
    if (self.menuTag == MGGlobaMenuTagRight) {
        [dictM setObject:@(50) forKey:@"state"];
    }
    
    [MGBussiness loadTeacherCourseListDataWithParams:dictM.copy completion:^(MGResCourseListModel *listModel) {
        
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

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

- (void)loadOpeationWithParamsId:(long)id tag:(NSInteger)tag {
    if (tag == 1002) { /// 上架
        [MGBussiness loadCourseOnWithId:id completion:^(NSNumber *results) {
            for (MGMyLessonBaseVC *vc in self.ynPageScrollViewController.viewControllers) {
                [vc.tableView.mj_header beginRefreshing];
            }
            
        } error:nil];
    } else if (tag == 1003) { /// 下架
        [MGBussiness loadCourseOffWithId:id completion:^(NSNumber *results) {
            for (MGMyLessonBaseVC *vc in self.ynPageScrollViewController.viewControllers) {
                [vc.tableView.mj_header beginRefreshing];
            }

        } error:nil];
    } else if (tag == 1004) { /// 删除
        [MGBussiness loadCourseDelWithId:id completion:^(NSNumber *results) {
            for (MGMyLessonBaseVC *vc in self.ynPageScrollViewController.viewControllers) {
                [vc.tableView.mj_header beginRefreshing];
            }
            
        } error:nil];
        
    }
    
}


#pragma mark - Getter and Setter
- (MGMyLessonBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MGMyLessonBaseTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
    }
    return _tableView;
    
}

/// 通知
- (void)addLessonCompletionReloadRefreshView {
    
    [self.tableView.mj_header beginRefreshing];
    
}


@end
