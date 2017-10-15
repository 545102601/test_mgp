//
//  BaseTableViewCell.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

/// 初始化UI
- (void)preapreCellUI;
/// 布局UI
- (void)preapreCellFrame;

@end

@interface UITableView (identifierCell)

/// 不需要 indexPath
- (BaseTableViewCell *)cellWithCellClass:(Class)cellClass;

- (BaseTableViewCell *)cellForIndexPath:(NSIndexPath *)indexPath cellClass:(Class)cellClass;

@end

