//
//  MGWorkDetailVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkDetailVC.h"
#import "MGWorkDetailTableView.h"
#import "UIImage+Extend.h"
#import "MGResProjectDetailModel.h"
#import "MGWorkDetailTableHeader.h"
#import "MGTeacherDetailVC.h"
#import "MGResCourseListModel.h"
#import "MGTeacherClassDetailVC.h"
#import "MGWorkVC.h"
#import "MGWorkApplyVC.h"
#import "MGLevelUpgradeVC.h"
#import "MGWorkVC.h"
#import "MGWorkLookProductVC.h"
#import "MGWorkWriteCommentVC.h"
#import "MGWorkLookOtherVC.h"
#import "TDUMShareAlertView.h"

@interface MGWorkDetailVC ()

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) MGWorkDetailTableHeader *tableHeader;

@property (nonatomic, strong) MGWorkDetailTableView *tableView;

@property (nonatomic, strong) UIView *bottomBgView;
/// 想要
@property (nonatomic, strong) UIButton *wantButton;
/// 分享
@property (nonatomic, strong) UIButton *shareButton;
/// 报名
@property (nonatomic, strong) UIButton *applyButton;

@end

@implementation MGWorkDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarGrayAndBlackBackButton];
    
    _rightButton = [self setRightButtonWithTitle:@"我的工作包" target:self selector:@selector(rightButtonOnCclick)];
    
    _rightButton.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessRefreshTable) name:LoginSuccessRefreshTable object:nil];
    
}


