//
//  MGTeacherOrderVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/26.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherOrderVC.h"
#import "MGTeacherOrderView.h"
#import "MGPayOrderWayVC.h"
#import "MGResCalcPriceModel.h"

@interface MGTeacherOrderVC ()

@property (nonatomic, strong) MGTeacherOrderView *orderView;

@end

@implementation MGTeacherOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"下单";
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    WEAK
    _orderView = [[MGTeacherOrderView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    _orderView.detailDataModel = self.detailDataModel;
    _orderView.dataModel = self.dataModel;
    
    [self.view addSubview:_orderView];
    
    /// 使用优惠码
    _orderView.discountBlock = ^(NSString *discount){
      STRONG
        [self loadCalcPriceForDiscountAndCoupon];
    };
    /// 使用优惠券
    _orderView.couponDataSelectedBlock = ^{
      STRONG
        [self loadCalcPriceForDiscountAndCoupon];
        
    };
    
    
    /// 下单
    _orderView.orderBlock = ^(id model){
        STRONG
        
        [self.view endEditing:YES];
        
        InterceptLoginShowAlert
        
        long id = 0;
        if ([model isKindOfClass:[MGResCourseListDataModel class]]) {
            MGResCourseListDataModel *tempModel = (MGResCourseListDataModel *)model;
            id = tempModel.id;
        } else if ([model isKindOfClass:[MGResCourseListDetailDataModel class]]) {
            MGResCourseListDetailDataModel *tempModel = (MGResCourseListDetailDataModel *)model;
            id = tempModel.id;
        }
        
//        promotion_code 优惠码
        NSMutableDictionary *params = @{@"id" : @(id), @"order_count" : @(1)}.mutableCopy;
        long couponId = [self getCouponId];
        if (couponId > 0) {
            [params setObject:@(couponId) forKey:@"member_coupon_id"];
        }
        if (self.orderView.discountText.length > 0) {
            [params setObject:self.orderView.discountText forKey:@"promotion_code"];
        }
        
        [MGBussiness loadOrderAddWithParams:params completion:^(MGResOrderListDataModel *dataModel) {
            
            MGPayOrderWayVC * vc = [MGPayOrderWayVC new];
            vc.listDataModel = dataModel;
            PushVC(vc)
            
        } error:nil];
    };
}

#pragma mark - 加载数据
- (void)loadData {

    /// 获取优惠券列表 + 加载价格
    [self loadCouponPromotion];
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

- (void)loadCouponPromotion {
    
    _orderView.hidden = YES;
    
    long id = self.dataModel.id > 0 ? self.dataModel.id : self.detailDataModel.id;
    [MGBussiness loadCoupon_Promotion:@{@"course_id" : @(id)} completion:^(NSArray *results) {
        _orderView.couponArray = results;
        
        /// 直接加载订单详情
        long couponId = [self getCouponId];
        if (couponId > 0) {
            [self loadCalcPrice:@{@"member_coupon_id" : @(couponId)}];
        } else {
            [self loadCalcPrice:nil];
        }
        
        
    } error:nil];
    
}

- (void)loadCalcPriceForDiscountAndCoupon {
    
    long couponId = [self getCouponId];
    NSMutableDictionary *params = @{}.mutableCopy;
    if (couponId > 0) {
        [params setObject:@(couponId) forKey:@"member_coupon_id"];
    }
    
    if (self.orderView.discountText.length > 0) {
        [params setObject:self.orderView.discountText forKey:@"promotion_code"];
    }
    
    [self loadCalcPrice:params];
    
}


- (void)loadCalcPrice:(NSDictionary *)param {
    
    long id = self.dataModel.id > 0 ? self.dataModel.id : self.detailDataModel.id;
    /// promotion_code  /// member_coupon_id
    NSMutableDictionary *params = @{@"id" : @(id), @"order_count" : @(1)}.mutableCopy;
    if (param.count > 0) {
        [params setValuesForKeysWithDictionary:param];
    }
    
    [MGBussiness loadOrderCalc_PriceWithParams:params completion:^(MGResCalcPriceDataModel *priceDataModel) {
        
        _orderView.hidden = NO;
     
        _orderView.priceDataModel = priceDataModel;
        
        
    } error:nil];
    
}

#pragma mark - Getter and Setter

/// 获取当前的优惠券Id
- (long)getCouponId {
    long couponId = 0;
    for (TDSelectListDataViewContentModel *contentModel in _orderView.couponDataView.dataArray) {
        if (contentModel.isSelected && contentModel.id > 0) {
            couponId = contentModel.id;
            break;
        }
    }
    return couponId;
}



@end
