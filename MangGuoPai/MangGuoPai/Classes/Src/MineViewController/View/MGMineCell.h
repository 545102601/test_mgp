//
//  MGMineCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/17.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MGMineTableViewModel.h"

@interface MGMineCell : BaseTableViewCell

@property (nonatomic, assign) BOOL hiddenLine;

@property (nonatomic, strong) MGMineTableViewModel *model;

@end
