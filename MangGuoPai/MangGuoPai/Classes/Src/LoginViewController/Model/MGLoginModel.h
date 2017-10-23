//
//  MGLoginModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/5.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseLogModel.h"
#define BIZ_ERR_LOGIN_YOOYO_SESSID_NOT_SUPPORTED @"BIZ_ERR_LOGIN_YOOYO_SESSID_NOT_SUPPORTED"
//对不起！不存在该会员
#define DATA_NOT_FOUND @"DATA_NOT_FOUND"
// 动态码已经过期
#define BIZ_ERR_LOGIN_SMSCODE_EXPIRED @"BIZ_ERR_LOGIN_SMSCODE_EXPIRED"
//用户名或密码错误
#define BIZ_ERR_MEMBER_LOGIN_FAIL @"BIZ_ERR_MEMBER_LOGIN_FAIL"
//请输入有效动态码
#define BIZ_ERR_LOGIN_SMSCODE_NOT_SUPPORTED @"BIZ_ERR_LOGIN_SMSCODE_NOT_SUPPORTED"
//验证码发送过于频繁，请稍候再发
#define BIZ_ERR_LOGIN_SMSCODE_SEND_COUNT_MUCH_MORE @"BIZ_ERR_LOGIN_SMSCODE_SEND_COUNT_MUCH_MORE"
//动态码已发到您的手机，请注意查收
#define BIZ_ERR_LOGIN_SMSCODE_SEND @"BIZ_ERR_LOGIN_SMSCODE_SEND"
//注册失败
#define BIZ_ERR_MEMBER_SIGNIN_ERROR @"BIZ_ERR_MEMBER_SIGNIN_ERROR"


@interface MGLoginModel : BaseLogModel
/** 手机号 */
@property (nonatomic, copy) NSString *mobile;

/** 密码 */
@property (nonatomic, copy) NSString *password;

/**
 * 登陆类型
 * 0.普通手机
 * 1.微博
 * 2.微信
 * 3.QQ
 */
@property (nonatomic, assign) NSInteger type;

/** 第三方登陆的accessToken */
@property (nonatomic, copy) NSString *platform;

/**
 * 1.微博 -> 传uid
 * 2.微信 -> 传open_id
 * 3.QQ -> 传open_id
 */
@property (nonatomic, copy) NSString *open_id;
/** 微信 */
@property (nonatomic, copy) NSString *union_id;

/** 短信验证码 */
@property (nonatomic, copy) NSString *sms_code;

/** 第三方昵称 */
@property (nonatomic, copy) NSString *nickname;

/** 第三方头像URL */
@property (nonatomic, copy) NSString *head_img;

/// 用户登录 session_id
@property (nonatomic, copy) NSString *lst_sessid;


/// 接口返回的 错误提示信息
+ (BOOL)loginShowErrorCode:(NSString *)erroCode;



@end
