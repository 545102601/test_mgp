//
//  MGBussinessRequest+FoundExtend.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/12.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussinessRequest.h"

@interface MGBussinessRequest (FoundExtend)

/// 动态列表
+ (void)getTrend_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 添加动态
+ (void)postTrend_Add:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 检测动态
+ (void)getTrend_Update:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 点赞
+ (void)postPraise_Count:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 想看
+ (void)postWant_Count:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 转发
+ (void)postFaword_Count:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 动态详情
+ (void)getTrend_Get:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 回复动态评论
+ (void)postTrend_Reply:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

@end
