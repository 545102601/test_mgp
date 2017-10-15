//
//  MGResCommunityClassicListModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/2.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"

@interface MGResCommunityClassicListDataModel : BaseModel

@property (nonatomic, assign) long id;

@property (nonatomic, copy) NSString *classic_name;

@end

@interface MGResCommunityClassicListModel : BaseResModel

@property (nonatomic, copy) NSArray *data;

@end
