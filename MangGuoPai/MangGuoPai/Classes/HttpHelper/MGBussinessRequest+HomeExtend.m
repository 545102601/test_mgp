//
//  MGBussinessRequest+HomeExtend.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussinessRequest+HomeExtend.h"

@implementation MGBussinessRequest (HomeExtend)

#pragma mark - 项目配置信息
+ (void)getSetting_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestGetUrl:HTTP_SETTING_LIST
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:NO
           successBlock:successBlock
             errorBlock:errorBlock];
}
#pragma mark 公告列表
+ (void)getBulletin_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestGetUrl:HTTP_BULLETIN_LIST
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:NO
           successBlock:successBlock
             errorBlock:errorBlock];
}
#pragma mark 公告详情接口
+ (void)getBulletin_Get:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestGetUrl:HTTP_BULLETIN_GET
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:NO
           successBlock:successBlock
             errorBlock:errorBlock];
}
#pragma mark - 会员消息
/// 消息列表
+ (void)getMessage_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestGetUrl:HTTP_MES_LIST
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:NO
           successBlock:successBlock
             errorBlock:errorBlock];
}
/// 消息监测
+ (void)getMessage_Check:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestGetUrl:HTTP_MES_CHECK
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:NO
           successBlock:successBlock
             errorBlock:errorBlock];
}
/// 消息删除
+ (void)postMessage_Delete:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_MES_DEL
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:YES
           successBlock:successBlock
             errorBlock:errorBlock];
}
/// 消息阅读
+ (void)postMessage_Read:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_MES_READ
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:NO
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 消息详情
+ (void)getMessage_Get:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestGetUrl:HTTP_MES_GET
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:YES
           successBlock:successBlock
             errorBlock:errorBlock];
}
/// 全文搜索
+ (void)getFull_Search:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_FULL_SEARCH
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:NO
            successBlock:successBlock
              errorBlock:errorBlock];
}


/// 内容详情接口
+ (void)getContent_Get:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {

    [self requestPostUrl:HTTP_CONTENT_GET
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

@end
