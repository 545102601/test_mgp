//
//  MGMyOrderBaseCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/3.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MGResOrderListModel.h"

@interface MGMyOrderBaseCell : BaseTableViewCell

@property (nonatomic, copy) MGCommomEventBlock rightOneButtonBlock;

@property (nonatomic, copy) MGCommomEventBlock rightTwoButtonBlock;

@property (nonatomic, strong) NSIndexPath *indexPath;

/// 1 是 send  2 是 receive
@property (nonatomic, assign) NSInteger viewControllerType;

@property (nonatomic, strong) MGResOrderListDataModel *dataModel;

@end
