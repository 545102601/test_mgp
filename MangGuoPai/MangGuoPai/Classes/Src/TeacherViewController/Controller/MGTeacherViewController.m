//
//  MGTeacherViewController.m
//  MangGuoPai
//
//  Created by ZYN on 2017/6/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherViewController.h"
#import "MGTeacherTableView.h"
#import "MGHomeSearchBarView.h"
#import "MGResClassifyModel.h"
#import "MGResCourseListModel.h"
#import "MGTeacherAllCategoryVC.h"
#import "MGTeacherDetailVC.h"
#import "MGTeacherClassDetailVC.h"
#import "MGSearchResultVC.h"
#import "MGMyLessonVC.h"
#import "MGResSettingModel.h"
#import "MGTeacherCategoryDetailVC.h"

@interface MGTeacherViewController ()
/// 搜索框
@property (nonatomic, strong) MGHomeSearchBarView *searchBarView;
/// 我的授课按钮
@property (nonatomic, strong) UIButton *rightNavButton;
/// 列表
@property (nonatomic, strong) MGTeacherTableView *tableView;

@end

@implementation MGTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backBtn.hidden = YES;
    [self setNavigationBarYellowAndWhiteBackButton];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    BOOL isShow = memberDataModelInstance.isTutorID;
    _rightNavButton.hidden = !isShow;
    _searchBarView.left = isShow ? _rightNavButton.left - SW(570) - SW(20) : (kScreenWidth - SW(570)) *0.5;
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    WEAK

    _rightNavButton = [MGUITool buttonWithNorBgImage:nil selBgImage:nil norImage:nil selImage:nil target:self selector:@selector(rightNavButtonOnClick)];
    _rightNavButton.titleLabel.font = PFSC(28);
    [_rightNavButton setTitle:@"我的授课" forState:UIControlStateNormal];
    [_rightNavButton setTitleColor:MGThemeColor_Title_Black forState:UIControlStateNormal];
    [_rightNavButton sizeToFit];
    _rightNavButton.left = kScreenWidth - _rightNavButton.width - SW(20);
    
    _searchBarView = [[MGHomeSearchBarView alloc] initWithFrame:CGRectMake(_rightNavButton.left - SW(570) - SW(20), 25, SW(570), 31)];
    /// 点击搜索框
    
    _searchBarView.searchEventBlock = ^(NSString *text){
        STRONG
        MGSearchResultVC *vc = [MGSearchResultVC new];
        vc.searchText = text;
        self.searchBarView.searchText = @"";
        PushVC(vc)
    };
    
    _rightNavButton.centerY = _searchBarView.centerY;
    
    
    [self.navigationBar sd_addSubviews:@[_rightNavButton, _searchBarView]];
    
    _tableView = [[MGTeacherTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 49 - 64) style:UITableViewStyleGrouped];
    
    [self.view addSubview:_tableView];
    
    _tableView.advertCellDidSelectedBlock = ^(NSInteger index) { /// 广告
        STRONG
        MGResSettingDataDetailModel *dataModel = self.tableView.adverArray[index];
        
        [self routerWithPrarms:[dataModel yy_modelToJSONObject]];
        
    };
    /// 小功能
    _tableView.functionDidCellItemBlock = ^(NSInteger item) {
      STRONG
        MGResClassifyDataModel *model = self.tableView.functionArray[item];
        
        if (model.id == -1000) { /// 点击了全部
            MGTeacherAllCategoryVC *vc = [[MGTeacherAllCategoryVC alloc] init];
            vc.dataArray = self.tableView.functionArray;
            PushVC(vc)
        } else {
            MGTeacherCategoryDetailVC *vc = [MGTeacherCategoryDetailVC new];
            vc.dataModel = self.tableView.functionArray[item];
            vc.selectedIndex = kSelectedParentCategory;
            PushVC(vc)
        
        }
    };
    
    
    
    /// 点击头像
    _tableView.iconImageTapBlock = ^(MGResCourseListDataModel *model) {
      STRONG
        MGTeacherDetailVC *vc = [MGTeacherDetailVC new];
        vc.model = model;
        PushVC(vc)
    };
    

    _tableView.didSelectedRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
        STRONG
        if (indexPath.section == 2) { // 点击课程
            
            MGResCourseListDataModel *model = self.tableView.recommendArray[indexPath.row];
            MGTeacherClassDetailVC *vc = [MGTeacherClassDetailVC new];
            vc.dataModel = model;
            PushVC(vc);
        }
        
    };
    
    
    _tableView.headerAndFooterRefreshBlock = ^(BOOL isHeader) {
      STRONG
        if (isHeader) {
            [self loadAllData:YES];
        } else { /// 加载更多
            [self loadTeacherRecommendDataMoreData];
        }
        
    };
    
    [_tableView.mj_header beginRefreshing];
    
}

#pragma mark - 加载数据
- (void)loadAllData:(BOOL)isHeader {
    
    if (!isHeader) {
        [TDLoading showViewInKeyWindow];
    }
    
    /// 加载导师数据广告
    [MGBussiness loadTeacherAdverDataWithCompletion:^(NSArray *adverResults) {
        /// 加载小功能数据
        [MGBussiness loadTeacherFucntionDataWithCompletion:^(NSArray *funcResults) {
            
            [MGBussiness loadTeacherCourseListDataWithParams:@{@"page_no" : @(1),@"hot_types" : @"2"} completion:^(MGResCourseListModel *recommendModel) {
                /// 设置页码 等于1
                self.pageNo = 1;
                
                self.tableView.adverArray = adverResults;
                self.tableView.functionArray = funcResults;
                self.tableView.recommendArray = recommendModel.data;
                
                [self.tableView reloadData];
                
                BOOL condition = recommendModel.total_count == recommendModel.data.count ? NO : YES;
                [self.tableView endRefreshingWithDataCondition:condition isHeader:NO];
                
                if (isHeader) {
                    [self.tableView endRefreshingWithIsHeader:YES];
                } else {
                    [TDLoading hideViewInKeyWindow];
                }
            } error:^(NSError *error) {
                if (isHeader) {
                    [self.tableView endRefreshingWithIsHeader:YES];
                }
            }];
        } error:^(NSError *error) {
            if (isHeader) {
                [self.tableView endRefreshingWithIsHeader:YES];
            }
        }];
    } error:^(NSError *error) {
        if (isHeader) {
            [self.tableView endRefreshingWithIsHeader:YES];
        }
    }];
    
}
- (void)loadTeacherRecommendDataMoreData {
    
    NSInteger pageNo = self.pageNo == 0 ? 2 : self.pageNo + 1;
    
    /// 加载课程列表数据数据 - 分页 -
    [MGBussiness loadTeacherCourseListDataWithParams:@{@"page_no" : @(pageNo),@"hot_types" : @"2"} completion:^(MGResCourseListModel *recommendModel) {
        /// 改变页码
        self.pageNo = pageNo;
        
        NSMutableArray *oldArray = self.tableView.recommendArray.mutableCopy;
        /// 追加
        [oldArray addObjectsFromArray:recommendModel.data];
        
        self.tableView.recommendArray = [oldArray copy];
        
        [self.tableView reloadData];
        
        BOOL condition = recommendModel.total_count == oldArray.count ? NO : YES;
        
        [self.tableView endRefreshingWithDataCondition:condition isHeader:NO];
        
    } error:^(NSError *error) {
        [self.tableView endRefreshingWithIsHeader:NO];
    }];
        
}


#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 我的授课
- (void)rightNavButtonOnClick {
    
    MGMyLessonVC *vc = [MGMyLessonVC new];
    PushVC(vc)
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter


@end
