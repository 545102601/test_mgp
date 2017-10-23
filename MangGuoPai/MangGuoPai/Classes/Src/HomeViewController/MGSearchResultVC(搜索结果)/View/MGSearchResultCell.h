//
//  MGSearchResultCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/28.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#define kMGSearchResultCellHeight SH(180)

#import "BaseTableViewCell.h"
#import "MGResEntityModel.h"

@interface MGSearchResultCell : BaseTableViewCell

@property (nonatomic, copy) NSString *searchText;

@property (nonatomic, strong) MGResEntityDataModel *dataModel;

@end
