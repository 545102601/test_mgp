//
//  MGMyCouponBaseVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/12.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGMyCouponBaseTableView.h"

@interface MGMyCouponBaseVC : UIViewController

@property (nonatomic, strong) MGMyCouponBaseTableView *tableView;

/// 状态 ~ 0 已使用: ， -1 已过期: ， 50 : 未使用
@property (nonatomic, assign) NSInteger state;


@end
