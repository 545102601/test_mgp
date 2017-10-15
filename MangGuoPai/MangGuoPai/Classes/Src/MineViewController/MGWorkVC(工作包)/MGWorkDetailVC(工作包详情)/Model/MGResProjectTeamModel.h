//
//  MGResProjectTeamModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/2.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"

@interface MGResProjectTeamMemberDataModel : BaseModel

@property (nonatomic, assign) long team_id;
/// 会员Id
@property (nonatomic, assign) long member_id;
/// 会员昵称
@property (nonatomic, copy) NSString *nick_name;
/// 成员角色
@property (nonatomic, copy) NSString *role_name;
/// 头像
@property (nonatomic, copy) NSString *avatar_rsurl;

@end


@interface MGResProjectTeamDataModel : BaseModel

@property (nonatomic, assign) long Id;
/// 团队昵称
@property (nonatomic, copy) NSString *team_name;
/// 公告
@property (nonatomic, copy) NSString *bulletin;
/// 成员数量
@property (nonatomic, assign) NSInteger member_count;
/// 发起人昵称
@property (nonatomic, copy) NSString *actor_name;
/// 集结号
@property (nonatomic, copy) NSString *cipher;
/// 成员
@property (nonatomic, copy) NSArray *members;

@end

@interface MGResProjectTeamModel : BaseResModel

@property (nonatomic, strong) MGResProjectTeamDataModel *data;

@end
