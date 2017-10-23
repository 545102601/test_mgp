//
//  MGMyOrderTableView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/3.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "YNBaseTableView.h"

@interface MGMyOrderBaseTableView : YNBaseTableView

/// 1 是 send  2 是 receive
@property (nonatomic, assign) MGGlobaMenuTag menuTag;

@property (nonatomic, copy) MGCommomEventBlock rightOneButtonBlock;

@property (nonatomic, copy) MGCommomEventBlock rightTwoButtonBlock;

@end
