//
//  MGReverseFoundVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/24.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MGResTrendListModel.h"

@interface MGReverseFoundVC : BaseViewController

/// 数据源
@property (nonatomic, strong) MGResTrendListDataModel *dataModel;

@property (nonatomic, copy) MGCommomEventBlock publishCompletionBlock;

@end
