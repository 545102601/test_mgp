//
//  MGPayOrderWayCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/1.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MGPayOrderWayModel.h"

typedef void(^DidOnClickSelectedBlock)(NSIndexPath *indexPath);

@interface MGPayOrderWayCell : BaseTableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) MGPayOrderWayModel *model;

@property (nonatomic, copy) DidOnClickSelectedBlock didOnClickSelectedBlock;

@end
