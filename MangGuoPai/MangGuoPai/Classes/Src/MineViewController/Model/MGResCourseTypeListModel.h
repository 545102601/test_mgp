//
//  MGResCourseTypeListModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/4.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"

@interface MGResCourseTypeListDataModel : BaseModel

@property (nonatomic, assign) long id;
/// 课程类型
@property (nonatomic, copy) NSString *type;
/// 授课方式
@property (nonatomic, copy) NSString *method;
/// 特别说明
@property (nonatomic, copy) NSString *explains;
/// 市场价格
@property (nonatomic, assign) double market_price;
/// 销售价格
@property (nonatomic, assign) double sale_price;


@end

@interface MGResCourseTypeListModel : BaseResModel

@property (nonatomic, copy) NSArray *data;

@end
