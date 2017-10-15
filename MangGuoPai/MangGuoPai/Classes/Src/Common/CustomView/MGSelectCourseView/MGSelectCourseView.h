//
//  MGSelectCourseView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/6.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"

@interface MGSelectCourseView : BaseView

/// 列表
@property (nonatomic, strong) UITableView *tableView;

/// 数据源
@property (nonatomic, strong) NSMutableArray *arrayM;

/// 确定按钮block
@property (nonatomic, copy) MGCommomEventBlock sureBlock;


- (void)showSelectCourseWithAnimated:(BOOL)animated inView:(UIView *)view;

- (void)hideSelectCourseWithAnimated:(BOOL)animated inView:(UIView *)view;

@end
