//
//  MGResProjectDetailModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"
#import "MGResCourseListModel.h"
#import "MGResProjectActorModel.h"

@interface MGResProjectDetailDataModel : BaseResModel

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
/// 已经报名人数
@property (nonatomic, assign) NSInteger applied_count;
/// 已关注人数
@property (nonatomic, assign) NSInteger focus_count;
/// 想参与人数
@property (nonatomic, assign) NSInteger want_count;
/// Banner图地址
@property (nonatomic, copy) NSString *banner_rsurls;
/// 项目介绍
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, copy) NSAttributedString *introductionAttr;
@property (nonatomic, assign) CGFloat introductionHeight;

/// 地点
@property (nonatomic, copy) NSString *location;
/// 奖金奖品
@property (nonatomic, copy) NSString *prizes_content;
@property (nonatomic, copy) NSAttributedString *prizesContentAttr;
@property (nonatomic, assign) CGFloat prizesContentHeight;
@property (nonatomic, assign) CGFloat prizesCellHeight;
@property (nonatomic, assign) BOOL prizesIsExpend;


/// 参赛说明
@property (nonatomic, copy) NSString *entry_instructions;
@property (nonatomic, copy) NSAttributedString *entryContentAttr;
@property (nonatomic, assign) CGFloat entryContentHeight;
@property (nonatomic, assign) CGFloat entryCellHeight;
@property (nonatomic, assign) BOOL entryIsExpend;




/// 评价标准
@property (nonatomic, copy) NSString *evaluation_standard;
/// 报名人数上限
@property (nonatomic, assign) NSInteger apply_max_limit;
/// 状态
@property (nonatomic, assign) MGGlobaState state;
/// 状态标签
@property (nonatomic, strong) NSString *state_label;

/// 进度，根据时间计算，最大值100
@property (nonatomic, assign) NSInteger progress;


/// 当前会员作为参与者的信息
/// 参与者id
@property (nonatomic, assign) NSInteger actor_id;
/// 参与者名字
@property (nonatomic, copy) NSString *actor_name;
/// 参与者对应的会员ID
@property (nonatomic, assign) NSInteger actor_member_id;
//参与者类型
//Member:会员
//Team:团队
@property (nonatomic, copy) NSString *actor_member_type;

/// 参与时间
@property (nonatomic, strong) NSDate *member_join_time;
@property (nonatomic, copy) NSString *member_join_time_str;

/// 是否有收藏
@property (nonatomic, assign) BOOL is_favor;

/// 所有参与者信息
@property (nonatomic, strong) NSArray *actors;

/// 课程推荐
@property (nonatomic, strong) NSArray *courses;


//////////////////////////////////// 附加
@property (nonatomic, assign) BOOL hiddenExpendButton;


@end

@interface MGResProjectDetailModel : BaseResModel

@property (nonatomic, strong) MGResProjectDetailDataModel *data;

@end
