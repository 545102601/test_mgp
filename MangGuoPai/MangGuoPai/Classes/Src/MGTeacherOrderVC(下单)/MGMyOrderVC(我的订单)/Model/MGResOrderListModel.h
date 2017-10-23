//
//  MGResOrderListModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/3.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"

@interface MGResOrderListDataModel : BaseModel

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
/// 支付方式
@property (nonatomic, copy) NSString *pay_channel;
/// 安排日期 yyyy-MM-dd
@property (nonatomic, strong) NSDate *sct_date;
/// 安排时间 时间点
@property (nonatomic, assign) NSInteger sct_time;

/// 安排日期 + 时间点
@property (nonatomic, copy) NSString *sct_date_string;

@end

@interface MGResOrderModel : BaseResModel

@property (nonatomic, strong) MGResOrderListDataModel *data;

@end


@interface MGResOrderListModel : BaseResModel


@property (nonatomic, copy) NSArray *data;


@end
