//
//  MGResMessageModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//  消息列表

#import "BaseModel.h"

@interface MGResMessageDataModel : BaseModel

@property (nonatomic, assign) long id;
//消息发送者类型
//User:平台用户
//Member:会员
//Sys:平台官方
@property (nonatomic, copy) NSString *send_user_type;
/// 发送者名字
@property (nonatomic, copy) NSString *send_user_name;
/// 发送者id
@property (nonatomic, assign) NSInteger send_user_id;
/// 标题
@property (nonatomic, copy) NSString *title;
/// 结果
@property (nonatomic, copy) NSString *result;
/// 备注
@property (nonatomic, copy) NSString *remark;
/// 状态
@property (nonatomic, assign) MGGlobaState state;
/// 是否已读
@property (nonatomic, assign) BOOL isRead;
/// 状态标签
@property (nonatomic, copy) NSString *state_label;
/// 超链接URL
@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) MGGlobalEntityType entity_type;



//@property (nonatomic, assign) long create_time;

@property (nonatomic, copy) NSString *create_time_label;
//
//remark = 您申请升级为导师失败,
//result = 审核不通过,
//state = 1,
//id = 99,
//send_user_name = 芒果派官方,
//state_label = 已阅,
//title = 用户升级,
//send_user_type = Sys,
//create_time = 1503588312000,
//create_time_label = 昨天23:25:12,
//send_user_id = -1


@end

@interface MGResMessageModel : BaseResModel

@property (nonatomic, copy) NSArray *data;

@end
