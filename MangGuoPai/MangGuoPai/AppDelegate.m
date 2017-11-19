//
//  AppDelegate.m
//  MangGuoPai
//
//  Created by ZYN on 2017/6/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "AppDelegate.h"
#import "MGAppDriven.h"
#import "TDScrollToTop.h"
#import "JPUSHService.h"
#import "MGLoginVC.h"
#import "YNPay.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    /// 适配iOS11
    [MGAppDrivenManager adateriOS11];
    
    /// 负责配置程序驱动
    [MGAppDrivenManager driven:launchOptions];

    /// 初始化主窗体
    [MGAppDrivenManager initRootWindow];
    
    /// 切换环境
    [MGAppDrivenManager changeTestDev];
    
    /// 新版本
    [MGAppDrivenManager initNewVersionView];
    
    /// 开启定时器检测动态
    [MGAppDrivenManager startTimerForCheckTrendUpdate];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [JPUSHService handleRemoteNotification:userInfo];
    
}

// 接收到内存警告的时候调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 停止所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    // 删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [JPUSHService handleRemoteNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
    
}
#pragma MARK - handle url
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL result = [[PPShareManager shareInstance] handleOpenUrl:url];
    
    if (!result) { // 其他如支付等SDK的回调
        /// 支付
        [YNPay handleOpenURL:url];
        
    }
    
    return result;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL result = [[PPShareManager shareInstance] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    
    if (!result) {
        // 其他如支付等SDK的回调
        [YNPay handleOpenURL:url];
    }
    return result;
}


#pragma mark - 整个工程添加scroll Top Top
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [TDScrollToTop scrollViewScrollToTop:event];
}


#pragma mark - Publick Method


/// 去登录
- (void)gotoLogin {
    MGLoginVC *vc = [[MGLoginVC alloc] init];
    
    MGNavigationController *nav = [[MGNavigationController alloc] initWithRootViewController:vc];
    [ApplicationDelegate.mainTabbarVC presentViewController:nav animated:YES completion:nil];
}

/// 登录弹窗
- (BOOL)loginShowAlert {
    if (![SESSION_MANAGER isLogin]) { /// 未登录
//        DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:nil message:@"赶紧登录开始记账吧！" cancelButtonTitle:@"取消" otherButtonTitle:@"去登录"];
//        [alertView setAlertThemeMessageTip_TwoButton];
//        alertView.otherButtonAction = ^{
            MGLoginVC *vc = [[MGLoginVC alloc] init];
            
            MGNavigationController *nav = [[MGNavigationController alloc] initWithRootViewController:vc];
            [self.mainTabbarVC presentViewController:nav animated:YES completion:nil];
//        };
//        [alertView show];
        return NO;
    }
    return YES;
}

+ (instancetype)sharedInstance {
    
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}



@end
