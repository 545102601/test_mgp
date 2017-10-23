//
//  MGOrderCommentVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MGResOrderDetailModel.h"

typedef NS_ENUM(NSInteger, MGOrderCommentType) {
    MGOrderCommentTypeAdd = 0,
    MGOrderCommentTypeReply = 1,
};

@interface MGOrderCommentVC : BaseViewController

@property (nonatomic, assign) MGOrderCommentType commentType;

/// 订单详情
@property (nonatomic, strong) MGResOrderDetailDataModel *dataModel;

@property (nonatomic, copy) MGCommomEventBlock completiomBlock;

@end
