//
//  MGResProjectListTeamModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"


@interface MGResProjectListTeamDataModel : BaseModel

@property (nonatomic, assign) long id;
/// 团队昵称
@property (nonatomic, copy) NSString *team_name;
/// 公告
@property (nonatomic, copy) NSString *bulletin;
/// 成员数量
@property (nonatomic, assign) NSInteger member_count;
/// 发起人昵称
@property (nonatomic, copy) NSString *actor_name;

/// 角色
@property (nonatomic, copy) NSString *role_name;

//参与状态
//1 ： 报名
//2 ： 提交作品
//50: ： 评审完成
@property (nonatomic, assign) NSInteger actor_state;

/// 状态标签
@property (nonatomic, copy) NSString *actor_state_label;

/// 头像
@property (nonatomic, copy) NSString *avatar_rsurl;

@end

@interface MGResProjectListTeamModel : BaseResModel

@property (nonatomic, copy) NSArray *data;

@end
