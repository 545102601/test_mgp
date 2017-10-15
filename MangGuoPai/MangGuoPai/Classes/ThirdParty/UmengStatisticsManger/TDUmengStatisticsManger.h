//
//  TDUmengStatisticsManger.h
//  TDQianxiaoer
//
//  Created by huijie on 2017/4/5.
//  Copyright © 2017年 TDMarket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMMobClick/MobClick.h"

#define UMENG_MANAGER [TDUmengStatisticsManger sharedManager]

@interface TDUmengStatisticsManger : NSObject
/** 整个Plist文件 */
@property (nonatomic, strong) NSMutableDictionary *configPlistInfo;

/**********************************************************************/
/** 初始化 */
+ (id)sharedManager;
/** 次数统计 */
+ (void)numberOfStatistics:(NSString *)eventID;
/** 次数统计 plist key*/
+ (void)numberOfStatisticsInfoPlistKey:(NSString *)key;



/** 停留时长统计，begin和End配对使用 */
+ (void)beginEvent:(NSString *)eventID;
+ (void)endEvent:(NSString *)eventID;

/** 停留时长统计，begin和End配对使用 plist key */
+ (void)beginEventWithKey:(NSString *)key;
+ (void)endEventWithKey:(NSString *)key;




@end
