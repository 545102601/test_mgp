//
//  MGCouponOwnsModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/12.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"


@interface MGCouponOwnsDataModel : BaseResModel

@property (nonatomic, assign) long id;
/// 会员id
@property (nonatomic, assign) long member_id;
/// 优惠券id
@property (nonatomic, assign) long coupon_id;
/// 有效结束时间
@property (nonatomic, strong) NSDate *end_time;
@property (nonatomic, copy) NSString *end_time_str;

/// 有效开始时间
@property (nonatomic, strong) NSDate *start_time;
@property (nonatomic, copy) NSString *start_time_str;
//50:待使用
//0：已使用
//-1：已过期
@property (nonatomic, assign) NSInteger state;

@property (nonatomic, copy) NSString *state_label;
/// 使用时间
@property (nonatomic, strong) NSDate *use_time;
/// 会员名称
@property (nonatomic, copy) NSString *member_name;
/// 优惠券昵称
@property (nonatomic, copy) NSString *coupon_name;
/// 优惠券描述
@property (nonatomic, copy) NSString *coupon_desc;


@end

@interface MGCouponOwnsModel : BaseResModel

@property (nonatomic, copy) NSArray *data;

@end
