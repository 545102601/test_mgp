//
//  HomeViewController.m
//  MangGuoPai
//
//  Created by ZYN on 2017/6/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGHomeViewController.h"
#import "MGHomeTableView.h"
#import "MGHomeSearchBarView.h"
#import "MGUpgradeIDView.h"
#import "MGMessageListVC.h"
#import "MGSearchResultVC.h"
#import "MGResContentModel.h"
#import "MGContentDetailVC.h"
#import "MGLevelUpgradeVC.h"
#import "YNQRcodeViewController.h"
#import "MGCommonWebViewVC.h"
#import "MGTeacherCategoryDetailVC.h"
#import "MGHomeCouponView.h"



#import "MGWorkMyIntroVC.h"

@interface MGHomeViewController ()
/// 二维码按钮
@property (nonatomic, strong) UIButton *leftNavButton;
/// 搜索框
@property (nonatomic, strong) MGHomeSearchBarView *searchBarView;
/// 消息按钮
@property (nonatomic, strong) UIButton *rightNavButton;

/// 列表
@property (nonatomic, strong) MGHomeTableView *tableView;

/// 提示升级身份View
@property (nonatomic, strong) MGUpgradeIDView *upgradeIDView;

/// 优惠券View
@property (nonatomic, strong) MGHomeCouponView *couponView;

@end

@implementation MGHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /// 导航条
    self.backBtn.hidden = YES;
    [self setNavigationBarYellowAndWhiteBackButton];
    self.topLineView.hidden = YES;
    /// 渐变
    [self.navigationBar gradientBackgroundViewColorWithAlpha:0];

    [SESSION_MANAGER setUpgradeView:NO];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /// 加载个人信息
    [self loadUserInfo];
    
    /// 刷新升级视图
    [self refreshUpgradeView];
    /// 检测消息
    [self loadMessageCheckData];
    
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    WEAK
    
    _leftNavButton = [MGUITool buttonWithNorBgImage:nil selBgImage:nil norImage:[UIImage imageNamed:@"home_saoma"] selImage:nil target:self selector:@selector(leftNavButtonOnClick)];
    _leftNavButton.frame = CGRectMake(SW(24), 0, 27, 27);
    
    _rightNavButton = [MGUITool buttonWithNorBgImage:nil selBgImage:nil norImage:[UIImage imageNamed:@"home_xiaoxi"] selImage:[UIImage imageNamed:@"home_xiaoxi_dot"] target:self selector:@selector(rightNavButtonOnClick)];
    _rightNavButton.frame = CGRectMake(kScreenWidth - SW(24) - 27, 0, 27, 27);
    
    _searchBarView = [[MGHomeSearchBarView alloc] initWithFrame:CGRectMake(_leftNavButton.right + SW(42), 25, SW(500), 31)];
    /// 点击搜索框
    _searchBarView.searchEventBlock = ^(NSString *text){
      STRONG
        MGSearchResultVC *vc = [MGSearchResultVC new];
        vc.searchText = text;
        self.searchBarView.searchText = @"";
        PushVC(vc)
    };
    
    _leftNavButton.centerY = _searchBarView.centerY;
    _rightNavButton.centerY = _searchBarView.centerY;
    
    
    [self.navigationBar sd_addSubviews:@[_leftNavButton, _rightNavButton, _searchBarView]];
    
    _tableView = [[MGHomeTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49)];
    _tableView.navigationBar = self.navigationBar;

    _tableView.headerRefreshBlock = ^{
        STRONG
        [self loadAllDataWithIsHeader:YES];
    };
    
    [self.view addSubview:_tableView];

