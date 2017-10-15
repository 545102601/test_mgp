//
//  MGHomeTableView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "YNBaseTableView.h"
#import "TDNavigationBar.h"
#import "MGResSettingModel.h"

/// item == 1000 是 左边  1001 是右边 按钮点击
typedef void(^FunctionDidCellItemBlock)(NSInteger item);

/// 点击广告
typedef void(^AdvertCellDidSelectedBlock)(NSInteger index);

/// 点击公告
typedef void(^BulletinCellDidSelectedBlock)(NSInteger index);
typedef void(^LeftImageTapBlock)(void);

typedef void(^DidCellItem)(MGResSettingDataDetailModel *detailModel);

@interface MGHomeTableView : YNBaseTableView
/// 导航条
@property (nonatomic, weak) TDNavigationBar *navigationBar;
/// 广告
@property (nonatomic, strong) NSArray *adverArray;
/// 公告
@property (nonatomic, strong) NSArray *bulletinArray;
/// 功能
@property (nonatomic, strong) NSArray *functionArray;

@property (nonatomic, strong) NSArray *workAndClassArray;

/// 动态展示
@property (nonatomic, strong) NSArray *ReResults;


/// 点击Block
@property (nonatomic, copy) AdvertCellDidSelectedBlock advertCellDidSelectedBlock;

@property (nonatomic, copy) BulletinCellDidSelectedBlock bulletinCellDidSelectedBlock;

@property (nonatomic, copy) LeftImageTapBlock leftImageTapBlock;

@property (nonatomic, copy) FunctionDidCellItemBlock functionDidCellItemBlock;

@property (nonatomic, copy) DidCellItem didCellItem;

@end
