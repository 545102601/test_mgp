//
//  TDConfigManager.h
//  TDQianxiaoer
//
//  Created by huijie on 2017/3/30.
//  Copyright © 2017年 TDMarket. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CONFIG_MANAGER [TDConfigManager sharedManager]

@interface TDConfigManager : NSObject

/** 整个Plist文件 */
@property (nonatomic, strong) NSMutableDictionary *configPlistInfo;

/** 友盟配置数据 */
@property (nonatomic, strong) NSString *umeng_key;
@property (nonatomic, strong) NSString *umeng_qq_id;
@property (nonatomic, strong) NSString *umeng_qq_key;
@property (nonatomic, strong) NSString *umeng_weibo_key;
@property (nonatomic, strong) NSString *umeng_weibo_secret;
@property (nonatomic, strong) NSString *umeng_weibo_redirect;
@property (nonatomic, strong) NSString *umeng_wechat_key;
@property (nonatomic, strong) NSString *umeng_wechat_secret;
@property (nonatomic, strong) NSString *umeng_channelId;

/** 极光配置数据 */
@property (nonatomic, strong) NSString *jPush_key;
@property (nonatomic, strong) NSString *jPush_channelId;
@property (nonatomic, assign) BOOL jPush_apsForProduction;

/** 百度配置数据 */
@property (nonatomic, strong) NSString *baiduMob_Key;

/**********************************************************************/
/**
 * 初始化
 */
+ (id)sharedManager;
@end
