//
//  MGFoundCellForwardView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/3.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"
#import "MGResTrendListModel.h"


@interface MGFoundCellForwardView : BaseView

@property (nonatomic, copy) MGCommomEventBlock forwardBgViewTapBlock;

@property (nonatomic, copy) MGCommomEventBlock showAllContentTextForwardBlock;

@property (nonatomic, strong) NSIndexPath *indexPath;

/// 转发模型
@property (nonatomic, strong) MGResTrendListDataModel *dataModel;

@end
