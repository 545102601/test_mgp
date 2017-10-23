//
//  YNPay.h
//  0_13封装支付
//
//  Created by ZYN on 16/11/3.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//  微信 支付宝 支付

#import <UIKit/UIKit.h>
#import "YNPayModel.h"
#import "YNPayConstant.h"

typedef NS_ENUM(NSInteger, YNPayType) {
    
    YNPayTypeAliPay = 0,
    YNPayTypeWeChat = 1
};

typedef void(^CompleteBlock)(NSString *errorMsg);

@interface YNPay : NSObject

@property (nonatomic,assign) BOOL isRegisterWeChatPay;

@property (nonatomic,copy) CompleteBlock completeBlock;

+ (instancetype)shareInstance;

+ (void)handleOpenURL:(NSURL *)url;


+ (void)payAliWithOrderStrng:(NSString *)orderString
             completeClosure:(CompleteBlock)completeClosure;

+ (void)payWxWithPayDataDict:(NSDictionary *)dict
             completeClosure:(CompleteBlock)completeClosure;

+ (void)payWithType:(YNPayType)type
       accountModel:(YNPayModel *)accountModel
              money:(NSString *)money
            orderID:(NSString *)orderID
              title:(NSString *)title
               desc:(NSString *)desc
    completeClosure:(CompleteBlock)completeClosure;




@end
