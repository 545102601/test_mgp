//
//  MGTeacherCategoryBaseDetailTableView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/23.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "YNBaseTableView.h"
#import "MGResCourseListModel.h"

typedef void(^IconImageTapBlock)(MGResCourseListDataModel *model);

@interface MGTeacherCategoryBaseDetailTableView : YNBaseTableView

/// 头像点击block
@property (nonatomic, copy) IconImageTapBlock iconImageTapBlock;

@end
