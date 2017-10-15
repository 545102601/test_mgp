//
//  MGWorkApplyVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MGResProjectDetailModel.h"

@interface MGWorkApplyVC : BaseViewController

@property (nonatomic, copy) MGCommomEventBlock applyCompletion;

@property (nonatomic, strong) MGResProjectDetailDataModel *dataModel;

@end
