//
//  MGBussinessRequest+HomeExtend.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussinessRequest.h"

@interface MGBussinessRequest (HomeExtend)

/// 项目配置信息
+ (void)getSetting_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
/// 公告列表
+ (void)getBulletin_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
/// 公告详情接口
+ (void)getBulletin_Get:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
/// 消息列表
+ (void)getMessage_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
/// 消息监测
+ (void)getMessage_Check:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
/// 消息删除
+ (void)postMessage_Delete:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
/// 消息阅读
+ (void)postMessage_Read:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
/// 全文搜索
+ (void)getFull_Search:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
/// 内容详情接口
+ (void)getContent_Get:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

@end
