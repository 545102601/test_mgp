//
//  MGResOrderDetailModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/7.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"

@interface MGResOrderDetailCommentModel : BaseModel

@property (nonatomic, assign) long id;
/// 课程id
@property (nonatomic, assign) long course_id;
/// 人员Id
@property (nonatomic, assign) long member_id;
/// 人员昵称
@property (nonatomic, copy) NSString *member_name;
/// 点评内容
@property (nonatomic, copy) NSString *content;
/// 回复
@property (nonatomic, copy) NSString *reply;


@end


@interface MGResOrderDetailDataModel : BaseModel


@property (nonatomic, assign) long id;
/// 编号
@property (nonatomic, copy) NSString *order_no;
/// 课程id
@property (nonatomic, assign) long course_id;
/// 订单昵称
@property (nonatomic, copy) NSString *order_name;
/// 订单数量
@property (nonatomic, assign) NSInteger order_count;
/// 会员id
@property (nonatomic, assign) long member_id;
/// 会员昵称
@property (nonatomic, copy) NSString *member_name;
/// 会员手机
@property (nonatomic, copy) NSString *member_mobile;

/// 课程昵称
@property (nonatomic, copy) NSString *course_name;
/// 导师id
@property (nonatomic, assign) long tutor_id;
/// 导师昵称
@property (nonatomic, copy) NSString *tutor_name;

/// 支付金额
@property (nonatomic, assign) double pay_price;
/// 销售金额
@property (nonatomic, assign) double sale_price;
/// 总金额
@property (nonatomic, assign) double total_price;
/// 优惠金额
@property (nonatomic, assign) double discount_price;
/// 优惠码
@property (nonatomic, copy) NSString *promotion_code;


/// 状态
@property (nonatomic, assign) MGGlobalOrderState state;
/// 状态标签
@property (nonatomic, copy) NSString *state_label;
/// 支付状态
@property (nonatomic, assign) NSInteger pay_state;
/// 支付状态标签
@property (nonatomic, copy) NSString *pay_state_label;
/// 下单时间
@property (nonatomic, strong) NSDate *order_time;
/// 下单时间 str
@property (nonatomic, copy) NSString *order_time_string;




/// 订单留言信息
@property (nonatomic, copy) NSString *order_message;
/// 订单备注信息
@property (nonatomic, copy) NSString *order_memos;
/// 订单售后信息
@property (nonatomic, copy) NSString *after_sale_info;
/// 附件
@property (nonatomic, copy) NSArray *material_rsurls;
/// 点评信息
@property (nonatomic, copy) NSArray *comments;


@end


@interface MGResOrderDetailModel : BaseResModel

@property (nonatomic, strong) MGResOrderDetailDataModel *data;

@end
