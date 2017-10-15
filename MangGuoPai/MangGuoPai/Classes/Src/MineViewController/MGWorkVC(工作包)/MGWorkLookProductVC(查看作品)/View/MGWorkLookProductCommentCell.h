//
//  MGWorkLookProductCommentCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/15.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MGResProjectActorModel.h"

@interface MGWorkLookProductCommentCell : BaseTableViewCell

@property (nonatomic, strong) MGResProjectActorDataModel *actorDataModel;

@property (nonatomic, copy) MGCommomEventBlock looOtherFileButtonBlock;

@end
