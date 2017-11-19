//
//  MGTeacherDetailVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherDetailVC.h"
#import "MGResCourseTutorModel.h"
#import "MGTeacherDetailHeaderView.h"
#import "MGTeacherDetailFooterView.h"
#import "MGTeacherDetailTableView.h"
#import "MGTeacherClassDetailVC.h"
#import "MGSelectCourseView.h"
#import "MGTeacherOrderVC.h"
#import "MGAddLessonVC.h"

@interface MGTeacherDetailVC ()

@property (nonatomic, strong) UIButton *rightNavButton;

/// 头部view
@property (nonatomic, strong) MGTeacherDetailHeaderView *headerView;
/// 列表
@property (nonatomic, strong) MGTeacherDetailTableView *tableView;
/// 底部view
@property (nonatomic, strong) MGTeacherDetailFooterView *footerView;
/// 选择课程
@property (nonatomic, strong) MGSelectCourseView *selectCourseView;


@end

@implementation MGTeacherDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"导师详情";
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    BOOL isShow = memberDataModelInstance.isTutorID;
    _rightNavButton.hidden = !isShow;
    
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    
    _rightNavButton = [MGUITool buttonWithNorBgImage:nil selBgImage:nil norImage:nil selImage:nil target:self selector:@selector(rightNavButtonOnClick)];
    _rightNavButton.titleLabel.font = PFSC(28);
    [_rightNavButton setTitle:@"+授课" forState:UIControlStateNormal];
    [_rightNavButton setTitleColor:MGThemeColor_Title_Black forState:UIControlStateNormal];
    [_rightNavButton sizeToFit];
    _rightNavButton.left = kScreenWidth - _rightNavButton.width - SW(20);
    _rightNavButton.centerY = self.navigationBar.titleLabel.centerY;
    [self.navigationBar addSubview:_rightNavButton];
    
    
    WEAK
    _headerView = [[MGTeacherDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(930))];
    _headerView.iconImageViewLoadCompletion = ^{
        STRONG
        
        UIView *headerView = self.tableView.tableHeaderView;
        [headerView layoutSubviews];
        self.tableView.tableHeaderView = headerView;
    };
    
    
    _footerView = [[MGTeacherDetailFooterView alloc] initWithFrame:CGRectMake(0, kScreenHeight - SH(140), kScreenWidth, SH(140))];
    
    /// 想听
    _footerView.wantBlock = ^{
        STRONG
        [self loadWantCount];
    };
    /// 立刻听
    _footerView.atOneceWantBlock = ^{
        STRONG
        InterceptLoginShowAlert
        
        self.selectCourseView.arrayM = self.tableView.dataArrayM;
        [KeyWindow addSubview:self.selectCourseView];
        [self.selectCourseView showSelectCourseWithAnimated:YES inView:KeyWindow];
        
    };
    
    _tableView = [[MGTeacherDetailTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64  - _footerView.height) style:UITableViewStyleGrouped];
    
    _tableView.tableHeaderView = _headerView;
    
    [self.view sd_addSubviews:@[_tableView, _footerView]];
    
    
    _tableView.didSelectedRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
        STRONG
        MGResCourseListDataModel *dataModel = self.tableView.dataArrayM[indexPath.row];
        MGTeacherClassDetailVC *vc = [MGTeacherClassDetailVC new];
        vc.dataModel = dataModel;
        PushVC(vc)
    };
}



#pragma mark - 加载数据
- (void)loadData {
    self.headerView.hidden = YES;
    self.footerView.hidden = YES;
    self.tableView.hidden = YES;
    long id = self.id > 0 ? self.id : self.model.member_id;
    [MGBussiness loadTeacherDetailDataWithParam:id completion:^(MGResCourseTutorDataModel *dataModel) {
        self.headerView.dataModel = dataModel;
        
        self.footerView.dataModel = dataModel;
        self.tableView.dataArrayM = dataModel.courses.mutableCopy;
        
        UIView *headerView = self.tableView.tableHeaderView;
        headerView.height = self.headerView.headerHeight;
        self.tableView.tableHeaderView = headerView;
        
        [self.tableView reloadData];
        
        self.headerView.hidden = NO;
        self.footerView.hidden = NO;
        self.tableView.hidden = NO;
        
    } error:nil];
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 右边按钮
- (void)rightNavButtonOnClick {
    
    MGAddLessonVC *vc = [MGAddLessonVC new];
    PushVC(vc)
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

- (void)loadWantCount {
    
    InterceptLoginShowAlert
    
    [MGBussiness loadWantCountWithParams:@{@"entity_id" : @(self.headerView.dataModel.id), @"entity_type_id" : @(MGGlobalEntityTypeMemeber)} completion:^(id results) {
       
        if ([results boolValue]) {
            self.headerView.dataModel.want_count += 1;
            [self.headerView setWantCount:self.headerView.dataModel.want_count];
            [self.footerView setWantButton:YES];
        }
        
    } error:nil];
    
}
#pragma mark - Getter and Setter
- (MGSelectCourseView *)selectCourseView {
    if (!_selectCourseView) {
        _selectCourseView = [[MGSelectCourseView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        WEAK
        _selectCourseView.sureBlock = ^(MGResCourseListDataModel *dataModel){
            STRONG
            [self.selectCourseView hideSelectCourseWithAnimated:YES inView:KeyWindow];
            MGTeacherOrderVC *vc = [MGTeacherOrderVC new];
            vc.dataModel = dataModel;
            PushVC(vc)
            
        };
    }
    return _selectCourseView;

}

- (void)dealloc {
    if (_selectCourseView) {
        [_selectCourseView removeFromSuperview];
    }
}


@end
