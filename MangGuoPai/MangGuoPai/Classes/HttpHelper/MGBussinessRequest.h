//
//  MGBussinessRequest.h
//  MangGuoPai
//
//  Created by ZYN on 2017/6/28.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseNetWorkTool.h"

@interface MGBussinessRequest : BaseNetWorkTool

#pragma mark  - 用户相关

/// 文件上传
+ (void)postUpload:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
/// 快速登陆
+ (void)postUserQuickLogin:(id)businessModal successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
/// 微信登录
+ (void)postWXLogin:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
/// 微信请求 获取 unionId
+ (void)postWXUnionID:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
/// 会员信息
+ (void)postMember_Get:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
/// 更新会员基本信息接口
+ (void)postUpdate_Member:(NSDictionary *)dict isNeedHUD:(BOOL)isNeedHUD successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock ;
/// 设置会员信息接口
+ (void)postMember_Setting:(id _Nullable)businessModal successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
/// 退出登录
+ (void)postLoginOut:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;


@end
