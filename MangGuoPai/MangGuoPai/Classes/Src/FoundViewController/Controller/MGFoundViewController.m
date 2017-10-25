//
//  MGFoundViewController.m
//  MangGuoPai
//
//  Created by ZYN on 2017/6/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGFoundViewController.h"
#import "MGResTrendListModel.h"
#import <MJRefresh.h>
#import "MGPublishFoundVC.h"
#import "MGFoundDetailVC.h"
#import "MGReverseFoundVC.h"
#import "UITabBar+Extend.h"
#import "MGFoundCommentPublisherVC.h"

@interface MGFoundViewController ()

@property (nonatomic, strong) UIButton *rightButton;


@end

@implementation MGFoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.backBtn.hidden = YES;
    self.title = @"发现";
    
    [self setNavigationBarYellowAndWhiteBackButton];
    
    /// 有参数就隐藏导航条
    if (self.externRequestParams.count > 0) {
        self.navigationBar.hidden = YES;
        self.statusBarIsWhite = NO;
    } 
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(foundDetailPariseAndFavRefreshView:) name:FoundDetailPariseAndFavRefreshView object:nil];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    BOOL isShow = memberDataModelInstance.isTutorID || memberDataModelInstance.isCompanyID || memberDataModelInstance.isCompanyID;
    _rightButton.hidden = !isShow;
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    
    _rightButton = [self setRightButtonWithTitle:@"+动态" target:self selector:@selector(rightButtonOnClick)];
    
    _tableView = [[MGFoundTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStyleGrouped];
    
    
    [self.view addSubview:_tableView];
    
    WEAK
    
    _tableView.didSelectedRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
        STRONG
        MGResTrendListDataModel *dataModel = self.tableView.dataArrayM[indexPath.section];
        MGFoundDetailVC *vc = [MGFoundDetailVC new];
        vc.dataModel = dataModel;
        PushVC(vc)
    };
    
    _tableView.headerAndFooterRefreshBlock = ^(BOOL isHeader) {
        
        STRONG
        [self loadDataWithIsHeader:isHeader];
        /// 隐藏小红点
        [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
    };
    
    
    _tableView.showAllContentTextBlock = ^(NSIndexPath *indexPath){
        STRONG
        MGResTrendListDataModel *dataModel = self.tableView.dataArrayM[indexPath.section];
        dataModel.isOpening = YES;
        [UIView performWithoutAnimation:^{
            [self.tableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
        }];
    };
    /// 转发
    _tableView.showAllContentTextForwardBlock = ^(NSIndexPath *indexPath){
        STRONG
        MGResTrendListDataModel *dataModel = self.tableView.dataArrayM[indexPath.section];
        dataModel.forward_trend.isOpening = YES;
        [UIView performWithoutAnimation:^{
            [self.tableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
        }];
    };
    
    _tableView.forwardBgViewTapBlock = ^(MGResTrendListDataModel *dataModel){
        STRONG
        MGFoundDetailVC *vc = [MGFoundDetailVC new];
        vc.dataModel = dataModel;
        PushVC(vc)
    };
    
    [_tableView.mj_header beginRefreshing];
    
    
    /// 收藏
    _tableView.favEventBlock = ^(MGResTrendListDataModel *dataModel, NSIndexPath *indexPath){
        STRONG
        InterceptLoginShowAlert
        MGFoundCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self favFoundCell:cell dataModel:dataModel];
    };
    
    
    /// 点击工具条
    _tableView.tapButtonBlock = ^(NSInteger type, MGResTrendListDataModel *dataModel, NSIndexPath *indexPath){
        STRONG
        InterceptLoginShowAlert
        MGFoundCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        switch (type) {
            case 0:  /// 转发
            {
                MGReverseFoundVC *vc = [MGReverseFoundVC new];
                vc.dataModel = dataModel;
                PushVC(vc)
            }
                break;
            case 1:  /// 详情
            {
//                MGFoundDetailVC *vc = [MGFoundDetailVC new];
//                vc.dataModel = dataModel;
//                PushVC(vc)
                MGResTrendListDataModel *trendDataModel = self.tableView.dataArrayM[indexPath.section];
                MGFoundCommentPublisherVC *vc = [MGFoundCommentPublisherVC new];
                vc.trend_id = trendDataModel.id;
                PushVC(vc);
            }
                break;
            case 2: /// 点赞
            {
                [self praiseFoundCell:cell dataModel:dataModel];
            }
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
    NSMutableDictionary *params = @{@"page_no" : @(pageNo)}.mutableCopy;
    if (self.externRequestParams.count > 0) {
        [params setValuesForKeysWithDictionary:self.externRequestParams];
    }
                                    
    [MGBussiness loadTrendListWithParams:params completion:^(MGResTrendListModel *listModel) {
        
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

/// 右边按钮
- (void)rightButtonOnClick {
    
    MGPublishFoundVC *vc = [MGPublishFoundVC new];
//    WEAK
    vc.publishCompletionBlock = ^{
//        STRONG
//        [self.tableView.mj_header beginRefreshing];
    };
    PushVC(vc)
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

/// 收藏
- (void)favFoundCell:(MGFoundCell *)cell dataModel:(MGResTrendListDataModel *)dataModel {

    [MGBussiness loadWantCountWithParams:@{@"entity_id" : @(dataModel.id) , @"entity_type_id" : @(MGGlobalEntityTypeFriend)} completion:^(id results) {
        
        if ([results boolValue]) {
            [cell.cellInfoView setFavIsCollection:YES];
            dataModel.currentIsFav = YES;
        }
        
    } error:nil];
    
}

/// 点赞
- (void)praiseFoundCell:(MGFoundCell *)cell dataModel:(MGResTrendListDataModel *)dataModel {
    
    [MGBussiness loadPraiseWithParams:@{@"id" : @(dataModel.id)} completion:^(id results) {
        if ([results boolValue]) {
            [cell.toolsView setLiked:YES withAnimation:YES];
            dataModel.currentIsParise = YES;
        }
    } error:nil];
    
    
}

/// 收到刷新通知
- (void)foundDetailPariseAndFavRefreshView:(NSNotification *)notification {
    
    [self.tableView.mj_header beginRefreshing];
//    NSDictionary *dict = notification.userInfo;
//    NSNumber *ID = dict[@"id"];
//    NSString *type = dict[@"type"];
//    
//    for (int i = 0; i < self.tableView.dataArrayM.count; i++) {
//        MGResTrendListDataModel *dataModel = self.tableView.dataArrayM[i];
//        if (dataModel.id == [ID longValue]) {
//            
//            MGFoundCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
//            if ([type isEqualToString:@"parise"]) {
//                [cell.toolsView setLiked:YES withAnimation:YES];
//                break;
//            } else if ([type isEqualToString:@"fav"]){;
//                [cell.cellInfoView setFavIsCollection:YES];
//                break;
//            }   
//        }
//    }
//    }
    
}

#pragma mark - Getter and Setter

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
