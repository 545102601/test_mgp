//
//  MGAccountCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MGAccountTableModel.h"

@interface MGAccountCell : BaseTableViewCell

@property (nonatomic, assign) BOOL isHiddenBottomLine;

@property (nonatomic, strong) MGAccountTableModel *tableModel;

@end
