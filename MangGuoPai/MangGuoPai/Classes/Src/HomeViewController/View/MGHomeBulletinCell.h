//
//  MGHomeBulletinCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"

typedef void(^BulletinCellDidSelectedBlock)(NSInteger index);
typedef void(^LeftImageTapBlock)(void);

@interface MGHomeBulletinCell : BaseTableViewCell
/// 数据源
@property (nonatomic, copy) NSArray *dataArray;
/// 点击文字
@property (nonatomic, copy) BulletinCellDidSelectedBlock bulletinCellDidSelectedBlock;
/// 点击图片
@property (nonatomic, copy) LeftImageTapBlock leftImageTapBlock;

@end
