//
//  MGTeacherCategoryDetailVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/23.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MGResClassifyModel.h"

#define kSelectedParentCategory 9999

@interface MGTeacherCategoryDetailVC : BaseViewController

@property (nonatomic, strong) MGResClassifyDataModel *dataModel;

/// 9999 则选择父类
@property (nonatomic, assign) NSInteger selectedIndex;


@end
