//
//  MGFoundCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/4.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MGResTrendListModel.h"
#import "MGFoundCellInfoView.h"
#import "MGFoundCellContentView.h"
#import "MGFoundCellToolsView.h"


@interface MGFoundCell : BaseTableViewCell

/// 个人信息
@property (nonatomic, strong) MGFoundCellInfoView *cellInfoView;
/// 内容
@property (nonatomic, strong) MGFoundCellContentView *cellContentView;
/// 工具条
@property (nonatomic, strong) MGFoundCellToolsView *toolsView;

@property (nonatomic, strong) NSIndexPath *indexPath;

/// 全文 block
@property (nonatomic, copy) MGCommomEventBlock showAllContentTextBlock;
/// 转发全文 block
@property (nonatomic, copy) MGCommomEventBlock showAllContentTextForwardBlock;

/// 收藏 block
@property (nonatomic, copy) MGCommomEventBlock favEventBlock;

/// 参数 0: 分享 1:评论 2:点赞
@property (nonatomic, copy) MGCommomEventBlock tapButtonBlock;

/// 数据模型
@property (nonatomic, strong) MGResTrendListDataModel *dataModel;

/// 点击转发背景
@property (nonatomic, copy) MGCommomEventBlock forwardBgViewTapBlock;


@end
