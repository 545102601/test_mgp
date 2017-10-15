//
//  MGResTrendListModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/4.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"

@interface MGResFoundDetailCommentDataModel : BaseModel

@property (nonatomic, assign) long id;
/// 用户名
@property (nonatomic, copy) NSString *member_name;
/// 评论时间
@property (nonatomic, strong) NSDate *comment_time;
@property (nonatomic, copy) NSString *comment_time_str;

/// 评论内容
@property (nonatomic, copy) NSString *content;
/// 评论回复
@property (nonatomic, copy) NSString *reply;
/// 发布者头像
@property (nonatomic, copy) NSString *avatar_rsurl;
/// 发布时间描述
@property (nonatomic, copy) NSString *publish_time_label;

@end

@interface MGResTrendListDataModel : BaseModel

@property (nonatomic, assign) long id;
/// 发布者id
@property (nonatomic, assign) long publisher_id;
/// 发布者手机
@property (nonatomic, copy) NSString *publisher_mobile;
/// 发布者昵称
@property (nonatomic, copy) NSString *publisher_name;
/// 发布内容
@property (nonatomic, copy) NSString *content;
/// 发布图片
@property (nonatomic, copy) NSArray *pic_rsurls;
/// 发布时间
@property (nonatomic, strong) NSDate *publish_time;

/// 发布时间 - 附加字段
@property (nonatomic, copy) NSString *publish_time_str;

/// 发布时间描述
@property (nonatomic, copy) NSString *publish_time_labe;
/// 发布者头像
@property (nonatomic, copy) NSString *avatar_rsurl;
/// 城市
@property (nonatomic, copy) NSString *city;
/// 评论数
@property (nonatomic, assign) NSInteger comment_count;
/// 打赏数
@property (nonatomic, assign) NSInteger reward_count;
/// 想看数
@property (nonatomic, assign) NSInteger want_count;
/// 点赞数
@property (nonatomic, assign) NSInteger praise_count;
/// 转发数
@property (nonatomic, assign) NSInteger faword_count;

/// 评论数
@property (nonatomic, copy) NSArray *comments;

/// 是否显示  全文 附加
@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;

@property (nonatomic, assign) BOOL isOpening;
/// 是否是自己发布的动态
@property (nonatomic, assign) BOOL isSelfTrend;

/// 转发
@property (nonatomic, strong) MGResTrendListDataModel *forward_trend;


@end

/// 列表
@interface MGResTrendListModel : BaseResModel

@property (nonatomic, copy) NSArray *data;

@end

/// 详情
@interface MGResTrendDetailModel : BaseResModel

@property (nonatomic, strong) MGResTrendListDataModel *data;

@end
