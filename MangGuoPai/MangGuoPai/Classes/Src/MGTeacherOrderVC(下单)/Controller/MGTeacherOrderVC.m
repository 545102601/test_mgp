//
//  MGTeacherOrderVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/26.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherOrderVC.h"
#import "MGTeacherOrderView.h"
#import "MGResOrderAddModel.h"
#import "MGPayOrderWayVC.h"


@interface MGTeacherOrderVC ()

@end

@implementation MGTeacherOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"下单";
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    WEAK
    MGTeacherOrderView *orderView = [[MGTeacherOrderView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    orderView.detailDataModel = self.detailDataModel;
    orderView.dataModel = self.dataModel;
    
    [self.view addSubview:orderView];
    
    
    orderView.orderBlock = ^(id model){
        STRONG
        long id = 0;
        if ([model isKindOfClass:[MGResCourseListDataModel class]]) {
            MGResCourseListDataModel *tempModel = (MGResCourseListDataModel *)model;
            id = tempModel.id;
        } else if ([model isKindOfClass:[MGResCourseListDetailDataModel class]]) {
            MGResCourseListDetailDataModel *tempModel = (MGResCourseListDetailDataModel *)model;
            id = tempModel.id;
        }
//        promotion_code 优惠码
        [MGBussiness loadOrderAddWithParams:@{@"id" : @(id), @"order_count" : @(1)} completion:^(MGResOrderAddDataModel *dataModel) {
            NSLog(@"%@",dataModel);
            
            MGPayOrderWayVC * vc = [MGPayOrderWayVC new];
            vc.dataModel = dataModel;
            PushVC(vc)
            
        } error:nil];
        
    };
    
    
}

#pragma mark - 加载数据
- (void)loadData {

}


@end
