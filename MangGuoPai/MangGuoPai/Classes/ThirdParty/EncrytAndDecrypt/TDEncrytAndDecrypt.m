//
//  TDEncrytAndDecrypt.m
//  TDQianxiaoer
//
//  Created by huijie on 2017/3/17.
//  Copyright © 2017年 TDMarket. All rights reserved.
//

#import "TDEncrytAndDecrypt.h"
#import <Security/Security.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation TDEncrytAndDecrypt
+ (NSString *)md5:(NSString *)input
{
    if(input == nil)
    {
        return @"";
    }
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

@end
