//
//  MGSearchResultVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/28.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGSearchResultVC.h"
#import "MGSearchResultTableView.h"
#import <MJRefresh.h>
#import "MGResEntityModel.h"
#import "MGHomeSearchBarView.h"
#import "MGTeacherDetailVC.h"
#import "MGWorkDetailVC.h"

@interface MGSearchResultVC ()
/// 搜索框
@property (nonatomic, strong) MGHomeSearchBarView *searchBarView;
/// 我的授课按钮
@property (nonatomic, strong) UIButton *rightNavButton;

@property (nonatomic, strong) MGSearchResultTableView *tableView;

@end

@implementation MGSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backBtn.hidden = YES;
    
    [self setNavigationBarYellowAndWhiteBackButton];
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    WEAK
    _rightNavButton = [MGUITool buttonWithNorBgImage:nil selBgImage:nil norImage:nil selImage:nil target:self selector:@selector(rightNavButtonOnClick)];
    _rightNavButton.titleLabel.font = PFSC(28);
    [_rightNavButton setTitle:@"取消" forState:UIControlStateNormal];
    [_rightNavButton setTitleColor:MGThemeColor_Title_Black forState:UIControlStateNormal];
    [_rightNavButton sizeToFit];
    _rightNavButton.left = kScreenWidth - _rightNavButton.width - SW(30);
    
    _searchBarView = [[MGHomeSearchBarView alloc] initWithFrame:CGRectMake(_rightNavButton.left - SW(600) - SW(30), 25, SW(600), 31)];
    _searchBarView.searchText = self.searchText;
    /// 点击搜索框
    _searchBarView.searchEventBlock = ^(NSString *text){
      STRONG
        self.searchText = text;
        [self.tableView.mj_header beginRefreshing];
    };
    _rightNavButton.centerY = _searchBarView.centerY;
    
    
    [self.navigationBar sd_addSubviews:@[_rightNavButton, _searchBarView]];
    
    
    _tableView = [[MGSearchResultTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    
    [self.view addSubview:_tableView];
    
    _tableView.didSelectedRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
      STRONG
        MGResEntityDataModel *model = self.tableView.dataArrayM[indexPath.section];
        [self routerWithEntityType:model.entity_type_id id:model.id];
        
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
    
    [MGBussiness loadFullSearchDataWithPageNo:pageNo params:@{@"search_text" : self.searchText} Completion:^(MGResEntityModel *listModel) {
        
        self.pageNo = pageNo;
        if (isHeader) {
            self.tableView.dataArrayM = listModel.data.mutableCopy;
        } else {
            NSMutableArray *oldArray = self.tableView.dataArrayM.mutableCopy;
            /// 追加
            [oldArray addObjectsFromArray:listModel.data];
            self.tableView.dataArrayM = [oldArray copy];
        }
        self.tableView.searchText = self.searchText;
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
/// 右边按钮
- (void)rightNavButtonOnClick {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

@end
