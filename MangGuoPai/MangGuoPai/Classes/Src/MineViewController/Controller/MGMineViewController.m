//
//  MGMineViewController.m
//  MangGuoPai
//
//  Created by ZYN on 2017/6/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMineViewController.h"
#import "MGLoginVC.h"
#import "MGMineTableHeaderView.h"
#import "MGMineTableView.h"
#import "MGMineTableViewModel.h"
#import "MGMineSettingVC.h"
#import "MGMyOrderVC.h"
#import "MGFavListVC.h"
#import "MGResMemberModel.h"
#import "MGLevelUpgradeVC.h"
#import "MGMessageListVC.h"
#import "MGMineInfoVC.h"
#import "MGWorkVC.h"
#import "MGAccountVC.h"
#import "MGMyFoundVC.h"
#import "MGMyLessonVC.h"
#import "MGMyCouponVC.h"
#import "MGScheduleVC.h"

@interface MGMineViewController () <MGMineTableHeaderViewDelegate>

@property (nonatomic, strong) MGMineTableHeaderView *headerView;

@property (nonatomic, strong) MGMineTableView *tableView;

@end

@implementation MGMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.hidden = YES;
    
}


#pragma mark - 初始化控件
- (void)setupSubViews {
    WEAK
    MGMineTableHeaderView *headerView = [[MGMineTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(340) + SH(120) + SH(48))];
    _headerView = headerView;
    _headerView.delegate = self;
    
    _tableView = [[MGMineTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStyleGrouped];
    
    
    _tableView.tableHeaderView = headerView;
    
    [self.view addSubview:_tableView];
    
    _tableView.headerRefreshBlock = ^{
        STRONG
        
        [self loadMemeberInfoData:YES];
    };
    
    
    _tableView.didSelectedRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
        STRONG
        
        InterceptLoginShowAlert
        
        if (!memberDataModelInstance) return;
        
        MGMineTableViewModel *viewModel = self.tableView.dataArrayM[indexPath.section][indexPath.row];
        switch (viewModel.type) {
            case TableViewModelTypeID:     /// 身份
            {
                MGLevelUpgradeVC *vc = [MGLevelUpgradeVC new];
                PushVC(vc)
                break;
            }
            case TableViewModelTypeOrder:   /// 订单
            {
                MGMyOrderVC *vc = [MGMyOrderVC new];
                PushVC(vc)
                
            }
                break;
            case TableViewModelTypeWork:    /// 工作包
            {
                MGWorkVC *vc = [MGWorkVC new];
                PushVC(vc)
            }
                break;
            case TableViewModelTypeClass:   /// 我的授课
            {
                MGMyLessonVC *vc = [MGMyLessonVC new];
                PushVC(vc)
            }
                break;
            case TableViewModelTypeClassSchedule: /// 我的授课安排
            {
                MGScheduleVC *vc = [MGScheduleVC new];
                vc.sourceType = MGScheduleVCSourceTypeLook;
                PushVC(vc)
            }
                break;
            case TableViewModelTypeAccount: /// 账号
            {
                MGAccountVC *vc = [MGAccountVC new];
                PushVC(vc)
            }
                break;
                
            case TableViewModelTypeCoupon: /// 我的优惠券
            {
                MGMyCouponVC *vc = [MGMyCouponVC new];
                PushVC(vc)
            }
                break;
            case TableViewModelTypeSetting: /// 设置
            {
                MGMineSettingVC *vc = [MGMineSettingVC new];
                PushVC(vc)
            }
                break;
                
        }

    };
    [self reloadView];
}

#pragma mark - 加载数据
- (void)loadData {
    
    /// 加载个人信息
    if (!memberDataModelInstance && [SESSION_MANAGER isLogin]) {
        [self.tableView.mj_header beginRefreshing];
    }
    
}


#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

/// tag = 1001 收藏， 1002 = msg  , 1003 = 动态
- (void)didSmallButtonOnClickWithTag:(NSInteger)tag {
    InterceptLoginShowAlert
    switch (tag) {
        case 1001: /// 收藏
        {
            MGFavListVC *vc = [MGFavListVC new];
            PushVC(vc)
        }
            break;
        case 1002: /// msg
        {
            MGMessageListVC *vc = [MGMessageListVC new];
            PushVC(vc)
        }
            break;
        case 1003: /// 动态
        {
            MGMyFoundVC *vc = [MGMyFoundVC new];
            PushVC(vc)
        }
            break;
        case 1004: /// 去个人信息
        {
            MGMineInfoVC *vc = [MGMineInfoVC new];
            PushVC(vc)
        }
            break;
            
    }
    
    
}
#pragma mark - Public Function

#pragma mark - Private Function
/// 加载个人信息
- (void)loadMemeberInfoData:(BOOL)isHeader {
    
    if ([SESSION_MANAGER isLogin]) {
        if (!isHeader) {
            [TDLoading showViewInKeyWindow];
        }
        [MGBussiness loadMineMemberGetDataWithCompletion:^(MGResMemberDataModel *dataModel) {
            [MGResMemberModel sharedInstance].data = dataModel;
            [self endRefreshAndHideLoading:isHeader];
            
            [self reloadView];
        } error:^(NSError *error) {
            [self endRefreshAndHideLoading:isHeader];
        }];
    } else {
        [self endRefreshAndHideLoading:isHeader];
    }
}

- (void)endRefreshAndHideLoading:(BOOL)isHeader {
    if (isHeader) {
        [self.tableView.mj_header endRefreshing];
    } else {
        [TDLoading hideViewInKeyWindow];
    }
}

- (void)reloadView {
    
    /// 头部数据
    self.headerView.dataModel = memberDataModelInstance;
    ///
    NSArray *array = [MGMineTableViewModel getTableViewModelWithModel:memberDataModelInstance];
    self.tableView.dataArrayM = array.mutableCopy;
    [self.tableView reloadData];
    
}

/// 注册通知
- (void)registerNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessRefreshTable) name:LoginSuccessRefreshTable object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(outSuccessRefreshTable) name:OutSuccessRefreshTable object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mineReloadRefreshView) name:MineReloadRefreshView object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mineReloadReLoadRefreshView) name:MineReloadReLoadRefreshView object:nil];
    
    
    
}
/// 登录成功
- (void)loginSuccessRefreshTable {
    [self loadMemeberInfoData:NO];
}
/// 退出成功
- (void)outSuccessRefreshTable {
    
    [self loadMemeberInfoData:NO];
    [self reloadView];
}
/// 刷新信息
- (void)mineReloadRefreshView {
    [self reloadView];
}
/// 重新加载刷新
- (void)mineReloadReLoadRefreshView {
    
    [self loadMemeberInfoData:NO];
}


#pragma mark - Getter and Setter

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//                MGLoginVC *loginVC = [MGLoginVC new];
//    
//                MGNavigationController *nav = [[MGNavigationController alloc] initWithRootViewController:loginVC];
//    
//                [self presentViewController:nav animated:YES completion:nil];
//}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
