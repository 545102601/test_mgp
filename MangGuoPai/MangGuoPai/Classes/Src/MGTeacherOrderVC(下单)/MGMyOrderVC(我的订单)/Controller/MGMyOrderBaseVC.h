//
//  MGMyOrderBaseVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/3.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMyOrderBaseTableView.h"

@interface MGMyOrderBaseVC : UIViewController

@property (nonatomic, strong) MGMyOrderBaseTableView *tableView;
/// 1 是 send  2 是 receive
@property (nonatomic, assign) NSInteger viewControllerType;

@end
