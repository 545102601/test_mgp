//
//  MGWorkProductCommentCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/16.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MGResProjectActorModel.h"

@interface MGWorkProductCommentCell : BaseTableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) MGResProjectActorDataModel *actorModel;

@property (nonatomic, copy) MGCommomEventBlock lookOtherFileButtonBlock;

@end
