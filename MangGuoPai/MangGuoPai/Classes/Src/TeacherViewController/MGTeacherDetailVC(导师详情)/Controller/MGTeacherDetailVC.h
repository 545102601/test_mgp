//
//  MGTeacherDetailVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MGResCourseListModel.h"
/// 导师详情
@interface MGTeacherDetailVC : BaseViewController

@property (nonatomic, assign) long id;

@property (nonatomic, strong) MGResCourseListDataModel *model;

@end
