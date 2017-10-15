//
//  MGSchedulePeopleModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"

@interface MGSchedulePeopleModel : BaseModel

@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) NSInteger people;

@property (nonatomic, assign) BOOL isSelected;

@end
