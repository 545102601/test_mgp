//
//  MGTeacherAllCategoryCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MGResClassifyModel.h"
#import "BaseCollectionViewCell.h"

typedef void(^CategoryDidCellItemBlock)(NSInteger tableSection, NSInteger colletionItem);

@interface MGTeacherAllCategoryColletionViewCell : BaseCollectionViewCell

@property (nonatomic, copy) NSString *name;

@end


@interface MGTeacherAllCategoryCell : BaseTableViewCell

@property (nonatomic, strong) NSIndexPath *tableIndexPath;

@property (nonatomic, strong) MGResClassifyDataModel *dataModel;

@property (nonatomic, copy) CategoryDidCellItemBlock categoryDidCellItemBlock;

@end
