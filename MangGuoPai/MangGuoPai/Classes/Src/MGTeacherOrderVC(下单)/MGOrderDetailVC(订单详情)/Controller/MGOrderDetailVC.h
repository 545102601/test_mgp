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


@property (nonatomic, assign) MGGlobaMenuTag menuTag;

/// 订单模型
@property (nonatomic, strong) MGResOrderListDataModel *dataModel;

@end
