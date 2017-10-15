//
//  MGWorkDetailCommentCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/30.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MGResProjectDetailModel.h"
#import "MGResProjectActorModel.h"

@interface MGWorkDetailCommentCell : BaseTableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) MGCommomEventBlock expendButtonBlock;

@property (nonatomic, strong) MGResProjectActorDataModel *dataModel;

@end
