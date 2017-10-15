//
//  MGFoundCellToolsView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/4.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"
#import "MGResTrendListModel.h"

@interface MGFoundCellToolsView : BaseView

@property (nonatomic, strong) NSIndexPath *indexPath;

/// 参数 0: 分享 1:评论 2:点赞
@property (nonatomic, copy) MGCommomEventBlock tapButtonBlock;

/// 模型
@property (nonatomic, strong) MGResTrendListDataModel *dataModel;


/// 点赞动画
- (void)setLiked:(BOOL)liked withAnimation:(BOOL)animation;

@end