#pragma mark - UITableView 点击事件
    
    
    _tableView.advertCellDidSelectedBlock = ^(NSInteger index) { /// 广告
        STRONG
       MGResSettingDataDetailModel *dataModel = self.tableView.adverArray[index];
        
        [self routerWithParams:[dataModel yy_modelToJSONObject]];
        
    };
    
    _tableView.bulletinCellDidSelectedBlock = ^(NSInteger index) { /// 公告
        STRONG
        MGResContentDataModel *model = self.tableView.bulletinArray[index];
        MGContentDetailVC *vc = [MGContentDetailVC new];
        vc.id = model.id;
        vc.type = ContentDetailSouceTypeBulletin;
        PushVC(vc)
        
    };
    
    _tableView.leftImageTapBlock = ^{ /// 公告图片点击
      STRONG
    };
    
    
    _tableView.functionDidCellItemBlock = ^(NSInteger item) { /// 小功能
        STRONG
        MGTeacherCategoryDetailVC *vc = [MGTeacherCategoryDetailVC new];
        vc.dataModel = self.tableView.functionArray[item];
        vc.selectedIndex = kSelectedParentCategory;
        PushVC(vc)
    };
    
    _tableView.didCellItem = ^(MGResSettingDataDetailModel *detailModel) { /// 列表
      STRONG
        [self routerWithParams:[detailModel yy_modelToJSONObject]];
    };
    
    
}


#pragma mark - 加载数据
- (void)loadData {
    
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)loadDataWithIsHeader:(BOOL)isHeader {
    
    [self loadAllDataWithIsHeader:isHeader];
    
    [self loadMessageCheckData];
    
}

- (void)loadAllDataWithIsHeader:(BOOL)isHeader {
    if (!isHeader) {
        [TDLoading showViewInKeyWindow];
    }
    
    [MGBussiness loadHomeDataWithCompletion:^(NSDictionary *adResultsDict) {
        [MGBussiness loadHomeBulletinDataWithCompletion:^(NSArray *buResults) {
            [MGBussiness loadHomeFucntionDataWithCompletion:^(NSArray *fuResults) {
                
                    /// 广告
                    NSArray *adArray = adResultsDict[@"index_banner"];
                    if (adArray.count > 0) {
                        MGResSettingDataModel *dataModel = adArray[0];
                        self.tableView.adverArray = dataModel.details;
                    }
                
                    NSArray *two_bananer = adResultsDict[@"index_two_banner"];
                    if (two_bananer.count > 0) {
                        MGResSettingDataModel *dataModel = two_bananer[0];
                        self.tableView.workAndClassArray = dataModel.details;
                    }
                
                    self.tableView.bulletinArray = buResults;
                
                
                    NSArray *reResults = adResultsDict[@"index_three_advert"];
                    /// 动态配图 结果
                    NSMutableArray *ReResults = @[].mutableCopy;
                    for (MGResSettingDataModel *reResultDataModel in reResults) {
                        /// 动态配图 抽出 优惠券
                        if ([reResultDataModel.type integerValue] == 4) {
                            if (reResultDataModel.details.count > 0) {
                               MGResSettingDataDetailModel *detailModel = reResultDataModel.details[0];
                                if (![SESSION_MANAGER getCouponIsSuccessWithEntity_id:detailModel.entity_id]) {
                                    self.couponView.detaiModel = detailModel;
                                    [self.couponView showCouponViewWithAnimated:YES inView:ApplicationDelegate.mainTabbarVC.view];
                                }
                            }
                        } else {
                            [ReResults addObject:reResultDataModel];
                        }
                    }
                
                    self.tableView.ReResults = ReResults;
                
                    /// 小功能
                    NSMutableArray *fuResultsM = fuResults.mutableCopy;
                    NSInteger number = (fuResults.count % 4);
                    
                    MGResClassifyDataModel *model1 = [MGResClassifyDataModel new];
                    model1.id = 0;
                    if (number == 1) {
                        [fuResultsM addObject:model1];
                        [fuResultsM addObject:model1];
                        [fuResultsM addObject:model1];
                    } else if (number == 2){
                        [fuResultsM addObject:model1];
                        [fuResultsM addObject:model1];
                    } else if (number == 3){
                        [fuResultsM addObject:model1];
                    }
                    self.tableView.functionArray = fuResultsM.copy;
                    
                
                    [self refreshUpgradeView];
                    [self.tableView reloadData];
                    
                    if (isHeader) {
                        [self.tableView endRefreshingWithIsHeader:YES];
                    } else {
                        [TDLoading hideViewInKeyWindow];
                    }
                    
            }error:^(NSError *error) {
                if (isHeader) {
                    [self.tableView endRefreshingWithIsHeader:YES];
                }
            }];
        }error:^(NSError *error) {
            if (isHeader) {
                [self.tableView endRefreshingWithIsHeader:YES];
            }
        }];
    }error:^(NSError *error) {
        if (isHeader) {
            [self.tableView endRefreshingWithIsHeader:YES];
        }
    }];
}
/// 检测消息
- (void)loadMessageCheckData {
    
    if ([SESSION_MANAGER isLogin]) {
        [MGBussiness loadHomeMessageCheckdDataWithCompletion:^(id results) {
            self.rightNavButton.selected = [results boolValue];
        }];
    }
    
}

