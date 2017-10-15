//
//  MGTeacherAllCategoryTableView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "YNBaseTableView.h"

typedef void(^CategoryDidCellItemBlock)(NSInteger tableSection, NSInteger colletionItem);

@interface MGTeacherAllCategoryTableView : YNBaseTableView

@property (nonatomic, copy) CategoryDidCellItemBlock categoryDidCellItemBlock;

@end
