//
//  MGOrderDetailFileView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/7.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"
#import "MGResOrderDetailModel.h"

@interface MGOrderDetailFileView : BaseView

/// 订单详情数据
@property (nonatomic, strong) MGResOrderDetailDataModel *detailDataModel;

@property (nonatomic, copy) MGCommomEventBlock resetFrameBlock;

/// 相册URL数组
@property (nonatomic, strong) NSMutableArray *dataArrayM;

@property (nonatomic, copy) NSString *tipTitleText;

@end
