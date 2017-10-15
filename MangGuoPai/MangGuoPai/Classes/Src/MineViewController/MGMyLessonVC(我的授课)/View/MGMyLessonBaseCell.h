//
//  MGMyLessonBaseCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/1.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MGResCourseListModel.h"

@interface MGMyLessonBaseCell : BaseTableViewCell

@property (nonatomic, strong) MGResCourseListDataModel *dataModel;
/// 1002 上架 1003 是下架 1004 是删除
@property (nonatomic, copy) MGCommomEventBlock buttonEventBlock;

@end
