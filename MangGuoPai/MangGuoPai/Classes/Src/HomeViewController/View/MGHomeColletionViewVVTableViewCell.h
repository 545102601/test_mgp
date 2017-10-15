//
//  MGHomeColletionViewVVTableViewCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/1.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BaseCollectionViewCell.h"
#import "MGResSettingModel.h"

typedef void(^DidCellItem)(MGResSettingDataDetailModel *detailModel);

/// collecttion view cell
@interface MGHomeColletionVVViewCell : BaseCollectionViewCell

@property (nonatomic, copy) NSString *iconUrl;

@end


@interface MGHomeColletionViewVVTableViewCell : BaseTableViewCell

@property (nonatomic, copy) DidCellItem didCellItem;

@property (nonatomic, strong) MGResSettingDataModel *dataModel;



@end
