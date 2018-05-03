//
//  MGHomeFunctionCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BaseCollectionViewCell.h"
/// item == 1000 是 左边  1001 是右边 按钮点击
typedef void(^FunctionDidCellItemBlock)(NSInteger item);


/// colletion view cell
@interface MGHomeFunctionColletionViewCell : BaseCollectionViewCell

@property (nonatomic, assign) long id;

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *iconUrl;

@end


@interface MGHomeFunctionCell : BaseTableViewCell

@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic, copy) NSArray *wordAndArray;


@property (nonatomic, copy) FunctionDidCellItemBlock didCellItemBlock;

@property (nonatomic, copy) MGCommomEventBlock wordAndClassBlock;


@end
