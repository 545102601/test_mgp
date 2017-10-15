//
//  MGTeacherAdvertCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"

typedef void(^AdvertCellDidSelectedBlock)(NSInteger index);

@interface MGTeacherAdvertCell : BaseTableViewCell

/// 数据源
@property (nonatomic, copy) NSArray *dataArray;
/// 点击回调
@property (nonatomic, copy) AdvertCellDidSelectedBlock advertCellDidSelectedBlock;

@end
