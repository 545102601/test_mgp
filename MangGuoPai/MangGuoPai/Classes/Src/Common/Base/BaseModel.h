//
//  BaseModel.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <MJExtension.h>
#import "BaseLogModel.h"
/// 公共模型
@interface BaseModel : BaseLogModel

@end

/// 服务端返回模型
@interface BaseResModel : BaseModel

/// 总数
@property (nonatomic, assign) NSInteger total_count;
/// 错误码
@property (nonatomic, copy) NSString *error_code;
/// 服务端消息
@property (nonatomic, copy) NSString *ret_msg;
/// 成功失败标志
@property (nonatomic, assign) NSInteger ret_flag;

@end

/// 请求模型
@interface BaseRequestModel : BaseModel


@end


