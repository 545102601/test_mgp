//
//  MGWorkDetailApplyTeamCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/14.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MGResProjectDetailModel.h"

#define kMGWorkDetailApplyTeamCellHeight SH(110)

@interface MGWorkDetailApplyTeamCell : BaseTableViewCell

@property (nonatomic, copy) MGCommomEventBlock applyTeamCommentBlock;

@property (nonatomic, copy) MGCommomEventBlock applyTeamProductBlock;

@property (nonatomic, strong) MGResProjectActorDataModel *actorModel;

@end
