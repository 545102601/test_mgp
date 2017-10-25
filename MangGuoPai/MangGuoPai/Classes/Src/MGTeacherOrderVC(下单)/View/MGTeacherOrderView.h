//
//  MGTeacherOrderView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/26.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"
#import "MGResCourseListModel.h"
#import "MGResCourseListDetailModel.h"
#import "TDSelectListDataView.h"
#import "MGResCalcPriceModel.h"

@interface MGTeacherOrderView : BaseView

@property (nonatomic, strong) MGResCourseListDataModel *dataModel;

@property (nonatomic, strong) MGResCourseListDetailDataModel *detailDataModel;

@property (nonatomic, strong) MGResCalcPriceDataModel *priceDataModel;

/// textfield - 优惠码
@property (nonatomic, copy) NSString *discountText;
/// 优惠码回调
@property (nonatomic, copy) MGCommomEventBlock discountBlock;
/// 下单回调
@property (nonatomic, copy) MGCommomEventBlock orderBlock;


/// 优惠券列表
@property (nonatomic, strong) TDSelectListDataView *couponDataView;
/// 优惠券回调
@property (nonatomic, copy) MGCommomEventBlock couponDataSelectedBlock;

/// 优惠券数据
@property (nonatomic, copy) NSArray *couponArray;

@end
