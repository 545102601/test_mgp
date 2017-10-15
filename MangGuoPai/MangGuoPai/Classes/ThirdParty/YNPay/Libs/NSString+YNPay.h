//
//  NSString+YNPay.h
//  0_13封装支付
//
//  Created by ZYN on 16/11/3.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YNPay)
/// 拼接dict参数
-(NSString *)payParamsHandle:(NSDictionary *)payParams;
/// 产生随机订单号
+(NSString *)generateTradeNO;

+(NSString*)ConvertDictionarytoXML:(NSDictionary*)dictionary;

@end
