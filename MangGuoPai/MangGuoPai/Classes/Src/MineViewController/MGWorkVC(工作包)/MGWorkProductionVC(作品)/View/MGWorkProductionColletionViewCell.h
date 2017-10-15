//
//  MGWorkProductionColletionViewCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/14.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface MGWorkProductionColletionViewCell : BaseCollectionViewCell

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger item;

@property (nonatomic, copy) MGCommomEventBlock buttonEventBlock;

+ (CGFloat)getItemWidth;

@end
