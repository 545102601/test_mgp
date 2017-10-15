//
//  MGFoundViewController.h
//  MangGuoPai
//
//  Created by ZYN on 2017/6/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MGFoundTableView.h"

@interface MGFoundViewController : BaseViewController

/// 列表
@property (nonatomic, strong) MGFoundTableView *tableView;

/// 额外的请求参数
@property (nonatomic, strong) NSDictionary *externRequestParams;

@end
