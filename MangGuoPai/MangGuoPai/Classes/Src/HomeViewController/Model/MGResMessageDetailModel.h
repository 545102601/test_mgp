//
//  MGResMessageDetailModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/11/19.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"

@interface MGResMessageDetailDataModel : BaseModel

@property (nonatomic, assign) long id;
//消息发送者类型
//User:平台用户
//Member:会员
//Sys:平台官方
@property (nonatomic, copy) NSString *send_user_type;
/// 发送者名字
@property (nonatomic, copy) NSString *send_user_name;
/// 发送者ID
@property (nonatomic, assign) long send_user_id;
/// 标题
@property (nonatomic, copy) NSString *title;
/// 结果
@property (nonatomic, copy) NSString *result;
/// 备注
@property (nonatomic, copy) NSString *remark;
// 状态
@property (nonatomic, assign) NSInteger state;
/// 状态标签
@property (nonatomic, copy) NSString *state_label;
/// 链接地址
@property (nonatomic, copy) NSString *url;
/// 消息来源id
@property (nonatomic, assign) long entity_id;
/// 消息来源类型
@property (nonatomic, assign) NSInteger entity_type;
/// 消息来源名称
@property (nonatomic, copy) NSString *entity_name;

@end

@interface MGResMessageDetailModel : BaseResModel

@property (nonatomic, strong) MGResMessageDetailDataModel *data;

@end
