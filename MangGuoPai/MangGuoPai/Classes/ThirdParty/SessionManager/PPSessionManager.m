//
//  PPSessionManager.m
//  TDQianxiaoer
//
//  Created by 林晖杰 on 16/3/28.
//  Copyright © 2016年 林晖杰. All rights reserved.
//

/** 用户登录状态 */
#define CURRENT_USER_LOGIN_STATUS @"CURRENT_USER_LOGIN_STATUS"
/** 用户激活状态 */
#define CURRENT_USER_ACTIVE_STATUS @"CURRENT_USER_ACTIVE_STATUS"
/** 用户头像地址 */
#define CURRENT_USER_IMAGE_URL @"CURRENT_USER_IMAGE_URL"
/** 用户发送验证码的时间*/
#define SEND_MESSAGE_DATE @"SEND_MESSAGE_DATE"
/** 用户UID */
#define CURRENT_USER_UID @"CURRENT_USER_UID"
/** 用户Session Id */
#define CURRENT_USER_SESSION_ID @"CURRENT_USER_SESSION_ID"
/** 用户昵称 */
#define CURRENT_USER_NICKNAME @"CURRENT_USER_NICKNAME"

/** 记录上次应用版本 */
#define LAST_APP_VERSION @"LAST_APP_VERSION"
/// 用户的身份标识
#define USER_IDENTIFIES @"USER_IDENTIFIES"

/// 首页升级身份View
#define HOME_UPGRADE_VIEW @"HOME_UPGRADE_VIEW"

/// 首页领取优惠券
#define HOME_GET_COPUON @"HOME_GET_COPUON"

/// 环境
#define APP_IS_TEST @"APP_IS_TEST"
#define APP_IS_TRUE @"APP_IS_TRUE"



#import "PPSessionManager.h"

@interface PPSessionManager(){
    
}
@property (nonatomic,strong) NSArray *removeKeyList;
@property (nonatomic,strong) NSUserDefaults *userDefault;
@end

static PPSessionManager *defaultManager;

@implementation PPSessionManager

#pragma mark - Public Function
+ (id)sharedManager {
    @synchronized(@"PPSessionManager") {
        if(!defaultManager){
            defaultManager               = [[self alloc] init];
            defaultManager.userDefault   = [NSUserDefaults standardUserDefaults];
            defaultManager.removeKeyList = @[CURRENT_USER_SESSION_ID,
                                             CURRENT_USER_UID];
        }
    }
    return defaultManager;
}

- (void)setLogin:(BOOL)login {
    [SESSION_MANAGER saveData:[NSNumber numberWithBool:login]
                       andKey:CURRENT_USER_LOGIN_STATUS];
    if (!login) {
        [self removeUserInfo];
    }
}

- (BOOL)isLogin {
    return [[SESSION_MANAGER getDataByKey:CURRENT_USER_LOGIN_STATUS] boolValue];
}


- (void)setCurrentUserNickName:(NSString *)nickName {
    [SESSION_MANAGER saveData:nickName
                       andKey:[NSString stringWithFormat:@"%@%@", [SESSION_MANAGER getCurrentUserUid], CURRENT_USER_NICKNAME]];
}

- (NSString *)getCurrentUserNickName {
    return [SESSION_MANAGER getDataByKey:[NSString stringWithFormat:@"%@%@", [SESSION_MANAGER getCurrentUserUid], CURRENT_USER_NICKNAME]];
}

- (void)setCurrentUserImageUrl:(NSString *)userImageUrl {
    [SESSION_MANAGER saveData:userImageUrl
                       andKey:[NSString stringWithFormat:@"%@%@", [SESSION_MANAGER getCurrentUserUid], CURRENT_USER_IMAGE_URL]];
}

- (NSString *)getCurrentUserImageUrl {
    return [SESSION_MANAGER getDataByKey:[NSString stringWithFormat:@"%@%@", [SESSION_MANAGER getCurrentUserUid], CURRENT_USER_IMAGE_URL]];
}

