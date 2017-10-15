//
//  MGResEntityModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"


@interface MGResEntityDataModel : BaseModel

/// 收藏的对象ID
@property (nonatomic, assign) long id;
/// 收藏的对象类型ID
@property (nonatomic, assign) MGGlobalEntityType entity_type_id;
/// 对象名称
@property (nonatomic, copy) NSString *entity_name;
/// 对象形象图地址
@property (nonatomic, copy) NSString *logo_rsurl;

/// 标题
@property (nonatomic, copy) NSString *title;
/// 简介
@property (nonatomic, copy) NSString *intro;

@end


@interface MGResEntityModel : BaseResModel

@property (nonatomic, copy) NSArray *data;

@end
