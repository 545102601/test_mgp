//
//  MGMessageRejectVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/11/23.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MGResMessageDetailModel.h"

@interface MGMessageRejectVC : BaseViewController

@property (nonatomic, strong) MGResMessageDetailDataModel *detailDataModel;

@property (nonatomic, copy) MGCommomEventBlock completionBlock;



@end
