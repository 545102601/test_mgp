//
//  MGResWorkListModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/30.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"


@interface MGResWorkListDataModel : BaseModel

@property (nonatomic, assign) long id;
/// 项目名称
@property (nonatomic, copy) NSString *project_name;
/// 形象图地址
@property (nonatomic, copy) NSString *logo_rsurl;
/// 上线时间
@property (nonatomic, strong) NSDate *publish_time;
@property (nonatomic, copy) NSString *publish_time_str;

/// 报名截止时间
@property (nonatomic, strong) NSDate *apply_abort_time;
@property (nonatomic, copy) NSString *apply_abort_time_str;
/// 作品截止时间
@property (nonatomic, strong) NSDate *works_abort_time;
@property (nonatomic, copy) NSString *works_abort_time_str;
/// 评审结束时间
@property (nonatomic, strong) NSDate *appraise_abort_time;
@property (nonatomic, copy) NSString *appraise_abort_time_str;

/// 成功报名人数
@property (nonatomic, assign) NSInteger reach_apply_count;
/// 已报名人数
@property (nonatomic, assign) NSInteger applied_count;

/// 已关注人数
@property (nonatomic, assign) NSInteger focus_count;
/// 想参与人数
@property (nonatomic, assign) NSInteger want_count;

/// Banner图地址
@property (nonatomic, copy) NSString *banner_rsurls;
/// 项目介绍
@property (nonatomic, copy) NSString *introduction;

/// 活动地点
@property (nonatomic, copy) NSString *location;

/// 奖金奖品
@property (nonatomic, copy) NSString *prizes_content;

/// 参赛说明
@property (nonatomic, copy) NSString *entry_instructions;

/// 评价标准
@property (nonatomic, copy) NSString *evaluation_standard;

/// 报名人数上限
@property (nonatomic, assign) NSInteger apply_max_limit;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, copy) NSString *state_label;
/// 进度，根据时间计算，最大值100
@property (nonatomic, assign) NSInteger progress;


// -- 当前会员作为参与者信息
/// 参与者Id          - 查询工作包详情中的作品详情 使用
@property (nonatomic, assign) long actor_id;
/// 参与者昵称
@property (nonatomic, copy) NSString *actor_name;
/// 参与者对应的会员ID  - 查询团队详情资料  使用
@property (nonatomic, assign) NSInteger actor_member_id;

//参与者类型
//Member:会员
//Team:团队
@property (nonatomic, copy) NSString *actor_member_type;

/// 参与时间
@property (nonatomic, strong) NSDate *member_join_time;
@property (nonatomic, copy) NSString *member_join_time_str;


@end


@interface MGResWorkListModel : BaseResModel

@property (nonatomic, copy) NSArray *data;


@end
