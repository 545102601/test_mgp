//
//  MGAppDriven.m
//  MangGuoPai
//
//  Created by ZYN on 2017/6/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGAppDriven.h"

#import <IQKeyboardManager.h>
#import "TDScrollToTop.h"
#import "TDUmengStatisticsManger.h"
#import "UMMobClick/MobClick.h"
#import <UMSocialCore/UMSocialCore.h>
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
#import "TDConfigManager.h"
#import <BaiduMobStat.h>

#import "MGSplashView.h"
#import <MJRefresh.h>
#import "UITabBar+Extend.h"

@interface MGAppDriven () <JPUSHRegisterDelegate>

@end

@implementation MGAppDriven

+ (void)initialize {
    
    //设置UserAgent
    UIWebView *webView2 = [[UIWebView alloc]initWithFrame:CGRectZero];
    
    NSString *oldAgent = [webView2 stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent" : oldAgent}];
}

/// 适配iOS11
- (void)adateriOS11 {

    if (SystemVersion >= 11.0) {
            
    }
    
}

- (void)driven:(NSDictionary *)launchOptions {
    
    TDLog(@"docutment -> open %@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject);
    
    [self configThirdParty:launchOptions];
    
}


/// 配置第三方
- (void)configThirdParty:(NSDictionary *)launchOptions {
    
    //     初始化友盟
    [self setupUmeng];
    
    // 初始化极光
    [self setupJPush:launchOptions];

    // 初始化百度统计
    [self startBaiduMobileStat];
    
    
    /// 开启背景点击收回
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    // 隐藏textField的Placeholder
    [IQKeyboardManager sharedManager].shouldShowTextFieldPlaceholder = NO;
    /// 控制是否显示键盘上的工具条
    ///    [IQKeyboardManager sharedManager].enableAutoToolbar              = NO;
    /// 开启数据越界崩溃打印·
    //    [XTSafeCollection setLogEnabled:YES];
    
    
}
- (void)setupUmeng {
    UMConfigInstance.appKey    = [CONFIG_MANAGER umeng_key];
    UMConfigInstance.channelId = [CONFIG_MANAGER umeng_channelId];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    // 配置第三方登陆
    [[PPShareManager shareInstance] initShareConfig:@{UMENG_KEY : [CONFIG_MANAGER umeng_key],
                                                      QQ_PLATFORM_ID : [CONFIG_MANAGER umeng_qq_id],
                                                      WECHAT_PLATFORM_ID : [CONFIG_MANAGER umeng_wechat_key],
                                                      WECHAT_PLATFORM_SECRET : [CONFIG_MANAGER umeng_wechat_secret],
                                                      SINA_PLATFORM_ID : [CONFIG_MANAGER umeng_weibo_key],
                                                      SINA_PLATFORM_SECRET : [CONFIG_MANAGER umeng_weibo_secret],
                                                      SINA_PLATFORM_REDIRECT : [CONFIG_MANAGER umeng_weibo_redirect]
                                                      }];
    
    // 初始化SDK
    [MobClick startWithConfigure:UMConfigInstance];
}
// 启动百度移动统计
- (void)startBaiduMobileStat{
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    [statTracker startWithAppId:[CONFIG_MANAGER baiduMob_Key]]; // 设置您在mtj网站上添加的app的appkey,此处AppId即为应用的appKey
}
- (void)setupJPush:(NSDictionary *)launchOptions {
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
        
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    /// 自定义消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
    
    // apsForProduction - 0:(默认值)表示采用的是开发证书，1:表示采用生产证书发布应用
    [JPUSHService setupWithOption:launchOptions
                           appKey:[CONFIG_MANAGER jPush_key]
                          channel:[CONFIG_MANAGER jPush_channelId]
                 apsForProduction:[CONFIG_MANAGER jPush_apsForProduction]
            advertisingIdentifier:advertisingId];
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSString *title = [userInfo valueForKey:@"title"];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extra = [userInfo valueForKey:@"extras"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    NSString *currentContent = [NSString
                                stringWithFormat:
                                @"收到自定义消息:%@\ntitle:%@\ncontent:%@\nextra:%@\n",
                                [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                               dateStyle:NSDateFormatterNoStyle
                                                               timeStyle:NSDateFormatterMediumStyle],
                                title, content, [self logDic:extra]];
    NSLog(@"%@", currentContent);
    
    
    
    //    [_messageContents insertObject:currentContent atIndex:0];
    //
    //    NSString *allContent = [NSString
    //                            stringWithFormat:@"%@收到消息:\n%@\nextra:%@",
    //                            [NSDateFormatter
    //                             localizedStringFromDate:[NSDate date]
    //                             dateStyle:NSDateFormatterNoStyle
    //                             timeStyle:NSDateFormatterMediumStyle],
    //                            [_messageContents componentsJoinedByString:nil],
    //                            [self logDic:extra]];
    //
    //    _messageContentView.text = allContent;
    //    _messageCount++;
    //    [self reloadMessageCountLabel];
}
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

#pragma mark - JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    NSLog(@"userinfo ----------%@",userInfo);
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    NSLog(@"userinfo1 ----------%@",userInfo);
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    
    completionHandler();  // 系统要求执行这个方法
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
}


#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function


- (void)initNewVersionView {
    
    // 新特性页面
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *lastVersion = [SESSION_MANAGER getLastAppVersion];
    if (![currentVersion isEqualToString:lastVersion]) {
        MGSplashView *splashView = [[MGSplashView alloc]init];
        [splashView show];
    }
    
}



// 初始化主窗口
- (void)initRootWindow {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    ApplicationDelegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ApplicationDelegate.mainTabbarVC = [[MGTabBarController alloc] init];
    ApplicationDelegate.window.backgroundColor = [UIColor groupTableViewBackgroundColor];
    ApplicationDelegate.window.rootViewController = ApplicationDelegate.mainTabbarVC;
    [ApplicationDelegate.window makeKeyAndVisible];
    
}


/// 切换环境
- (void)changeTestDev {

    if (!(PROD_CONFIG)) {
        NSString *str = [SESSION_MANAGER getIsFirstTest];
        if (![str isEqualToString:@"isfirstTest"]) {
            [SESSION_MANAGER setIsFirstTest:@"isfirstTest"];
            [SESSION_MANAGER setLogin:NO];
            [SESSION_MANAGER setIsFirstTrue:@""];
        }
    }else{//真实
        NSString *str = [SESSION_MANAGER getIsFirstTrue];
        if (![str isEqualToString:@"isfirstTrue"]) {
            [SESSION_MANAGER setIsFirstTrue:@"isfirstTrue"];
            [SESSION_MANAGER setLogin:NO];
            [SESSION_MANAGER setIsFirstTest:@""];
        }
    }
}

/// 开启定时器检测动态
- (void)startTimerForCheckTrendUpdate {
    [self checkTrendUpdate];
    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(checkTrendUpdate) userInfo:nil repeats:YES];
    
}

- (void)checkTrendUpdate {
    
    [MGBussiness loadTrend_UpdateWithParams:@{@"current" : [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss"]} completion:^(id results) {
        
        if ([results boolValue]) {
            [ApplicationDelegate.mainTabbarVC.tabBar showBadgeOnItemIndex:2];
        }
        
    } error:nil];
    
}


#pragma mark - Getter and Setter


DEF_SINGLETON(MGAppDriven);

@end
