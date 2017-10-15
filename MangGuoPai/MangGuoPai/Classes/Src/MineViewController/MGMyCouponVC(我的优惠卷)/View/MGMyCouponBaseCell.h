//
//  MGMyCouponBaseCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/12.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#define kMGMyCouponBaseCellHeight SH(174)

#import "BaseTableViewCell.h"
#import "MGCouponOwnsModel.h"


@interface MGMyCouponBaseCell : BaseTableViewCell

@property (nonatomic, strong) MGCouponOwnsDataModel *dataModel;

@end
