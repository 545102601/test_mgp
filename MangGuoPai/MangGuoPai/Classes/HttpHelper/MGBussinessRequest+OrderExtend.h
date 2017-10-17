//
//  MGBussinessRequest+OrderExtend.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/31.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussinessRequest.h"

@interface MGBussinessRequest (OrderExtend)

/// 下单接口
+ (void)postOrder_Add:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 支付接口
+ (void)postOrder_Pay:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 价格计算
+ (void)postOrderCalc_Price:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 订单列表接口
+ (void)getOrder_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 订单详情接口
+ (void)getOrder_Get:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 取消订单
+ (void)postOrder_Cancel:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 课程安排日历接口
+ (void)getSchedule_Calendar:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 安排课程接口
+ (void)postOrder_Schedule:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 取消安排课程接口
+ (void)postOrder_Schedule_Cancel:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 批量取消安排课程接口
+ (void)postBatch_Schedule_Cancel:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

@end
