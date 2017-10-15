//
//  MGResContentModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//  内容

#import "BaseModel.h"
/// data 内容
@interface MGResContentDataModel : BaseModel

@property (nonatomic, assign) long id;
/// 标题
@property (nonatomic, copy) NSString *title;
/// 简介
@property (nonatomic, copy) NSString *intro;
/// 形象图地址
@property (nonatomic, copy) NSString *logoRsurl;
/// 内容
@property (nonatomic, copy) NSString *content;
/// 状态
@property (nonatomic, assign) NSInteger state;
/// 状态标签
@property (nonatomic, copy) NSString *state_label;
/// 发布时间
@property (nonatomic, strong) NSDate *publishTime;

@end

/// 列表
@interface MGResContentModel : BaseResModel

@property (nonatomic, copy) NSArray *data;

@end




/// 详情
@interface MGResContentDetailModel : BaseResModel

@property (nonatomic, strong) MGResContentDataModel *data;

@end
