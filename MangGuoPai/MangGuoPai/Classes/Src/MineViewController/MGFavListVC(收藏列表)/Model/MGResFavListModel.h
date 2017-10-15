//
//  MGResFavListModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"

@interface MGResFavListDataModel : BaseResModel

@property (nonatomic, assign) long id;
/// 收藏对象id
@property (nonatomic, assign) long entity_id;
/// 收藏对象entity_type_id
@property (nonatomic, assign) MGGlobalEntityType entity_type_id;
/// 收藏对象昵称
@property (nonatomic, copy) NSString *entity_name;
/// 收藏的图形地址
@property (nonatomic, copy) NSString *logo_rsurl;

@end

@interface MGResFavListModel : BaseResModel

@property (nonatomic, copy) NSArray *data;

@end
