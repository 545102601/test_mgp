//
//  MGTeacherTableView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/17.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "YNBaseTableView.h"
#import "MGResCourseListModel.h"

typedef void(^IconImageTapBlock)(MGResCourseListDataModel *model);
/// 点击广告
typedef void(^AdvertCellDidSelectedBlock)(NSInteger index);

/// item == 最后一个 是全部 或者 id == -1000 是全部
typedef void(^FunctionDidCellItemBlock)(NSInteger item);

@interface MGTeacherTableView : YNBaseTableView

@property (nonatomic, strong) NSArray *adverArray;

@property (nonatomic, strong) NSArray *functionArray;

@property (nonatomic, strong) NSArray *recommendArray;


/// 点击Block
@property (nonatomic, copy) AdvertCellDidSelectedBlock advertCellDidSelectedBlock;

@property (nonatomic, copy) FunctionDidCellItemBlock functionDidCellItemBlock;
/// 头像点击block
@property (nonatomic, copy) IconImageTapBlock iconImageTapBlock;

@end
