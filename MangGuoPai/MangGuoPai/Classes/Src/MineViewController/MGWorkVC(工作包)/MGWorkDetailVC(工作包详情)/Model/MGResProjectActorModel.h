//
//  MGResProjectActorModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/2.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"
#import "MGResProjectTeamModel.h"

@interface MGResProjectActorDataModel : BaseModel

@property (nonatomic, assign) long id;

/// 工作包昵称
@property (nonatomic, copy) NSString *project_name;
/// 工作包id
@property (nonatomic, assign) long project_id;

//参与者类型
//member: 会员
//team : 团队
@property (nonatomic, copy) NSString *actor_type;
/// 参与者名称
@property (nonatomic, copy) NSString *actor_name;
/// 参与者ID
@property (nonatomic, assign) NSInteger actor_id;

/// 成员数
@property (nonatomic, assign) NSInteger member_count;

/// 投票数
@property (nonatomic, assign) NSInteger vote_count;
/// 导师评分
@property (nonatomic, assign) NSInteger tutor_score;
/// 企业评分
@property (nonatomic, assign) NSInteger company_score;
/// 综合得分
@property (nonatomic, assign) NSInteger integrated_score;
/// 综合排名
@property (nonatomic, assign) NSInteger integrated_ranking;
/// 奖项
@property (nonatomic, copy) NSString *awards;
/// 导师点评
@property (nonatomic, copy) NSString *tutor_comments;
/// 导师点评 - 附加
@property (nonatomic, copy) NSAttributedString *tutor_comments_attr;
/// 导师点评 - 附加
@property (nonatomic, assign) CGFloat tutor_comments_height;
/// 企业点评
@property (nonatomic, copy) NSString *company_comments;
/// 企业点评 - 附加
@property (nonatomic, copy) NSAttributedString *company_comments_attr;
/// 企业点评 - 附加
@property (nonatomic, assign) CGFloat company_comments_height;
/// 作品照片地址
@property (nonatomic, copy) NSArray *works_phote_rsurls;
/// 方案文档地址
@property (nonatomic, copy) NSArray *scheme_doc_rsurls;
/// 团队照片地址
@property (nonatomic, copy) NSArray *team_photo_rsurls;

@property (nonatomic, assign) NSInteger state;
/// 状态标签
@property (nonatomic, copy) NSString *state_label;

@property (nonatomic, strong) MGResProjectTeamDataModel *team;

@end

@interface MGResProjectActorModel : BaseResModel

@property (nonatomic, strong) MGResProjectActorDataModel *data;

@end
