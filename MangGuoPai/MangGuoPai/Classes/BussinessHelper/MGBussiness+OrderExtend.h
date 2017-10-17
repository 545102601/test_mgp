//
//  MGBussiness+OrderExtend.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/31.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussiness.h"

@interface MGBussiness (OrderExtend)

/// 下单接口
+ (void)loadOrderAddWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 支付接口
+ (void)loadOrderPayWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 价格计算
+ (void)loadOrderCalc_PriceWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 订单列表接口 - 分页
+ (void)loadOrderListWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 订单详情接口
+ (void)loadOrderDetailWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 取消订单
+ (void)loadOrderCancelWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 课程安排日历接口
+ (void)loadSchedule_Calendar:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 安排课程接口
+ (void)loadOrder_Schedule:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 取消安排课程接口
+ (void)loadOrder_Schedule_Cancel:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 批量取消安排课程接口
+ (void)loadBatch_Schedule_Cancel:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

@end
