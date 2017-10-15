//
//  MGOrderInfoView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/7.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"
#import "MGResOrderDetailModel.h"
#import "MGResOrderListModel.h"

@interface MGOrderInfoView : BaseView

/// 1 是 导师昵称  2 是学生昵称
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) MGResOrderDetailDataModel *detailDataModel;

@property (nonatomic, strong) MGResOrderListDataModel *dataModel;




@end
