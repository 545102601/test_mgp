//
//  YNPayModel.h
//  0_13封装支付
//
//  Created by ZYN on 16/11/3.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YNPayModel : NSObject

/*
 *  全局
 */

/** 密钥 */
@property (nonatomic,copy) NSString *privateKey;

/** 回调地址 */
@property (nonatomic,copy) NSString *redirectURL;




/*
 *  支付宝
 */

@property (nonatomic, copy) NSString *aliPay_AppId;


/*
 *  微信支付
 */

/** 微信开发平台：AppID */
@property (nonatomic,copy) NSString *wechat_AppID;

/** 微信支付商号 */
@property (nonatomic,copy) NSString *weChat_Mch_id;

/** API_PartnerKey */
@property (nonatomic,copy) NSString *weChat_API_PartnerKey;


/** 快速实例化 */
+(instancetype)modelWithRedirectURL:(NSString *)redirectURL;


/** 支付宝数据填充 */
-(void)aliPayFillWithPrivateKey:(NSString *)privateKey appId:(NSString *)appId;


/** 微信数据填充 */
-(void)wechatFillWithAppID:(NSString *)appID mch_id:(NSString *)mch_id partnerKey:(NSString *)partnerKey;


/** 数据检查 */
-(void)aliPayCheck;

-(void)wechatCheck;


@end
