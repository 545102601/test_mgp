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

typedef NS_ENUM(NSInteger, MGOrderInfoViewSourceType) {
    MGOrderInfoViewSourceTypeDefault = 0,
    MGOrderInfoViewSourceTypeOrderDetail = 1,
};

@interface MGOrderInfoView : BaseView

@property (nonatomic, assign) MGOrderInfoViewSourceType sourceType;

@property (nonatomic, assign) MGGlobaMenuTag menuTag;

@property (nonatomic, strong) MGResOrderDetailDataModel *detailDataModel;

@property (nonatomic, strong) MGResOrderListDataModel *dataModel;

@property (nonatomic, copy) MGCommomEventBlock phoneTapBlock;

@property (nonatomic, copy) MGCommomEventBlock orderNameTapBlock;

@property (nonatomic, assign) BOOL hiddenBottomLine;

@end
