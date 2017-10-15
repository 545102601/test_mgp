//
//  MGResMemberModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"
#define memberDataModelInstance [MGResMemberModel sharedInstance].data

@interface MGResMemberDataModel : BaseModel
/// 会员id
@property (nonatomic, assign) long id;
/// 会员身份标识集合 String []
@property (nonatomic, copy) NSArray *user_identitys;
/// 会员身份标签
@property (nonatomic, copy) NSString *user_identity_label;
/// 头像图片地址
@property (nonatomic, copy) NSString *avatar_rsurl;
/// 会员昵称
@property (nonatomic, copy) NSString *nick_name;
/// 个性签名
@property (nonatomic, copy) NSString *my_signature;
/// 会员真实姓名
@property (nonatomic, copy) NSString *name;
/// 性别（1：男， 0： 女）
@property (nonatomic, assign) NSInteger gender;
/// 性别（男，女）
@property (nonatomic, copy) NSString *gender_label;
/// 会员生日
@property (nonatomic, strong) NSDate *birthday;
/// 院校
@property (nonatomic, copy) NSString *college;
/// 专业
@property (nonatomic, copy) NSString *profession;
/// 入学年份
@property (nonatomic, copy) NSString *enter_school;
/// Qq号
@property (nonatomic, copy) NSString *qq;
/// 微信号
@property (nonatomic, copy) NSString *weixin;
/// 手机号
@property (nonatomic, copy) NSString *mobile;
/// 邮箱
@property (nonatomic, copy) NSString *email;
/// 项目经验
@property (nonatomic, copy) NSString *project_experience;
/// 工作经历
@property (nonatomic, copy) NSString *work_experience;
/// 电子简历地址
@property (nonatomic, copy) NSString *resume_rsurl;
/// 自我评价
@property (nonatomic, copy) NSString *self_evaluation;
/// 个人订单数量
@property (nonatomic, assign) long order_count;
/// 工作包数量
@property (nonatomic, assign) long project_count;
/// 授课数量
@property (nonatomic, assign) long course_count;
/// 收藏数量
@property (nonatomic, assign) long fav_count;
/// 动态数量
@property (nonatomic, assign) long trend_count;
/// 消息数量
@property (nonatomic, assign) long message_count;



/// 附加 -
/// 是否已经有了身份
@property (nonatomic, assign) BOOL hasID;
/// 是否是学生身份
@property (nonatomic, assign) BOOL isStudentID;
/// 是否是老师身份
@property (nonatomic, assign) BOOL isTutorID;
/// 是否是社团身份
@property (nonatomic, assign) BOOL isCommunityID;
/// 是否是企业身份
@property (nonatomic, assign) BOOL isCompanyID;


@end


@interface MGResMemberModel : BaseResModel

@property (nonatomic, strong) MGResMemberDataModel *data;


AS_SINGLETON(MGResMemberModel)

@end


