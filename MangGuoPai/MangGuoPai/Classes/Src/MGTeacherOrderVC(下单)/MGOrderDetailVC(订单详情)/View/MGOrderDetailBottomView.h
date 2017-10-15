//
//  MGOrderDetailBottomView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/24.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"
#import "MGResOrderDetailModel.h"

@interface MGOrderDetailBottomView : BaseView
/// 订单详情数据
@property (nonatomic, strong) MGResOrderDetailDataModel *detailDataModel;

@property (nonatomic, copy) MGCommomEventBlock rightOneButtonBlock;

@property (nonatomic, copy) MGCommomEventBlock rightTwoButtonBlock;

@end
