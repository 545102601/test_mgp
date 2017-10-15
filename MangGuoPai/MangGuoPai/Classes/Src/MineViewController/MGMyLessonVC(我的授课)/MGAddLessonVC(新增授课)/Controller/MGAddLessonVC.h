//
//  MGAddLessonVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/1.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MGResCourseListDetailModel.h"

typedef NS_ENUM(NSInteger, MGAddLessonType) {
    MGAddLessonTypeAdd = 0,
    MGAddLessonTypeUpdate = 1,
};

@interface MGAddLessonVC : BaseViewController
/// 默认是新建
@property (nonatomic, assign) MGAddLessonType lessonType;
/// 数据源模型
@property (nonatomic, strong) MGResCourseListDetailDataModel *dataModel;

@end
