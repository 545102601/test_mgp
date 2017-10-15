//
//  MGTeacherOrderView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/26.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"
#import "MGResCourseListModel.h"
#import "MGResCourseListDetailModel.h"

@interface MGTeacherOrderView : BaseView

@property (nonatomic, strong) MGResCourseListDataModel *dataModel;

@property (nonatomic, strong) MGResCourseListDetailDataModel *detailDataModel;

@property (nonatomic, copy) MGCommomEventBlock discountBlock;

@property (nonatomic, copy) MGCommomEventBlock orderBlock;

@end
