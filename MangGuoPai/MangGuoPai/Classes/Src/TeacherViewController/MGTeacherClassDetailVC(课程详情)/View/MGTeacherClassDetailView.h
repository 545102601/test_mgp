//
//  MGTeacherClassDetailView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/26.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"
#import "MGResCourseListDetailModel.h"

@interface MGTeacherClassDetailView : BaseView

@property (nonatomic, strong) MGResCourseListDetailDataModel *dataModel;

@property (nonatomic, copy) MGCommomEventBlock wantEventBlock;

@property (nonatomic, copy) MGCommomEventBlock orderEventBlock;

@property (nonatomic, copy) MGCommomEventBlock iconImageViewLoadCompletion;

- (void)setWantButton:(BOOL)isFav;

- (void)setOrderButtonHidden;

@end
