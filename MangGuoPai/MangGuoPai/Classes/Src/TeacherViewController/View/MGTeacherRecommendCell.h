//
//  MGTeacherRecommendCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#define kMGTeacherRecommendCellHeight SH(168)

#import "BaseTableViewCell.h"
#import "MGResCourseListModel.h"


typedef void(^IconImageTapBlock)(MGResCourseListDataModel *model);

@interface MGTeacherRecommendCell : BaseTableViewCell

@property (nonatomic, strong) MGResCourseListDataModel *model;

@property (nonatomic, copy) IconImageTapBlock iconImageTapBlock;

@end
