//
//  MGWorkApplyJoinGroupViewCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#define kMGWorkApplyJoinGroupViewCellHeight SH(362)

#import "BaseTableViewCell.h"
#import "MGResProjectListTeamModel.h"

@interface MGWorkApplyJoinGroupViewCell : BaseTableViewCell

@property (nonatomic, copy) MGCommomEventBlock joinBlock;

@property (nonatomic, strong) MGResProjectListTeamDataModel *dataModel;

@end
