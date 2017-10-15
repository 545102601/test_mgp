//
//  MGTeacherClassDetailVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/26.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MGResCourseListModel.h"

@interface MGTeacherClassDetailVC : BaseViewController

/// 传递id
@property (nonatomic, assign) long id;
/// 传递模型
@property (nonatomic, strong) MGResCourseListDataModel *dataModel;

@end
