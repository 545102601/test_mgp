//
//  MGHomeColletionViewCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/28.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BaseCollectionViewCell.h"
#import "MGResSettingModel.h"

typedef void(^DidCellItem)(MGResSettingDataDetailModel *detailModel);

/// collecttion view cell
@interface MGHomeColletionViewCell : BaseCollectionViewCell

@property (nonatomic, copy) NSString *iconUrl;

@end


@interface MGHomeColletionViewTableViewCell : BaseTableViewCell

@property (nonatomic, copy) DidCellItem didCellItem;

@property (nonatomic, strong) MGResSettingDataModel *dataModel;



@end
