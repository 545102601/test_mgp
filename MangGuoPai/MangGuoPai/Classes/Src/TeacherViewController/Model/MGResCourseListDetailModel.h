//
//  MGResCourseListDetailModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"

@interface MGResCourseListDetailDataModel : BaseModel

@property (nonatomic, assign) long id;
/// 课程昵称
@property (nonatomic, copy) NSString *classify_name;
/// 课程标题
@property (nonatomic, copy) NSString *course_title;
/// 形象图地址
@property (nonatomic, copy) NSString *logo_rsurl;
/// 城市
@property (nonatomic, copy) NSString *city;
/// 课程内容
@property (nonatomic, copy) NSString *course_content;
/// 服务时间
@property (nonatomic, copy) NSString *service_time;
/// 服务时长
@property (nonatomic, copy) NSString *each_time;
/// 状态
@property (nonatomic, assign) MGGlobaState state;
/// 状态标签
@property (nonatomic, copy) NSString *state_label;
/// 课程分类id
@property (nonatomic, assign) long classify_id;
/// 课程类型id
@property (nonatomic, assign) long type_id;
/// 课程类型名称
@property (nonatomic, copy) NSString *type_name;
/// 销售价格
@property (nonatomic, assign) double sale_price;
/// 授课方式
@property (nonatomic, copy) NSString *type_method;
/// 导师形象地址
@property (nonatomic, copy) NSString *avatar_rsurl;
/// 导师昵称
@property (nonatomic, copy) NSString *member_name;
/// 导师id
@property (nonatomic, assign) long member_id;
/// 文档附件
@property (nonatomic, copy) NSArray *material_rsurls;
/// 是否收藏
@property (nonatomic, assign) NSInteger is_favor;
/// 特别说明
@property (nonatomic, copy) NSString *type_explains;

/// 附加： 优惠码说明
@property (nonatomic, copy) NSString *servicesCode;
/// 附加：
@property (nonatomic, copy) NSAttributedString *contentAttributeString;
@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, copy) NSAttributedString *type_explainsAttributeString;
@property (nonatomic, assign) CGFloat type_explainsHeight;



@end


@interface MGResCourseListDetailModel : BaseResModel

@property (nonatomic, strong) MGResCourseListDetailDataModel *data;

@end
