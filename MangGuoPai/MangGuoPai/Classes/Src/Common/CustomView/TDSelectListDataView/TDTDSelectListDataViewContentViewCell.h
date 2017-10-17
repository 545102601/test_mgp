//
//  TDTDSelectListDataViewContentViewCell.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/7/6.
//  Copyright © 2017年 梦创. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "TDSelectListDataViewContentModel.h"

@interface TDTDSelectListDataViewContentViewCell : BaseTableViewCell
/// 模型
@property (nonatomic, strong) TDSelectListDataViewContentModel *model;

/// 底部线条
@property (nonatomic, assign) BOOL hiddenBottomLine;

@end
