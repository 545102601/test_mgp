//
//  MGFoundDetailCommentCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/3.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MGResTrendListModel.h"

@interface MGFoundDetailCommentCell : BaseTableViewCell

@property (nonatomic, copy) MGCommomEventBlock replyCommentBlock;

@property (nonatomic, assign) BOOL isSelfTrend;

@property (nonatomic, assign) BOOL showTopLine;

@property (nonatomic, assign) BOOL showBottomLine;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) MGResFoundDetailCommentDataModel *dataModel;

@end
