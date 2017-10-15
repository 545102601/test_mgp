//
//  MGTeacherFunctionCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BaseCollectionViewCell.h"
#import "MGResClassifyModel.h"
/// item == 1000 是 全部 按钮点击
typedef void(^FunctionDidCellItemBlock)(NSInteger item);
/// colletion view cell
@interface MGTeacherFunctionColletionViewCell : BaseCollectionViewCell

@property (nonatomic, strong) MGResClassifyDataModel *model;

@end


@interface MGTeacherFunctionCell : BaseTableViewCell

@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic, copy) FunctionDidCellItemBlock didCellItemBlock;

@end
