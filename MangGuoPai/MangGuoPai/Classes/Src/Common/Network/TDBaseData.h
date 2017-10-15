//
//  TDBaseData.h
//  TDQianxiaoer
//
//  Created by huijie on 2017/3/23.
//  Copyright © 2017年 TDMarket. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDBaseData : NSObject
/** 加密后的aesKey, 为空时即通过session查找 */
@property (strong ,nonatomic) NSString *key;
/** 设备类型 */
@property (strong ,nonatomic) NSString *device_type;
/** app版本号 */
@property (strong ,nonatomic) NSString *appVersion;
/** 手机型号 */
@property (strong ,nonatomic) NSString *clientModel;
/** 手机系统版本 */
@property (strong ,nonatomic) NSString *OSVersion;
/** 手机唯一标识码 */
@property (strong ,nonatomic) NSString *uuid;
/** 应用包名 */
@property (strong ,nonatomic) NSString *packageName;
@property (strong ,nonatomic) NSString *channel;




// ------ 芒果派
/** 传输格式*/
@property (nonatomic, strong) NSString *format;



/** 单例 - 初始化 */
+ (TDBaseData *)sharedInstance;

/** 返回非业务请求报文 */
- (NSMutableDictionary *)returnDictionary;

/** 根据业务模型数据，返回请求报文 */
- (NSMutableDictionary *)returnParamsWithModal:(id)modal;

/** 根据业务字典数据，返回请求报文 */
- (NSMutableDictionary *)returnDictionaryWithContent:(NSDictionary *)contentDic;

@end
