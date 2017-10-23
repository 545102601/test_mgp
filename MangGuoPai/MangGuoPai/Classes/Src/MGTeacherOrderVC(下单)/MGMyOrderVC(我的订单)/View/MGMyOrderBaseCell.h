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


@property (nonatomic, assign) MGGlobaMenuTag menuTag;

@property (nonatomic, strong) MGResOrderListDataModel *dataModel;

@end
