//
//  MGFoundTableView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/4.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "YNBaseTableView.h"
#import "MGFoundCell.h"

@interface MGFoundTableView : YNBaseTableView

@property (nonatomic, copy) MGCommomEventBlock showAllContentTextBlock;

@property (nonatomic, copy) MGCommomEventBlock showAllContentTextForwardBlock;

/// 收藏 block
@property (nonatomic, copy) MGCommomEventBlock favEventBlock;

/// 参数 0: 分享 1:评论 2:点赞
@property (nonatomic, copy) MGCommomEventBlock tapButtonBlock;

/// 点击转发背景
@property (nonatomic, copy) MGCommomEventBlock forwardBgViewTapBlock;

@end
