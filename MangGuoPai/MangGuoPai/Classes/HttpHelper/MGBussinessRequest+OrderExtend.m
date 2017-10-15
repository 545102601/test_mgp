//
//  MGBussinessRequest+OrderExtend.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/31.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussinessRequest+OrderExtend.h"

@implementation MGBussinessRequest (OrderExtend)

/// 下单接口
+ (void)postOrder_Add:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_ORDER_ADD
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 支付接口
+ (void)postOrder_Pay:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_ORDER_PAY
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}


/// 订单列表接口
+ (void)getOrder_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestGetUrl:HTTP_ORDER_LIST
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:NO
            successBlock:successBlock
              errorBlock:errorBlock];
}
/// 订单详情接口
+ (void)getOrder_Get:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestGetUrl:HTTP_ORDER_GET
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:YES
           successBlock:successBlock
             errorBlock:errorBlock];
}


/// 取消订单
+ (void)postOrder_Cancel:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_ORDER_CANCEL
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:YES
           successBlock:successBlock
             errorBlock:errorBlock];
}


/// 课程安排日历接口
+ (void)getSchedule_Calendar:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestGetUrl:HTTP_SCHEDULE_CALENDAR
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:YES
           successBlock:successBlock
             errorBlock:errorBlock];
}

/// 安排课程接口
+ (void)postOrder_Schedule:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_ORDER_SCHEDULE
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 取消安排课程接口
+ (void)postOrder_Schedule_Cancel:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_ORDER_SCHEDULE_CANCEL
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 批量取消安排课程接口
+ (void)postBatch_Schedule_Cancel:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_BATCH_SCHEDULE_CANCEL
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

@end
