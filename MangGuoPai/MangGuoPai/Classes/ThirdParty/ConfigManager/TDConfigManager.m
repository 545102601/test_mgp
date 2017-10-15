//
//  TDConfigManager.m
//  TDQianxiaoer
//
//  Created by huijie on 2017/3/30.
//  Copyright © 2017年 TDMarket. All rights reserved.
//

#import "TDConfigManager.h"

@interface TDConfigManager ()

@end

@implementation TDConfigManager
#pragma mark - Public Function
+ (TDConfigManager *)sharedManager {
    static TDConfigManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        instance = [[self alloc] init];
        NSString *configPlistPath;
        
        // tencent1105956665 QQ41eb8f39
        // 根据环境选择配置文件
        #ifdef PROD_CONFIG
        configPlistPath = [[NSBundle mainBundle] pathForResource:@"prodConfig" ofType:@"plist"];
        #else
        configPlistPath = [[NSBundle mainBundle] pathForResource:@"devConfig" ofType:@"plist"];
        #endif
        
        instance.configPlistInfo = [[NSMutableDictionary alloc] initWithContentsOfFile:configPlistPath];
        
    });
    
    return instance;
}

#pragma mark - Private Function

#pragma mark - Getter and Setter
- (NSMutableDictionary *)configPlistInfo {
    return _configPlistInfo;
}

- (NSString *)umeng_key {
    return self.configPlistInfo[@"Umeng"][@"Umeng_Key"];
}

- (NSString *)umeng_qq_id {
    return self.configPlistInfo[@"Umeng"][@"qq_id"];
}

- (NSString *)umeng_qq_key{
    return self.configPlistInfo[@"Umeng"][@"qq_key"];
}

- (NSString *)umeng_weibo_key{
    return self.configPlistInfo[@"Umeng"][@"weibo_key"];
}

- (NSString *)umeng_weibo_secret{
    return self.configPlistInfo[@"Umeng"][@"weibo_secret"];
}

- (NSString *)umeng_weibo_redirect {
    return self.configPlistInfo[@"Umeng"][@"weibo_redirect"];
}

- (NSString *)umeng_wechat_key {
    return self.configPlistInfo[@"Umeng"][@"wechat_key"];
}

- (NSString *)umeng_wechat_secret {
    return self.configPlistInfo[@"Umeng"][@"wechat_secret"];
}

- (NSString *)umeng_channelId {
    return self.configPlistInfo[@"Umeng"][@"channelId"];
}

- (NSString *)jPush_key {
    return self.configPlistInfo[@"jPush"][@"jPush_key"];
}

- (NSString *)jPush_channelId {
    return self.configPlistInfo[@"jPush"][@"channelId"];
}

- (BOOL)jPush_apsForProduction {
    /// 调试模式用  开发证书
#if DEBUG
    return NO;
#else
    return [self.configPlistInfo[@"jPush"][@"apsForProduction"] boolValue];
#endif
}


- (NSString *)baiduMob_Key {
    return self.configPlistInfo[@"BaiduMob"][@"baiduMob_Key"];
}

@end
