//
//  MGTeacherClassDetailVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/26.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherClassDetailVC.h"
#import "MGTeacherClassDetailView.h"
#import "MGResCourseListDetailModel.h"
#import "MGTeacherOrderVC.h"
#import "MGAddLessonVC.h"
#import "TDUMShareAlertView.h"

@interface MGTeacherClassDetailVC ()

@property (nonatomic, strong) MGTeacherClassDetailView *detailView;

@property (nonatomic, strong) UIButton *favButton;

@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation MGTeacherClassDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"课程详情";
    
    
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    
    [self setupNavButton];
    
    WEAK
    _detailView = [[MGTeacherClassDetailView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    _detailView.hidden = YES;
    [self.view addSubview:_detailView];

    _detailView.wantEventBlock = ^{
        STRONG
        [self loadWantCount];
    };
    
    _detailView.orderEventBlock = ^{
        STRONG
        MGTeacherOrderVC *vc = [MGTeacherOrderVC new];
        vc.detailDataModel = self.detailView.dataModel;
        PushVC(vc)
    };

    
}
/// 创建导航条按钮
- (void)setupNavButton {
    
    _shareButton = [TDExpendClickButtonNotHightLight buttonWithType:UIButtonTypeCustom];
    [_shareButton setImage:[UIImage imageNamed:@"found_icon_share"] forState:UIControlStateNormal];
    _shareButton.frame = CGRectMake(kScreenWidth - SW(44) - SW(20), 0, SW(44), SW(44));
    _shareButton.centerY = self.navigationBar.titleLabel.centerY;
    [_shareButton addTarget:self action:@selector(shareButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _favButton = [TDExpendClickButtonNotHightLight buttonWithType:UIButtonTypeCustom];
    [_favButton setImage:[UIImage imageNamed:@"found_icon_shoucang_nor"] forState:UIControlStateNormal];
    [_favButton setImage:[UIImage imageNamed:@"found_icon_shoucang_pressed"] forState:UIControlStateSelected];
    _favButton.frame = CGRectMake(_shareButton.left - SW(44) - SW(30), 0, SW(44), SW(44));
    _favButton.centerY = self.navigationBar.titleLabel.centerY;
    [_favButton addTarget:self action:@selector(favButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _favButton.hidden = YES;
    _shareButton.hidden = YES;
    
    [self.navigationBar sd_addSubviews:@[_shareButton, _favButton]];
    
}
#pragma mark - 加载数据
- (void)loadData {
    

    [MGBussiness loadClassDetailDataWithParam: self.id > 0 ? self.id : self.dataModel.id completion:^(MGResCourseListDetailDataModel *dataModel) {
        self.detailView.dataModel = dataModel;
        _detailView.hidden = NO;
        
        _favButton.selected = dataModel.is_favor > 0 ? YES : NO;
        
        if (memberDataModelInstance.id == dataModel.member_id && dataModel.state == MGGlobaStateNone) {
            self.rightButton = [self setRightButtonWithTitle:@"修改" target:self selector:@selector(rightButtonOnClick)];
            self.rightButton.hidden = NO;
            self.favButton.hidden = YES;
            self.shareButton.hidden = YES;
        } else {
            self.rightButton.hidden = YES;
            self.favButton.hidden = NO;
            self.shareButton.hidden = NO;
        }
        
    } error:nil];

}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

- (void)shareButtonOnClick {
    
    TDUMShareAlertView *alertView = [TDUMShareAlertView showUMengShareViewWithTitle:self.detailView.dataModel.course_title shareContent:self.detailView.dataModel.course_content shareImage:[UIImage imageNamed:@"mine_manguo_fx"] imageUrl:nil shareUrl:[NSString stringWithFormat:@"https://www.mangopi.com.cn/wx/course/%ld.html", self.detailView.dataModel.id]];
    
    [alertView show];
    
}
- (void)favButtonOnClick {
    NSDictionary *dict = @{@"entity_id" : @(self.detailView.dataModel.id), @"entity_type_id" : @(MGGlobalEntityTypeClass)};
    if (_favButton.selected) {
        [MGBussiness loadFav_Del:dict completion:^(id results) {
            _favButton.selected = NO;
        } error:nil];
    } else {
        
        [MGBussiness loadFav_Add:dict completion:^(id results) {
            _favButton.selected = YES;
        } error:nil];
    }
    
    
}
/// 右边按钮
- (void)rightButtonOnClick {
    MGAddLessonVC *vc = [MGAddLessonVC new];
    vc.lessonType = MGAddLessonTypeUpdate;
    vc.dataModel = self.detailView.dataModel;
    PushVC(vc)
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function
- (void)loadWantCount {
    
    InterceptLoginShowAlert
    
    [MGBussiness loadWantCountWithParams:@{@"entity_id" : @(self.detailView.dataModel.id), @"entity_type_id" : @(MGGlobalEntityTypeClass)} completion:^(id results) {
        
    } error:nil];
    
}
#pragma mark - Getter and Setter


@end
