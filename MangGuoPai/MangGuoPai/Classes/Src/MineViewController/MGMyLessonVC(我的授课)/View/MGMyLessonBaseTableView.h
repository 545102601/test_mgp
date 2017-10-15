//
//  MGMyLessonBaseTableView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/1.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "YNBaseTableView.h"

@interface MGMyLessonBaseTableView : YNBaseTableView

@property (nonatomic, assign) NSInteger viewControllerType;

/// 1002 是上架 1003 是下架 1004 是删除
@property (nonatomic, copy) MGCommomEventBlock buttonEventBlock;

@end
