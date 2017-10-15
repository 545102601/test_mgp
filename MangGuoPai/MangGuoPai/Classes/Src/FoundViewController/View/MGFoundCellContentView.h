//
//  MGFoundCellContentView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/4.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"
#import "MGResTrendListModel.h"

@interface MGFoundCellContentView : BaseView

@property (nonatomic, copy) MGCommomEventBlock showAllContentTextBlock;

@property (nonatomic, copy) MGCommomEventBlock showAllContentTextForwardBlock;
/// 点击转发背景
@property (nonatomic, copy) MGCommomEventBlock forwardBgViewTapBlock;

@property (nonatomic, strong) NSIndexPath *indexPath;
/// 模型
@property (nonatomic, strong) MGResTrendListDataModel *dataModel;

@end
