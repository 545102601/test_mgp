//
//  MGBussinessRequest+FoundExtend.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/12.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussinessRequest+FoundExtend.h"

@implementation MGBussinessRequest (FoundExtend)

#pragma mark - 互动


/// 动态列表
+ (void)getTrend_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestGetUrl:HTTP_TREND_LIST
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:NO
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 添加动态
+ (void)postTrend_Add:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    NSString *urls = dict[@"urls"];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTP_TREND_ADD,urls.length > 0 ? urls : @""];
    NSMutableDictionary *mutableDict = dict.mutableCopy;
    [mutableDict removeObjectForKey:@"urls"];
    [self requestPostUrl:url
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:mutableDict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
    
}

/// 检测动态
+ (void)getTrend_Update:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestGetUrl:HTTP_TREND_UPDATE
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:NO
            successBlock:successBlock
              errorBlock:errorBlock];
    
}

/// 点赞
+ (void)postPraise_Count:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_PRAISE_COUNT
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}
/// 想看
+ (void)postWant_Count:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_WANT_COUNT
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 转发
+ (void)postFaword_Count:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_FAWORD_COUNT
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 动态详情
+ (void)getTrend_Get:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestGetUrl:HTTP_TREND_GET
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:YES
           successBlock:successBlock
             errorBlock:errorBlock];
    
}

/// 回复动态评论
+ (void)postTrend_Reply:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_TREND_REPLY
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

@end
