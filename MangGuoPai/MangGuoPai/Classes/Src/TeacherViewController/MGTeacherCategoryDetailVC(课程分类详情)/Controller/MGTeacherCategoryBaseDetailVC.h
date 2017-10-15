//
//  MGTeacherCategoryBaseDetailVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/23.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGResClassifyModel.h"
#import "MGTeacherCategoryBaseDetailTableView.h"

@interface MGTeacherCategoryBaseDetailVC : UIViewController

@property (nonatomic, strong) MGResClassifyDataModel *detailModel;

@property (nonatomic, strong) MGTeacherCategoryBaseDetailTableView *tableView;

@end
