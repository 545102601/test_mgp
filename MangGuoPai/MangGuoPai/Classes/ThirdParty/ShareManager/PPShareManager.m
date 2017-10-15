//
//  PPShareManager.m
//  TDQianxiaoer
//
//  Created by 林晖杰 on 16/3/28.
//  Copyright © 2016年 林晖杰. All rights reserved.
//

#import "PPShareManager.h"
#import "WXApi.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "AppDelegate.h"
#import <TencentOpenAPI/QQApiInterface.h>  

static PPShareManager *instance = nil;

@implementation PPShareManager

#pragma mark - Life Cycle

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function
+ (PPShareManager *)shareInstance {
    @synchronized(self) {
        if (nil == instance) {
            instance = [[PPShareManager alloc] init];
        }
    }
    return instance;
}

- (void)initShareConfig:(NSDictionary *)platformConfig {
    
    // 设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setUmSocialAppkey:[platformConfig objectForKey:UMENG_KEY]];
    
    // 设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:[platformConfig objectForKey:WECHAT_PLATFORM_ID]
                                       appSecret:[platformConfig objectForKey:WECHAT_PLATFORM_SECRET]
                                     redirectURL:nil];
    
    
    // 设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                          appKey:[platformConfig objectForKey:QQ_PLATFORM_ID]
                                       appSecret:nil
                                     redirectURL:nil];
    
    // 设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina
                                          appKey:[platformConfig objectForKey:SINA_PLATFORM_ID]
                                       appSecret:[platformConfig objectForKey:SINA_PLATFORM_SECRET]
                                     redirectURL:[platformConfig objectForKey:SINA_PLATFORM_REDIRECT]];
    
}

- (BOOL)handleOpenUrl:(NSURL *)url {
    return [[UMSocialManager defaultManager] handleOpenURL:url];
}

- (BOOL)handleOpenUrl:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    return [[UMSocialManager defaultManager] handleOpenURL:url options:options];
}

- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    
}

+ (BOOL)isQQInstalled {
    return [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ];
}

+ (BOOL)isWXAppInstalled {
    return [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession];
}

+ (BOOL)isWeiboInstalled {
    return [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina];
}

+ (BOOL)isInstalledPlatform:(UMSocialPlatformType)platformType {
    return [[UMSocialManager defaultManager] isInstall:platformType];
}

- (void)shareTitle:(NSString *)shareTitle
      shareContent:(NSString *)shareContent
        shareImage:(id)shareImage
          shareUrl:(NSString *)shareUrl
      platformType:(UMSocialPlatformType)platformType
      onCompletion:(ShareCompleteBlock)completionBlock
           onError:(ShareFailBlock)errorBlock {
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    if (!shareTitle) {
        shareTitle = @"";
    }
    
    if (!shareContent) {
        //设置文本
        shareContent = @"";
    }

    if (shareUrl) {
        if (platformType==UMSocialPlatformType_Sina) { 
            if (!shareImage) {
                return;
            }
        }
        
        //创建网页内容对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:shareTitle descr:shareContent thumImage:shareImage];
        
        //设置网页地址
        shareObject.webpageUrl =shareUrl;
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
    } else {
        messageObject.title = shareTitle;
        messageObject.text = shareContent;
        
        if (shareImage) {
            //创建图片内容对象
            UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
            [shareObject setShareImage:shareImage];
            
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
        }
    }
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            errorBlock(error);
            
        } else {
            completionBlock(data);
        }
    }];
    
}

- (void)loginWithPlatformType:(UMSocialPlatformType)platformType
        presentViewController:(UIViewController *)viewController
                 onCompletion:(LoginCompleteBlock)completionBlock
                      onError:(LoginFailBlock)errorBlock {
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:viewController completion:^(id result, NSError *error) {
        
        if (!error) {
            UMSocialUserInfoResponse *userinfo = result;
            completionBlock(userinfo);
            
        } else {
            errorBlock(error);
        }
    }];
}

- (void)resignOauthWithTypePlatformType:(UMSocialPlatformType)platformType
                           onCompletion:(ResignCompleteBlock)completeBlock {
    
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:platformType completion:^(id result, NSError *error) {
        if (!error) {
            completeBlock(YES);
            
        } else {
            completeBlock(NO);
        }
    }];
}

#pragma mark - Private Function

#pragma mark - Getter and Setter

@end
