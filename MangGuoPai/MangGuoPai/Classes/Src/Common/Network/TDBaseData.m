//
//  TDBaseData.m
//  TDQianxiaoer
//
//  Created by huijie on 2017/3/23.
//  Copyright © 2017年 TDMarket. All rights reserved.
//

#import "TDBaseData.h"
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <MJExtension.h>

#import <YYModel.h>
@implementation TDBaseData

#pragma mark - Life Cycle
static TDBaseData *settingSingleton = nil;

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (settingSingleton == nil) {
            settingSingleton = [super allocWithZone:zone];
        }
    }
    return settingSingleton;
}

+ (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)init {
    self = [super init];
    
    if (self) {
        [self setupData];
    }
    
    return self;
}

#pragma mark - Public Function
+ (TDBaseData *)sharedInstance {
    @synchronized(self){
        if(settingSingleton  ==  nil){
            settingSingleton = [[self alloc] init];
        }
    }
    return  settingSingleton;
}

- (NSMutableDictionary *)returnDictionary {
    return [self returnDictionary:YES];
}

- (NSMutableDictionary *)returnDictionary:(BOOL)needSession_id {
    NSMutableDictionary *dic     = [NSMutableDictionary dictionaryWithCapacity:0];
    
    // 封装数据
    [dic setObject:[TDCommonTool getTimeStamp] forKey:@"timestamp"];
    [dic setObject:self.format forKey:@"format"];
    
    /// 有session_id 就直接传递
    NSString *session_id = [SESSION_MANAGER getSessionId];
    if (needSession_id && session_id.length > 0) {
        [dic setObject:session_id forKey:@"lst_sessid"];
    }
    return dic;
}


- (NSMutableDictionary *)returnParamsWithModal:(id)modal {
    NSMutableDictionary *dic = [[TDBaseData sharedInstance] returnDictionary];
    NSDictionary *mj_Dict = [modal mj_keyValues];
    NSDictionary *paramDict = mj_Dict.count == 0 ? @{} : mj_Dict;
    [dic setValuesForKeysWithDictionary:paramDict];
    
    return dic;
}

- (NSMutableDictionary *)returnDictionaryWithContent:(NSDictionary *)contentDic {
    NSMutableDictionary *dic = [[TDBaseData sharedInstance] returnDictionary];
    if (contentDic) {
        [dic setValuesForKeysWithDictionary:contentDic];
    }
    return dic;
}

#pragma mark - Private Function

- (void)setupData {
    
    self.key          = [TDBaseData returnKey];
    self.device_type  = [TDBaseData returnDeviceType];
    self.appVersion   = [TDBaseData returnAppVersion];
    self.clientModel  = [TDBaseData returnClientModel];
    self.OSVersion    = [TDBaseData returnOSVersion];
    self.packageName  = [TDBaseData returnPackageName];
    self.channel      = [TDBaseData returnChannel];
    self.uuid         = [TDBaseData returnUUID];
    
    /// 芒果派
    self.format = [TDBaseData returnFormat];
}

+ (NSString *)returnUUID {
    CFUUIDRef puuid        = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString * result      = (__bridge NSString *)CFStringCreateCopy(NULL, uuidString);
    CFRelease(puuid);
    CFRelease(uuidString);
    
    // 去掉"-"
    return [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

+ (NSString *)returnKey {
    return @"";
}

+ (NSString *)returnDeviceType {
    return @"iPhone";
}

+ (NSString *)returnAppVersion {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    return [infoDic objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)returnClientModel {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [[NSString alloc]initWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"])
        return @"iPhone 1G";
    else if ([platform isEqualToString:@"iPhone1,2"])
        return @"iPhone 3G";
    else if ([platform isEqualToString:@"iPhone2,1"])
        return @"iPhone 3GS";
    else if ([platform isEqualToString:@"iPhone3,1"])
        return @"iPhone 4";
    else if ([platform isEqualToString:@"iPhone3,2"])
        return @"iPhone 4";
    else if ([platform isEqualToString:@"iPhone3,3"])
        return @"iPhone 4";
    else if ([platform isEqualToString:@"iPhone4,1"])
        return @"iPhone 4s";
    else if ([platform isEqualToString:@"iPhone5,1"])
        return @"iPhone 5";
    else if ([platform isEqualToString:@"iPhone5,2"])
        return @"iPhone 5";
    else if ([platform isEqualToString:@"iPhone5,3"])
        return @"iPhone 5c";
    else if ([platform isEqualToString:@"iPhone5,4"])
        return @"iPhone 5c";
    else if ([platform isEqualToString:@"iPhone6,1"])
        return @"iPhone 5s";
    else if ([platform isEqualToString:@"iPhone6,2"])
        return @"iPhone 5s";
    
    // iPod Touch
    else if ([platform isEqualToString:@"iPod1,1"])
        return @"iPod Touch 1G";
    else if ([platform isEqualToString:@"iPod2,1"])
        return @"iPod Touch 2G";
    else if([platform isEqualToString:@"iPod3,1"])
        return @"iPod Touch 3G";
    else if ([platform isEqualToString:@"iPod4,1"])
        return @"iPod Touch 4G";
    else if ([platform isEqualToString:@"iPod5,1"])
        return @"iPod Touch 5G";
    
    // iPad
    else if ([platform isEqualToString:@"iPad1,1"])
        return @"iPad";
    else if ([platform isEqualToString:@"iPad2,1"])
        return @"iPad 2";
    else if ([platform isEqualToString:@"iPad2,2"])
        return @"iPad 2";
    else if ([platform isEqualToString:@"iPad2,3"])
        return @"iPad 2";
    else if ([platform isEqualToString:@"iPad2,4"])
        return @"iPad 2";
    else if([platform isEqualToString:@"iPad2,5"] || [platform isEqualToString:@"iPad2,6"] || [platform isEqualToString:@"iPad2,7"])     return@"iPad Mini";
    else if ([platform isEqualToString:@"iPad3,1"])
        return @"iPad 3";
    else if ([platform isEqualToString:@"iPad3,2"])
        return @"iPad 3";
    else if ([platform isEqualToString:@"iPad3,3"])
        return @"iPad 3";
    else if ([platform isEqualToString:@"iPad3,4"])
        return @"iPad 4";
    
    return platform;
}

+ (NSString *)returnOSVersion {
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)returnPackageName {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    return [infoDic objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)returnChannel {
    return @"BeijiaBill-iOS";
}

+ (NSString *)returnFormat {
    return @"json";
}


@end
