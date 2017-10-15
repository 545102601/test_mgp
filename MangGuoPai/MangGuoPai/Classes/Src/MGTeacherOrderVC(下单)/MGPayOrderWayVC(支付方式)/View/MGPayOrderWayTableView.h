//
//  MGPayOrderWayTableView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/1.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "YNBaseTableView.h"


typedef void(^DidOnClickSelectedBlock)(NSIndexPath *indexPath);

@interface MGPayOrderWayTableView : YNBaseTableView


@property (nonatomic, copy) DidOnClickSelectedBlock didOnClickSelectedBlock;

@end
