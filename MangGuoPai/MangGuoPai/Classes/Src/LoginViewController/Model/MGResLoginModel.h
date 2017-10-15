//
//  MGResLoginModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/8.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"


/// 信息模型
@interface MGResLoginMemberModel : BaseModel
/// id
@property (nonatomic, assign) long id;
/// 昵称
@property (nonatomic, copy) NSString *nick_name;
/// 身份标识
@property (nonatomic, copy) NSArray *user_identitys;

@end

@interface MGResLoginDataModel : BaseModel
/// session_id
@property (nonatomic, copy) NSString *lst_sessid;
/// 信息模型
@property (nonatomic, strong) MGResLoginMemberModel *member;


@end


@interface MGResLoginModel : BaseResModel

@property (nonatomic, strong) MGResLoginDataModel *data;

@end


