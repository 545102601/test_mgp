//
//  MGResCourseListModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/17.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"
/// 导师课程 列表 数据
@interface MGResCourseListDataModel : BaseModel

@property (nonatomic, assign) long id;
/// 课程标题
@property (nonatomic, copy) NSString *course_title;
/// 形象图地址
@property (nonatomic, copy) NSString *tutor_logo_rsurl;
/// 城市
@property (nonatomic, copy) NSString *city;
/// 课程内容
@property (nonatomic, copy) NSString *course_content;
/// 服务次数
@property (nonatomic, copy) NSString *service_time;
/// 每次服务时长
@property (nonatomic, copy) NSString *each_time;
/// 状态
@property (nonatomic, assign) MGGlobaState state;
/// 状态标签
@property (nonatomic, copy) NSString *state_label;
/// 审核状态
@property (nonatomic, assign) NSInteger approve_state;
/// 审核状态标签
@property (nonatomic, copy) NSString *approve_state_label;
/// 表示多少人想看
@property (nonatomic, assign) NSInteger want_count;
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
/// 导师职业
@property (nonatomic, copy) NSString *tutor_jobs;
/// 热门程度（1：焦点， 2：推荐）
@property (nonatomic, copy) NSString *hot_types;

/// 附加： 优惠码说明
@property (nonatomic, copy) NSString *servicesCode;
/// 附加
@property (nonatomic, assign) BOOL isSelected;


@end


@interface MGResCourseListModel : BaseResModel

@property (nonatomic, copy) NSArray *data;

@end
