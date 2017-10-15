//
//  MGResClassifyModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//  课程分类

#import "BaseModel.h"

@interface MGResClassifyDataModel : BaseModel

@property (nonatomic, assign) long id;
/// 分类展示图标地址
@property (nonatomic, copy) NSString *logo_rsurl;
/// 分类名称
@property (nonatomic, copy) NSString *classify_name;
/// 父类id
@property (nonatomic, assign) long parent_id;
/// 备注
@property (nonatomic, copy) NSString *remark;
/// 是否显示在首页
@property (nonatomic, assign) NSInteger show_top;
/// 状态
@property (nonatomic, assign) NSInteger state;
/// 子分类
@property (nonatomic, copy) NSArray *details;

@end


@interface MGResClassifyModel : BaseResModel

@property (nonatomic, copy) NSArray *data;

@end
