//
//  MGHomePosterCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MGResSettingModel.h"

typedef void(^DidCellItem)(MGResSettingDataDetailModel *detailModel);

@interface MGHomePosterCell : BaseTableViewCell

@property (nonatomic, strong) MGResSettingDataModel *dataModel;

@property (nonatomic, copy) DidCellItem didCellItem;

@end
