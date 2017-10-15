//
//  MGUploadCollectionViewCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/7.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface MGUploadCollectionViewCell : BaseCollectionViewCell

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger item;

@property (nonatomic, copy) MGCommomEventBlock buttonEventBlock;

@property (nonatomic, assign) BOOL hiddenDeleteButton;

+ (CGFloat)getItemWidth;

@end
