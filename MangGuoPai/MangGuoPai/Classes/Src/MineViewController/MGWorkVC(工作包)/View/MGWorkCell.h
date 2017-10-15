//
//  MGWorkCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/30.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#define kMGWorkCellHeight SH(410)

#import "BaseTableViewCell.h"
#import "MGResWorkListModel.h"

@interface MGWorkCell : BaseTableViewCell

@property (nonatomic, strong) MGResWorkListDataModel *dataModel;

/// tag  1000 是 邀请 ， 1003 是详情  1002 是团队  1001 是 作品按钮
@property (nonatomic, copy) MGCommomEventBlock buttonEventBlock;

@end