/// 加载个人信息
- (void)loadUserInfo {
    if ([SESSION_MANAGER isLogin] && !memberDataModelInstance) {
        [MGBussiness loadMineMemberGetDataWithCompletion:^(MGResMemberDataModel *dataModel) {
            [MGResMemberModel sharedInstance].data = dataModel;
        } error:nil];
    }
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 点击二维码
- (void)leftNavButtonOnClick {
    
//    MGOrderPayResultVC *vc = [MGOrderPayResultVC new];
//    PushVC(vc)
//    return;
    
//    MGTimeOrderVC *vc4 = [MGTimeOrderVC new];
//    PushVC(vc4)
//    return;
//    
//    MGScheduleVC *vc1 = [MGScheduleVC new];
//    vc1.orderId = 86;
//    PushVC(vc1)
//    return;
//
//    MGWorkVC *vc2 = [MGWorkVC new];
//    PushVC(vc2)
//    return;
    
    [self.view endEditing:YES];
    
    if (!(PROD_CONFIG)) {
        MGWorkMyIntroVC *vc = [MGWorkMyIntroVC new];
        PushVC(vc)
        return;
    }
    
    
    [YNQRcodeViewController showQRCodeVieControllerWithCompletion:^(NSString *result, NSString *type) {
        TDLog(@"qrcode -> %@",result);
        /// 是二维码
        if ([type isEqualToString:@"org.iso.QRCode"]) {
            MGCommonWebViewVC *vc = [MGCommonWebViewVC new];
            vc.urlString = result;
            PushVC(vc)
        }
    }];
 
}
/// 点击消息
- (void)rightNavButtonOnClick {
    
//    MGWorkDetailVC *vc2 = [MGWorkDetailVC new];
//    vc2.id = 3;
//    PushVC(vc2)
//    return;
    
    [self.view endEditing:YES];
    
    InterceptLoginShowAlert
    
    MGMessageListVC *vc = [MGMessageListVC new];
    PushVC(vc)
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function


- (void)refreshUpgradeView {
    
    if (!memberDataModelInstance) { /// 首次无数据 隐藏
        self.upgradeIDView.hidden = YES;
    } else {
        if (memberDataModelInstance.hasID) { /// 有身份了隐藏
            self.upgradeIDView.hidden = YES;
        } else {
            BOOL isHidden = [SESSION_MANAGER getUpgradeView];
            
            if (isHidden == NO) {
                self.upgradeIDView.hidden = NO;
                [self.view bringSubviewToFront:self.upgradeIDView];
            }
        }
    }
    
}

#pragma mark - Getter and Setter

- (MGUpgradeIDView *)upgradeIDView {
    if (!_upgradeIDView) {
        _upgradeIDView = [[MGUpgradeIDView alloc] initWithFrame:CGRectMake(0, kScreenHeight - SH(98) - 49, kScreenWidth, SH(98))];
        [self.view addSubview:_upgradeIDView];
        WEAK
        /// 关闭这个view
        _upgradeIDView.didCloseBlock = ^{
            STRONG
            self.upgradeIDView.hidden = YES;
            [SESSION_MANAGER setUpgradeView:YES];
            
        };
        /// 跳转升级页面
        _upgradeIDView.didUpgradeBlock = ^{
          STRONG
            MGLevelUpgradeVC *vc = [MGLevelUpgradeVC new];
            PushVC(vc);
        };
    }
    return _upgradeIDView;
}

- (MGHomeCouponView *)couponView {
    if (!_couponView) {
        _couponView = [[MGHomeCouponView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        WEAK
        _couponView.iconImageViewBlock = ^(MGResSettingDataDetailModel *detailModel){
            STRONG
            [self.couponView dismissCouponViewWithAnimated:YES];
            [self routerWithParams:[detailModel yy_modelToJSONObject]];
        };
    }
    return _couponView;
}


@end
