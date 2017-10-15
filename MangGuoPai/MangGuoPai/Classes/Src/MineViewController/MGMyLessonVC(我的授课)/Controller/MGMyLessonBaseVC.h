//
//  MGMyLessonBaseVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/1.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGMyLessonBaseTableView.h"

@interface MGMyLessonBaseVC : UIViewController

@property (nonatomic, strong) MGMyLessonBaseTableView *tableView;

@property (nonatomic, assign) NSInteger viewControllerType;

@end
