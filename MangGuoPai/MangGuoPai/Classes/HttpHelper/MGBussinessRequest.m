//
//  MGBussinessRequest.m
//  MangGuoPai
//
//  Created by ZYN on 2017/6/28.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussinessRequest.h"

@implementation MGBussinessRequest

#pragma mark  - 用户相关

/// 文件上传
+ (void)postUpload:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUpload:HTTP_UPLOAD
                     params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict[@"params"]]
                       data:dict[@"data"]
                       name:dict[@"name"]
                   fileName:dict[@"fileName"]
                   mineType:dict[@"mineType"]
            timeoutInterval:RequestTiemOut
                  isNeedHUD:NO
               successBlock:successBlock
                 errorBlock:errorBlock];
    
}
/// 快速登陆
+ (void)postUserQuickLogin:(id _Nullable)businessModal successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_QUICK_LOGIN
                  params:[[TDBaseData sharedInstance] returnParamsWithModal:businessModal]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 微信登录
+ (void)postWXLogin:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_WX_LOGIN
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:NO
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 微信请求 获取 unionId
+ (void)postWXUnionID:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestGetUrlForFinishURL:HTTP_WX_UNIONID
                             params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
                    timeoutInterval:RequestTiemOut
                          isNeedHUD:NO
                       successBlock:successBlock
                         errorBlock:errorBlock];
}


/// 会员详情
+ (void)postMember_Get:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_MEMBER_GET
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:NO
            successBlock:successBlock
              errorBlock:errorBlock];
}
/// 更新会员基本信息接口
+ (void)postUpdate_Member:(NSDictionary *)dict isNeedHUD:(BOOL)isNeedHUD successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_MEMBER_SETTING
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:isNeedHUD
            successBlock:successBlock
              errorBlock:errorBlock];
}
/// 设置会员信息接口
+ (void)postMember_Setting:(id _Nullable)businessModal successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_MEMBER_SETTING
                  params:[[TDBaseData sharedInstance] returnParamsWithModal:businessModal]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}
/// 退出登录
+ (void)postLoginOut:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_LOGOUT
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}


@end
