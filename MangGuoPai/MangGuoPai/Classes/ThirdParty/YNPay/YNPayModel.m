//
//  YNPayModel.m
//  0_13封装支付
//
//  Created by ZYN on 16/11/3.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import "YNPayModel.h"
#import <UIKit/UIKit.h>

@implementation YNPayModel

/** 快速实例化 */
+(instancetype)modelWithRedirectURL:(NSString *)redirectURL{
    
    YNPayModel *m = [self new];
    m.redirectURL = redirectURL;
    
    return m;
}


/** 支付宝数据填充 */
-(void)aliPayFillWithPrivateKey:(NSString *)privateKey appId:(NSString *)appId{
    
    self.privateKey = privateKey;
    
    self.aliPay_AppId = appId;
}


/** 微信数据填充 */
-(void)wechatFillWithAppID:(NSString *)appID mch_id:(NSString *)mch_id partnerKey:(NSString *)partnerKey{
    
    self.wechat_AppID = appID;
    self.weChat_Mch_id = mch_id;
    self.weChat_API_PartnerKey = partnerKey;
}


/** 数据检查 */
-(void)aliPayCheck{
    
    NSString *errorMsg = nil;
    
    if(self.privateKey.length == 0) {errorMsg = @"支付宝的privateKey不能为空";}
    if(self.aliPay_AppId.length == 0) {errorMsg = @"支付宝的appId不能为空";}
    
    if (errorMsg != nil){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"支付宝参数错误" message:errorMsg delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alertView show];
    }
}
-(void)wechatCheck{
    
    NSString *errorMsg = nil;
    
    if(self.wechat_AppID.length == 0) {errorMsg = @"微信支付的appID为空";}
    if(self.weChat_Mch_id.length == 0) {errorMsg = @"微信支付的mch_id为空";}
    if(self.weChat_API_PartnerKey.length == 0) {errorMsg = @"微信支付的partnerKey为空";}
    
    if (errorMsg != nil){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"微信支付参数错误" message:errorMsg delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alertView show];
    }
}


@end
