//
//  MGPayOrderWayVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/31.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MGResOrderListModel.h"

@interface MGPayOrderWayVC : BaseViewController

/// 订单列表 data数据
@property (nonatomic, strong) MGResOrderListDataModel *listDataModel;

/// 支付订单的id
@property (nonatomic, assign) long payOrderId;



@end
