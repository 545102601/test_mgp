//
//  MGTeacherDetailFooterView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"
#import "MGResCourseTutorModel.h"

@interface MGTeacherDetailFooterView : BaseView

@property (nonatomic, copy) MGCommomEventBlock wantBlock;

@property (nonatomic, copy) MGCommomEventBlock atOneceWantBlock;

@property (nonatomic, strong) MGResCourseTutorDataModel *dataModel;

//- (void)setWantButton:(BOOL)isWant;

@end
