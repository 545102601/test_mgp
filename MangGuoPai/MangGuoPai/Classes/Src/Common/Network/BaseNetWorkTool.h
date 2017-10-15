//
//  BaseNetWorkTool.h
//  TDQianxiaoer
//
//  Created by zhenyong on 2017/3/13.
//  Copyright © 2017年 TDMarket. All rights reserved.
//

#import "BaseModel.h"
#import "AFNetworking.h"
#import "TDBaseData.h"
#import "MGHttpConstant.h"

/** 请求成功的block */
typedef void (^SuccessBlock)(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess);

/** 请求返回失败的block */
typedef void (^ErrorBlock)(NSError * error);

@interface BaseNetWorkTool : NSObject

/**
 Get请求
 */
+ (void)requestGetUrl:(NSString * _Nonnull)apiString
                params:(id _Nullable)param
       timeoutInterval:(int)timeoutInterval
             isNeedHUD:(BOOL)isNeedHUD
          successBlock:(nullable SuccessBlock)successBlock
            errorBlock:(nullable ErrorBlock)errorBlock;

/// GET : 单独的请求接口 完整地址
+ (void)requestGetUrlForFinishURL:(NSString * _Nonnull)apiString
                           params:(id _Nullable)param
                  timeoutInterval:(int)timeoutInterval
                        isNeedHUD:(BOOL)isNeedHUD
                     successBlock:(nullable SuccessBlock)successBlock
                       errorBlock:(nullable ErrorBlock)errorBlock;



/**
 * Post请求
 */
+ (void)requestPostUrl:(NSString * _Nonnull)apiString
                params:(id _Nullable)param
       timeoutInterval:(int)timeoutInterval
             isNeedHUD:(BOOL)isNeedHUD
          successBlock:(nullable SuccessBlock)successBlock
            errorBlock:(nullable ErrorBlock)errorBlock;

/**
 * Post请求 上传文件
 */
+ (void)requestPostUpload:(NSString * _Nonnull)apiString
                   params:(id _Nullable)param
                     data:(NSData *)data
                     name:(NSString *)name
                 fileName:(NSString *)fileName
                 mineType:(NSString *)mineType
          timeoutInterval:(int)timeoutInterval
                isNeedHUD:(BOOL)isNeedHUD
             successBlock:(nullable SuccessBlock)successBlock
               errorBlock:(nullable ErrorBlock)errorBlock;




@end
