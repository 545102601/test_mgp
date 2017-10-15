//
//  BaseNetWorkTool.m
//  TDQianxiaoer
//
//  Created by zhenyong on 2017/3/13.
//  Copyright © 2017年 TDMarket. All rights reserved.
//

#define DBReqeusetUnLoginError @"-10004"
#import "BaseNetWorkTool.h"
#import "TDLoading.h"
#import "MGLoginVC.h"
#import "MGNavigationController.h"


@implementation BaseNetWorkTool : NSObject
#pragma mark - Public Function

+ (void)requestGetUrl:(NSString * _Nonnull)apiString
               params:(id _Nullable)param
      timeoutInterval:(int)timeoutInterval
            isNeedHUD:(BOOL)isNeedHUD
         successBlock:(nullable SuccessBlock)successBlock
           errorBlock:(nullable ErrorBlock)errorBlock {

    // 添加网络标示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    if (isNeedHUD) {
        [TDLoading showViewInKeyWindow];
    }

    
    // 初始化manager
    AFHTTPSessionManager *manager = [BaseNetWorkTool AFNNetworkSetting:YES
                                                            andOutTime:timeoutInterval];
    
    // 组装API地址
    NSString *requestUrl = [NSString stringWithFormat:@"%@?%@",ApiRequestUrl,apiString];
    
    // 请求日志打印
    NSMutableString *logUrl = requestUrl.mutableCopy;
    [param enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [logUrl appendFormat:@"&%@=%@",key,obj];
    }];
    
    TDDetialLog(@"请求地址 - %@\n ", logUrl);
    
    // 发送GET请求
    [manager GET:requestUrl parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 隐藏HUD
        if (isNeedHUD) {
            [TDLoading hideViewInKeyWindow];
        }
        
        // 隐藏网络标示
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSMutableDictionary *dic = responseObject;
        TDDetialLog(@"请求地址 - %@\n 服务器返回数据 - %@", logUrl, responseObject);
        /// 登录
        if ([dic[@"error_code"] isEqualToString:@"BIZ_ERR_INVALID_LOGIN_STATE"]) {
            
            [self goLogin];
        } else {
            if (![dic[@"ret_flag"] boolValue]) { /// 服务器 请求 失败
                [TDLoading hideViewInKeyWindow];
            }
            
            // 成功参数返回
            successBlock(dic,
                         dic[@"ret_msg"],
                         dic[@"error_code"],
                         [dic[@"ret_flag"] boolValue]);
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [TDLoading hideViewInKeyWindow];
        // 隐藏网络标示
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        TDDetialLog(@"请求错误 - %@", error);
        [MBProgressHUD showError:@"当前网络阻塞，请稍后再试" toView:KeyWindow];
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}


+ (void)requestPostUrl:(NSString * _Nonnull)apiString
                params:(id _Nullable)param
       timeoutInterval:(int)timeoutInterval
             isNeedHUD:(BOOL)isNeedHUD
          successBlock:(nullable SuccessBlock)successBlock
            errorBlock:(nullable ErrorBlock)errorBlock {
    
    // 添加网络标示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    if (isNeedHUD) {
        [TDLoading showViewInKeyWindow];
    }
    // 初始化manager
    AFHTTPSessionManager *manager = [BaseNetWorkTool AFNNetworkSetting:YES
                                                            andOutTime:timeoutInterval];
    
    // 组装API地址
    NSString *requestUrl = [NSString stringWithFormat:@"%@?%@",ApiRequestUrl,apiString];
    
    NSMutableString *logUrl = requestUrl.mutableCopy;
    [param enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [logUrl appendFormat:@"&%@=%@",key,obj];
    }];
    
    // 请求日志打印
    TDDetialLog(@"请求地址 - %@\n ", logUrl);
    
    // 发送Post请求
    [manager POST:requestUrl parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 隐藏HUD
        if (isNeedHUD) {
            [TDLoading hideViewInKeyWindow];
        }
        
        // 隐藏网络标示
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSMutableDictionary *dic = responseObject;
        TDDetialLog(@"请求地址 - %@\n 服务器返回数据 - %@", logUrl, responseObject);
      
        /// 登录
        if ([dic[@"error_code"] isEqualToString:@"BIZ_ERR_INVALID_LOGIN_STATE"]) {
            [self goLogin];
        } else {
            if (![dic[@"ret_flag"] boolValue]) { /// 服务器 请求 失败
                [TDLoading hideViewInKeyWindow];
            }
            // 成功参数返回
            successBlock(dic,
                         dic[@"ret_msg"],
                         dic[@"error_code"],
                         [dic[@"ret_flag"] boolValue]);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [TDLoading hideViewInKeyWindow];
        
        
        // 隐藏网络标示
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        TDDetialLog(@"请求错误 - %@", error);
        
        [MBProgressHUD showError:@"当前网络阻塞，请稍后再试" toView:KeyWindow];
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

#pragma mark - Private Function
+ (AFHTTPSessionManager *)AFNNetworkSetting:(BOOL)isJson andOutTime:(int)outTime {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    if (outTime < 10) {
        outTime = 10;
    }
//    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = outTime;
    
    // 设置Session ID
//    [manager.requestSerializer setHTTPShouldHandleCookies:NO];
    
    // 没有相关证书，先屏蔽
    //    if (EnableHTTPS) {
    //        [manager setSecurityPolicy:[BaseNetWorkTool customSecurityPolicy]];
    //    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                         @"application/json",
                                                         @"text/html",
                                                         @"text/json",
                                                         @"text/javascript",
                                                         @"text/plain",
                                                         nil];
    
//    [manager.requestSerializer setValue:@"application/json"
//                     forHTTPHeaderField:@"Accept"];
//    
//    [manager.requestSerializer setValue:@"text/plain;charset-utf-8"
//                     forHTTPHeaderField:@"Content-type"];
    
//    if (isJson) {
//        [manager.requestSerializer setValue:@"application/json"
//                         forHTTPHeaderField:@"Accept"];
//    }
    
//    NSString *session_id = [SESSION_MANAGER getSessionId];
//    
//    if (session_id.length <= 0) {
//        session_id = [NSString stringWithFormat:@"%@%@",[TDCommonTool randomString:32], [TDCommonTool getTimeStamp]];
//        [SESSION_MANAGER setSessionId:session_id];
//    }
//    
//    TDDetialLog(@"%@", [NSString stringWithFormat:@"session_id=%@",session_id]);
//    
//    [manager.requestSerializer setValue:[NSString stringWithFormat:@"session_id=%@",session_id] forHTTPHeaderField:@"Cookie"];
    
    return manager;
}

+ (AFSecurityPolicy*)customSecurityPolicy {
    // 先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"zheng" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:certData,  nil];;
    
    return securityPolicy;
}

/// 单独的请求接口 完整地址
+ (void)requestGetUrlForFinishURL:(NSString * _Nonnull)apiString
                           params:(id _Nullable)param
                  timeoutInterval:(int)timeoutInterval
                        isNeedHUD:(BOOL)isNeedHUD
                     successBlock:(nullable SuccessBlock)successBlock
                       errorBlock:(nullable ErrorBlock)errorBlock {
    
    // 添加网络标示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
 
    if (isNeedHUD) {
        [TDLoading showViewInKeyWindow];
    }
    
    
    // 初始化manager
    AFHTTPSessionManager *manager = [BaseNetWorkTool AFNNetworkSetting:YES
                                                            andOutTime:timeoutInterval];
    
    // 组装API地址
//    NSString *requestUrl = [NSString stringWithFormat:@"%@?%@",ApiRequestUrl,apiString];
    NSString *requestUrl = apiString;
    // 请求日志打印
    TDDetialLog(@"请求地址 - %@\n 请求参数 - %@", requestUrl, param);
    
    // 发送GET请求
    [manager GET:requestUrl parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 隐藏HUD
        if (isNeedHUD) {
            [TDLoading hideViewInKeyWindow];
        }
        
        // 隐藏网络标示
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSMutableDictionary *dic = responseObject;
        TDDetialLog(@"请求地址 - %@\n 服务器返回数据 - %@", requestUrl, responseObject);
        
        /// 登录
        if ([dic[@"error_code"] isEqualToString:@"BIZ_ERR_INVALID_LOGIN_STATE"]) {
            [self goLogin];
        } else {
            if (![dic[@"ret_flag"] boolValue]) { /// 服务器 请求 失败
                [TDLoading hideViewInKeyWindow];
            }
            // 成功参数返回
            successBlock(dic,
                         dic[@"ret_msg"],
                         dic[@"error_code"],
                         [dic[@"ret_flag"] boolValue]);
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [TDLoading hideViewInKeyWindow];
        // 隐藏网络标示
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        TDDetialLog(@"请求错误 - %@", error);
        [MBProgressHUD showError:@"当前网络阻塞，请稍后再试" toView:KeyWindow];
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}


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
               errorBlock:(nullable ErrorBlock)errorBlock {

    
    // 添加网络标示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    if (isNeedHUD) {
        [TDLoading showViewInKeyWindow];
    }
    // 初始化manager
    AFHTTPSessionManager *manager = [BaseNetWorkTool AFNNetworkSetting:YES
                                                            andOutTime:timeoutInterval];
    
    // 组装API地址
    NSString *requestUrl = [NSString stringWithFormat:@"%@?%@",ApiRequestUrl,apiString];
    
    // 请求日志打印
    TDDetialLog(@"请求上传地址 - %@\n 请求参数 - %@ name %@ - fileName %@ - mineType %@ - data %@", requestUrl, param, name, fileName, mineType, data);
    
    [manager POST:requestUrl parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mineType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 隐藏HUD
        if (isNeedHUD) {
            [TDLoading hideViewInKeyWindow];
        }
        
        // 隐藏网络标示
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSMutableDictionary *dic = responseObject;
        TDDetialLog(@"请求地址 - %@\n 服务器返回数据 - %@", requestUrl, responseObject);
        
        /// 登录
        if ([dic[@"error_code"] isEqualToString:@"BIZ_ERR_INVALID_LOGIN_STATE"]) {
            [self goLogin];
        } else {
            if (![dic[@"ret_flag"] boolValue]) { /// 服务器 请求 失败
                [TDLoading hideViewInKeyWindow];
            }
            // 成功参数返回
            successBlock(dic,
                         dic[@"ret_msg"],
                         dic[@"error_code"],
                         [dic[@"ret_flag"] boolValue]);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [TDLoading hideViewInKeyWindow];
        
        
        // 隐藏网络标示
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        TDDetialLog(@"请求错误 - %@", error);
        
        [MBProgressHUD showError:@"当前网络阻塞，请稍后再试" toView:KeyWindow];
        if (errorBlock) {
            errorBlock(error);
        }
    }];
    
}
/// 去登陆
+ (void)goLogin {
    
    /// 防止没有回调到外面，这里一致隐藏loading
    [TDLoading hideViewInKeyWindow];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:OutSuccessRefreshTable object:nil];
    });
    
    // 跳转到登陆页面
    MGLoginVC *vc               = [[MGLoginVC alloc] init];
    MGNavigationController *nav = [[MGNavigationController alloc] initWithRootViewController:vc];
    
    [ApplicationDelegate.mainTabbarVC presentViewController:nav animated:YES completion:nil];
    
}

@end


