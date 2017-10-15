//
//  MGBussiness+FoundExtend.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussiness.h"

@interface MGBussiness (FoundExtend)

/// 动态列表 - 分页
+ (void)loadTrendListWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 添加动态
+ (void)loadTrend_AddWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 检测动态
+ (void)loadTrend_UpdateWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 点赞 接口
+ (void)loadPraiseWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 想听 接口
+ (void)loadWantCountWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 动态详情
+ (void)loadTrend_GetWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 回复动态评论
+ (void)loadTrend_ReplyWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

@end
