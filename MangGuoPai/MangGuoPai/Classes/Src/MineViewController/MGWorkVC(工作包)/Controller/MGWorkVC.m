//
//  MGWorkVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkVC.h"
#import "MGResWorkListModel.h"
#import "MGWorkTableView.h"
#import "MGWorkTeamVC.h"
#import "MGWorkProductionVC.h"
#import "MGWorkDetailVC.h"

@interface MGWorkVC ()

@property (nonatomic, strong) MGWorkTableView *tableView;

@end

@implementation MGWorkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我参与的工作包";
    [self setNavigationBarGrayAndBlackBackButton];
}


#pragma mark - 初始化控件
- (void)setupSubViews {
    WEAK
    _tableView = [[MGWorkTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    
    [self.view addSubview:_tableView];
    
    
    _tableView.headerAndFooterRefreshBlock = ^(BOOL isHeader) {
        STRONG
        [self loadDataWithIsHeader:isHeader];
    };

    _tableView.buttonEventBlock = ^(NSInteger tag, MGResWorkListDataModel *dataModel){
        STRONG
        switch (tag) {
            case 1000: /// 邀请
                
                break;
            case 1001: /// 作品
            {
                MGWorkProductionVC *vc = [MGWorkProductionVC new];
                vc.dataModel = dataModel;
                PushVC(vc)
            }
                break;
            case 1002: /// 团队
            {
                MGWorkTeamVC *vc = [MGWorkTeamVC new];
                vc.dataModel = dataModel;
                PushVC(vc)
            }
                break;
            case 1003: /// 详情
            {
                MGWorkDetailVC *vc = [MGWorkDetailVC new];
                vc.id = dataModel.id;
                PushVC(vc)
            }
                break;
                
            default:
                break;
        }
        
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
    
    NSString *relation = memberDataModelInstance.isCompanyID ? @"2" : @"1";
    
    [MGBussiness loadWorkListWithParams:@{@"page_no" : @(pageNo), @"relation" : relation} completion:^(MGResWorkListModel *listModel) {
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
