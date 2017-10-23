//
//  MGScheduleVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/28.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, MGScheduleVCSourceType) {
    MGScheduleVCSourceTypeAdd = 0,
    MGScheduleVCSourceTypeLook = 1,
};

@interface MGScheduleVC : BaseViewController

@property (nonatomic, copy) MGCommomEventBlock completionSchedule;

/// 订单Id
@property (nonatomic, assign) long orderId;

/// 来源
@property (nonatomic, assign) MGScheduleVCSourceType sourceType;


@end
