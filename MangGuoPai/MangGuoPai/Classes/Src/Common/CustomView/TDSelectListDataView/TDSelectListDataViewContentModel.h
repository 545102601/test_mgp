//
//  TDSelectListDataViewContentModel.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/7/7.
//  Copyright © 2017年 梦创. All rights reserved.
//

#import "BaseLogModel.h"

@interface TDSelectListDataViewContentModel : BaseLogModel

@property (nonatomic, assign) long id;
/// 名称
@property (nonatomic, strong) NSString *name;
/// 是否选中
@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) NSInteger score;

@end
