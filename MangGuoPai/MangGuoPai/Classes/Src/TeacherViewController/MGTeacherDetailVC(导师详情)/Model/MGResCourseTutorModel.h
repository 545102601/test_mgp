//
//  MGResCourseTutorModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"

/// 导师详情模型
@interface MGResCourseTutorDataModel : BaseModel

@property (nonatomic, assign) long id;
/// 导师头图地址
@property (nonatomic, copy) NSString *avatar_rsurl;
/// 导师形象地址
@property (nonatomic, copy) NSString *logo_rsurl;
/// 导师名称
@property (nonatomic, copy) NSString *name;
/// 导师职业
@property (nonatomic, copy) NSString *tutor_jobs;
/// 导师简介
@property (nonatomic, copy) NSString *intro;
/// 导师所在城市
@property (nonatomic, copy) NSString *city;
/// 多少人想听
@property (nonatomic, assign) long want_count;
/// 多少人已经听过
@property (nonatomic, assign) long wanted_count;
/// 是否已经收藏
@property (nonatomic, assign) NSInteger is_favor;
/// 导师下面的所有课程
@property (nonatomic, copy) NSArray *courses;

/// 附加 字段
@property (nonatomic, copy) NSAttributedString *introAttributeString;
/// 附加 字段
@property (nonatomic, assign) CGFloat introHeight;

@end

@interface MGResCourseTutorModel : BaseResModel

@property (nonatomic, strong)  MGResCourseTutorDataModel *data;

@end
