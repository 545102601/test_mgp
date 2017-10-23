//
//  MGResOrderDetailModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/7.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"
#import "MGResOrderListModel.h"

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

/// 继承 订单 列表 数据
@interface MGResOrderDetailDataModel : MGResOrderListDataModel

/// 总金额
@property (nonatomic, assign) double total_price;
/// 优惠金额
@property (nonatomic, assign) double discount_price;
/// 优惠码
@property (nonatomic, copy) NSString *promotion_code;


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