#pragma mark - 初始化控件
- (void)setupSubViews {
    WEAK
    _tableHeader = [[MGWorkDetailTableHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    _tableHeader.iconImageViewLoadCompletion = ^{
        STRONG
        UIView *headerView = self.tableView.tableHeaderView;
        [headerView layoutSubviews];
        self.tableView.tableHeaderView = headerView;
    };
    _tableView = [[MGWorkDetailTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - SH(100)) style:UITableViewStyleGrouped];
    
    [self.view addSubview:_tableView];
    
    _tableView.expendButtonBlock = ^(NSIndexPath *indexPath){
        STRONG
        [UIView performWithoutAnimation:^{
            [self.tableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
        }];
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
        if (indexPath.section == 6) { // 点击课程
            
            MGResCourseListDataModel *model = self.tableView.dataModel.courses[indexPath.row];
            MGTeacherClassDetailVC *vc = [MGTeacherClassDetailVC new];
            vc.dataModel = model;
            PushVC(vc);
        }
        
    };

    /// 查看作品
    _tableView.applyTeamProductBlock = ^(MGResProjectActorDataModel *actorModel){
        STRONG
        MGWorkLookProductVC *vc = [MGWorkLookProductVC new];
        vc.actorModel = actorModel;
        PushVC(vc)
        
        
    };
    /// 评论团队
    _tableView.applyTeamCommentBlock = ^(MGResProjectActorDataModel *actorModel){
        STRONG
        
        MGWorkWriteCommentVC *vc = [MGWorkWriteCommentVC new];
        vc.actorModel = actorModel;
        vc.completionBlock = ^(NSString *comment){
            actorModel.company_comments = comment;
            [UIView performWithoutAnimation:^{
                [self.tableView reloadSection:5 withRowAnimation:UITableViewRowAnimationNone];
            }];
        };
        PushVC(vc)
    };
    
    _tableView.lookOtherFileButtonBlock = ^(MGResProjectActorDataModel *actorModel){
        STRONG
        MGWorkLookOtherVC *vc = [MGWorkLookOtherVC new];
        vc.actorModel = actorModel;
        PushVC(vc)
    };
    
    /// 企业
    if (memberDataModelInstance.isCompanyID) {
        _tableView.height = kScreenHeight - 64;
    } else {
        /// 创建底部视图
        [self setupBottomView];
    }
    
}

#pragma mark - 加载数据
- (void)loadData {

    _bottomBgView.hidden = YES;
    _tableView.hidden = YES;
    
    [TDLoading showViewInKeyWindow];
    [MGBussiness loadProject_Get:@{@"id" : @(self.id)} completion:^(MGResProjectDetailDataModel *dataModel) {
        
            [TDLoading hideViewInKeyWindow];
            /// 设置 右边 按钮
            if (memberDataModelInstance.isStudentID) {
                _rightButton.hidden = NO;
            }
            
            _tableView.hidden = NO;
            _bottomBgView.hidden = NO;
            
            /// 设置标题
//            self.title = dataModel.project_name;
        
            self.title = @"工作包详情";
        
            dataModel.hiddenExpendButton = dataModel.progress <= 99.9 ? YES : NO;
        
            /// 头部
            self.tableHeader.dataModel = dataModel;
            self.tableView.tableHeaderView = self.tableHeader;
            
            self.tableView.dataModel = dataModel;
            
            [self.tableView reloadData];
            
            self.wantButton.enabled = !dataModel.is_favor;
            
            /// 控制报名截止按钮
            if (dataModel.progress >= 33.3) {
                self.applyButton.hidden = YES;
            }
        
            [self loadProductionAndComment];
        
        } error:nil];
    
}
/// 加载作品
- (void)loadProductionAndComment {
    /// 评审结束才加载
    if (self.tableView.dataModel.progress <= 99.9) return;
    
    [self loadProductionAndCommentWithArray:@[].mutableCopy
                                originArray:self.tableView.dataModel.actors
                               currentIndex:0 currentCount:0];
}


- (void)loadProductionAndCommentWithArray:(NSMutableArray *)arrayM
                              originArray:(NSArray *)originArray
                             currentIndex:(NSInteger)currentIndex
                             currentCount:(NSUInteger)currentCount {
    /// 次数 3 次 前三名
    if (currentIndex < originArray.count && currentCount < 3) {
        MGResProjectActorDataModel *actorModel = originArray[currentIndex];
        [MGBussiness loadProject_Actor_Get:@{@"id" : @(actorModel.id)} completion:^(MGResProjectActorDataModel *actorDataModel) {
            NSInteger CoIndex = currentCount;
            
            if (actorDataModel.integrated_ranking > 0) {
                [arrayM addObject:actorDataModel];
                CoIndex = CoIndex + 1;
            }
            /// 递归
            [self loadProductionAndCommentWithArray:arrayM originArray:originArray currentIndex:currentIndex + 1 currentCount:CoIndex];
        } error:nil];
    } else {
        self.tableView.dataModel.productionAndCommentArray = arrayM;
        [UIView performWithoutAnimation:^{
            [self.tableView reloadSection:4 withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
}


#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 我的工作包
- (void)rightButtonOnCclick {
    
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[MGWorkVC class]]) {
            PopVC
            return;
        }
    }
    
    MGWorkVC *vc = [MGWorkVC new];
    PushVC(vc)
    
}
/// 想要
- (void)wantButtonOnClick {
    
    InterceptLoginShowAlert
    
    [MGBussiness loadProject_Want:@{@"id" : @(self.tableView.dataModel.id)} completion:^(id results) {
      
        if ([results boolValue]) {
            self.wantButton.enabled = NO;
            self.tableView.dataModel.is_favor = YES;
            self.tableView.dataModel.want_count += 1;
            [self.tableView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
        }
        
    } error:nil];
    
}
/// 分享
- (void)shareButtonOnClick {
    
    TDUMShareAlertView *alertView = [TDUMShareAlertView showUMengShareViewWithTitle:@"工作包详情" shareContent:self.tableView.dataModel.project_name shareImage:[UIImage imageNamed:@"mine_manguo_fx"] imageUrl:nil shareUrl:[NSString stringWithFormat:@"https://www.mangopi.com.cn/wx/project/info/%ld.html", self.tableView.dataModel.id]];
    
    [alertView show];
    
//    https://www.mangopi.com.cn/wx/project/info/3.html
}

/// 报名
- (void)applyButtonOnClick {
    
    InterceptLoginShowAlert
    
    if (!memberDataModelInstance.isStudentID) {
        DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:@"提示" message:@"只有升级成为学生才能参与工作包" cancelButtonTitle:@"暂不认证" otherButtonTitle:@"去认证"];
        [alertView setAlertThemeMessageTip_TwoButton];
        alertView.otherButtonAction = ^{
            MGLevelUpgradeVC *vc = [MGLevelUpgradeVC new];
            PushVC(vc);
        };
        [alertView show];
        return;
    }
    
    
    MGWorkApplyVC *vc = [MGWorkApplyVC new];
    vc.dataModel = self.tableView.dataModel;
    PushVC(vc)
    
}

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

- (void)setupBottomView {
    
    UIView *bottomBgView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - SH(100), kScreenWidth, SH(100))];
    bottomBgView.backgroundColor = [UIColor whiteColor];
    _bottomBgView = bottomBgView;
    
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, MGSepLineHeight)];
    bottomLineView.backgroundColor = MGSepColor;
    
    _applyButton = [MGUITool buttonWithBGColor:nil title:@"立刻报名" titleColor:MGThemeColor_Title_Black font:MGThemeFont_28 target:self selector:@selector(applyButtonOnClick)];
    _applyButton.frame = CGRectMake(kScreenWidth - SW(30) - SW(150), SH(20), SW(150), SH(60));
    [_applyButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_applyButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    _applyButton.layer.cornerRadius = MGButtonLayerCorner;
    _applyButton.layer.masksToBounds = YES;
    
    _wantButton = [MGUITool buttonWithBGColor:nil title:@"想去" titleColor:MGThemeColor_Common_Black font:MGThemeFont_24 target:self selector:@selector(wantButtonOnClick)];
    UIImage *wantImage = [UIImage imageNamed:@"teacher_xiangting_nor"];
    [_wantButton setImage:wantImage forState:UIControlStateNormal];
    [_wantButton setImage:[UIImage imageNamed:@"teacher_xiangting_sel"] forState:UIControlStateDisabled];
    _wantButton.titleEdgeInsets = UIEdgeInsetsMake(0, SW(20), 0, 0);
    [_wantButton sizeToFit];
    _wantButton.width = _wantButton.width + SW(20);
    _wantButton.centerY = bottomBgView.height * 0.5;
    _wantButton.left = SW(30);
    
    _shareButton = [MGUITool buttonWithBGColor:nil title:@"分享" titleColor:MGThemeColor_Common_Black font:MGThemeFont_24 target:self selector:@selector(shareButtonOnClick)];
    
    UIImage *shareImage = [UIImage imageNamed:@"found_icon_share"];
    shareImage = [UIImage imageWithImage:shareImage scaledToSize:CGSizeMake(SW(54), SW(54))];
    [_shareButton setImage:shareImage forState:UIControlStateNormal];
    [_shareButton sizeToFit];
    _shareButton.centerY = bottomBgView.height * 0.5;
    _shareButton.left = _wantButton.right + SW(20);
    
    
    [bottomBgView sd_addSubviews:@[bottomLineView, _applyButton, _wantButton, _shareButton]];
    
    [self.view addSubview:bottomBgView];
    
}

#pragma mark - Getter and Setter
/// 登录成功刷新
- (void)loginSuccessRefreshTable {
    
    [self loadData];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
