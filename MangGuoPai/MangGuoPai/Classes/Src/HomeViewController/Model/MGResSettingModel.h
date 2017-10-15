//
//  MGResSettingModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"

@interface MGResSettingDataDetailModel : BaseModel

@property (nonatomic, assign) long id;
/// 图像地址
@property (nonatomic, copy) NSString *file_path;
//绑定类型：
//超链接：0
//课程：8
//工作包：7
@property (nonatomic, assign) NSInteger bind_type;

//首页设置	1
//会员	4
//订单	5
//工作包	6
//动态	7
//课程	8
//课程分类	9
@property (nonatomic, assign) NSInteger entity_type_id;
/// 对象ID
@property (nonatomic, assign) NSInteger entity_id;
/// 对象名称
@property (nonatomic, copy) NSString *entity_name;
/// 超链接
@property (nonatomic, copy) NSString *click_url;
/// 描述
@property (nonatomic, copy) NSString *mg_description;
@end


@interface MGResSettingDataModel : BaseModel

@property (nonatomic, assign) long id;
/// 标题
@property (nonatomic, copy) NSString *title;
//广告模式
//单图模式：1
//多图模式：2
//多图模式 竖屏：3
//海报模式：0
@property (nonatomic, copy) NSString *type;
/// 简介
@property (nonatomic, copy) NSString *intro;
/// 形象图地址
@property (nonatomic, copy) NSString *logoRsurl;
/// 状态
@property (nonatomic, assign) NSInteger state;
/// 状态标签
@property (nonatomic, copy) NSString *state_label;
/// 发布时间
@property (nonatomic, copy) NSDate *publishTime;
/// 广告位
@property (nonatomic, copy) NSString *position;
/// 广告内容
@property (nonatomic, copy) NSArray *details;

@end


@interface MGResSettingModel : BaseResModel

@property (nonatomic, strong) NSArray *data;

@end
