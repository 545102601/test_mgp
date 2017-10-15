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


@interface MGTeacherClassDetailVC ()

@property (nonatomic, strong) MGTeacherClassDetailView *detailView;

@end

@implementation MGTeacherClassDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"课程详情";
    
    
}

#pragma mark - 初始化控件
- (void)setupSubViews {
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

#pragma mark - 加载数据
- (void)loadData {
    

    [MGBussiness loadClassDetailDataWithParam: self.id > 0 ? self.id : self.dataModel.id completion:^(MGResCourseListDetailDataModel *dataModel) {
        self.detailView.dataModel = dataModel;
        _detailView.hidden = NO;
        
        if (memberDataModelInstance.id == dataModel.member_id && dataModel.state == MGGlobaStateNone) {
            [self setRightButtonWithTitle:@"修改" target:self selector:@selector(rightButtonOnClick)];
        }
        
    } error:nil];

}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
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
        [self.detailView setWantButton:[results boolValue]];
    } error:nil];
    
}
#pragma mark - Getter and Setter


@end
