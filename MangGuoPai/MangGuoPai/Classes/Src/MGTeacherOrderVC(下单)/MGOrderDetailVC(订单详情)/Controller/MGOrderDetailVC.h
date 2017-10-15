//
//  MGOrderDetailVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/3.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MGResOrderListModel.h"

@interface MGOrderDetailVC : BaseViewController

/// 1 : 倒是昵称  2 : 学生昵称
@property (nonatomic, assign) NSInteger type;

/// 订单模型
@property (nonatomic, strong) MGResOrderListDataModel *dataModel;

@end