- (NSString *)getAssignUserImageUrl:(NSString *)userString {
    return [SESSION_MANAGER getDataByKey:[NSString stringWithFormat:@"%@%@", userString, CURRENT_USER_IMAGE_URL]];
}


- (void)setCurrentUserUid:(NSString *)uid {
    [SESSION_MANAGER saveData:uid
                       andKey:CURRENT_USER_UID];
}

- (NSString *)getCurrentUserUid {
    return [SESSION_MANAGER getDataByKey:CURRENT_USER_UID];
}


- (void)setSessionId:(NSString *)sessionId {
    [SESSION_MANAGER saveData:sessionId
                       andKey:CURRENT_USER_SESSION_ID];
}

- (NSString *)getSessionId {
    return [SESSION_MANAGER getDataByKey:CURRENT_USER_SESSION_ID];
}


- (void)setLastAppVersion:(NSString *)string {
    [SESSION_MANAGER saveData:string
                       andKey:LAST_APP_VERSION];
}

- (NSString *)getLastAppVersion {
    return [SESSION_MANAGER getDataByKey:LAST_APP_VERSION];
}


/// 设置用户的身份
- (void)setUserIdentifies:(NSArray *)userIdentifies {
    
    [SESSION_MANAGER saveData:userIdentifies
                       andKey:[NSString stringWithFormat:@"%@%@", [SESSION_MANAGER getCurrentUserUid], USER_IDENTIFIES]];
}
- (NSArray *)getUserIdentifies {
    return [SESSION_MANAGER getDataByKey:[NSString stringWithFormat:@"%@%@", [SESSION_MANAGER getCurrentUserUid], USER_IDENTIFIES]];
    
}

/// 设置首页升级身份提示
- (void)setUpgradeView:(BOOL)isHidden {
    [SESSION_MANAGER saveData:@(isHidden)
                       andKey:[NSString stringWithFormat:@"%@%@", [SESSION_MANAGER getCurrentUserUid], HOME_UPGRADE_VIEW]];
}
- (BOOL)getUpgradeView {
    
    return [[SESSION_MANAGER getDataByKey:[NSString stringWithFormat:@"%@%@", [SESSION_MANAGER getCurrentUserUid], HOME_UPGRADE_VIEW]] boolValue];
}



/// 设置优惠券是否领取成功
- (void)setCouponIsSuccess:(BOOL)isSuccess entity_id:(NSInteger)entity_id {
    [SESSION_MANAGER saveData:@(isSuccess)
                       andKey:[NSString stringWithFormat:@"%@_%@_%zd", [SESSION_MANAGER getCurrentUserUid], HOME_GET_COPUON, entity_id]];
}
- (BOOL)getCouponIsSuccessWithEntity_id:(NSInteger)entity_id {
    return [[SESSION_MANAGER getDataByKey:[NSString stringWithFormat:@"%@_%@_%zd", [SESSION_MANAGER getCurrentUserUid], HOME_GET_COPUON, entity_id]] boolValue];
}



/// 切换环境
- (void)setIsFirstTest:(NSString *)firstTest {
    [SESSION_MANAGER saveData:firstTest
                       andKey:APP_IS_TEST];
}
- (NSString *)getIsFirstTest {
    return [SESSION_MANAGER getDataByKey:APP_IS_TEST];
}
- (void)setIsFirstTrue:(NSString *)firstTrue {
    [SESSION_MANAGER saveData:firstTrue
                       andKey:APP_IS_TRUE];
}
- (NSString *)getIsFirstTrue {
    
    return [SESSION_MANAGER getDataByKey:APP_IS_TRUE];
}

#pragma mark - Private Function
- (void)saveData:(id)_data andKey:(NSString*)_key {
    
    if ([_data isKindOfClass:[NSNull class]]) {
        return;
    }
    
    [self.userDefault setValue:_data forKey:_key];
    [self.userDefault synchronize];
}

- (id)getDataByKey:(NSString*)_key {
    return [self.userDefault valueForKey:_key];
}

- (void)removeUserInfo {
    for (NSString *key in _removeKeyList) {
        [self.userDefault removeObjectForKey:key];
    }
}

@end
