//
//  MGOrderPayResultVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/17.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MGResOrderListModel.h"

@interface MGOrderPayResultVC : BaseViewController
/// 订单列表 data数据
@property (nonatomic, strong) MGResOrderListDataModel *listDataModel;

@property (nonatomic, copy) NSString *payWay;

@property (nonatomic, assign) BOOL isPaySuccess;

@end
