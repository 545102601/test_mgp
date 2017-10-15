//
//  MGResOrderAddModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/31.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"

@interface MGResOrderAddDataModel : BaseModel

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
/// 会员手机号
@property (nonatomic, copy) NSString *member_mobile;
/// 导师id
@property (nonatomic, assign) long tutor_id;

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
@property (nonatomic, assign) NSInteger state;

@end

@interface MGResOrderAddModel : BaseResModel

@property (nonatomic, strong) MGResOrderAddDataModel *data;

@end
