//
//  MGTeacherDetailHeaderView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"
#import "MGResCourseTutorModel.h"

@interface MGTeacherDetailHeaderView : BaseView

@property (nonatomic, strong) MGResCourseTutorDataModel *dataModel;

@property (nonatomic, assign) CGFloat headerHeight;

- (void)setWantCount:(NSInteger)wantCount;

@end
