//
//  MGTeacherOrderVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/26.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MGResCourseListModel.h"
#import "MGResCourseListDetailModel.h"

@interface MGTeacherOrderVC : BaseViewController

@property (nonatomic, strong) MGResCourseListDataModel *dataModel;

@property (nonatomic, strong) MGResCourseListDetailDataModel *detailDataModel;

@end
