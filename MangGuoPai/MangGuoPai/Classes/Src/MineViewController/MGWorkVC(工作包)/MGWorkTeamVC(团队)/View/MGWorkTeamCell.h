//
//  MGWorkTeamCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/13.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#define kMGWorkTeamCellHeight SH(124)

#import "BaseTableViewCell.h"
#import "MGResProjectTeamModel.h"

@interface MGWorkTeamCell : BaseTableViewCell

@property (nonatomic, strong) MGResProjectTeamMemberDataModel *dataModel;

@end
