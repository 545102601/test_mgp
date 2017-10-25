//
//  PPSessionManager.h
//  TDQianxiaoer
//
//  Created by 林晖杰 on 16/3/28.
//  Copyright © 2016年 林晖杰. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SESSION_MANAGER [PPSessionManager sharedManager]


@interface PPSessionManager : NSObject

/**
 初始化
 */
+ (id)sharedManager;

//设置用户登录状态
- (void)setLogin:(BOOL)login;
//获取用户登录状态
- (BOOL)isLogin;

//设置用户昵称
- (void)setCurrentUserNickName:(NSString *)nickName;
//获取用户昵称
- (NSString *)getCurrentUserNickName;


//设置用户头像地址
- (void)setCurrentUserImageUrl:(NSString *)userImageUrl;
//获取用户头像地址
- (NSString *)getCurrentUserImageUrl;
//获取指定用户头像地址，userString -> 用户手机号
- (NSString *)getAssignUserImageUrl:(NSString *)userString;

//设置用户UID
- (void)setCurrentUserUid:(NSString *)uid;
//获取用户UID
- (NSString *)getCurrentUserUid;

//设置用户Session Id
- (void)setSessionId:(NSString *)sessionId;
//获取用户Session Id
- (NSString *)getSessionId;

//设置上一个App版本
- (void)setLastAppVersion:(NSString *)string;
//获取上一个App版本
- (NSString *)getLastAppVersion;


/// 设置用户的身份
- (void)setUserIdentifies:(NSArray *)userIdentifies;
- (NSArray *)getUserIdentifies;

/// 设置首页升级身份提示
- (void)setUpgradeView:(BOOL)isHidden;
- (BOOL)getUpgradeView;

/// 设置优惠券是否领取成功
- (void)setCouponIsSuccess:(BOOL)isSuccess entity_id:(NSInteger)entity_id;
- (BOOL)getCouponIsSuccessWithEntity_id:(NSInteger)entity_id;

/// 切换环境
- (void)setIsFirstTest:(NSString *)firstTest;
- (NSString *)getIsFirstTest;
- (void)setIsFirstTrue:(NSString *)firstTrue;
- (NSString *)getIsFirstTrue;


- (void)saveData:(id)_data andKey:(NSString*)_key;

- (id)getDataByKey:(NSString*)_key;

@end
