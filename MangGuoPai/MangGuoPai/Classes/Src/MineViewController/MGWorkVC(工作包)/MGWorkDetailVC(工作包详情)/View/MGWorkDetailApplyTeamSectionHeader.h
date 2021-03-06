//
//  MGWorkDetailApplyTeamSectionHeader.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/14.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMGWorkDetailApplyTeamSectionHeaderHeight SH(79)
#import "MGResProjectDetailModel.h"


@interface MGWorkDetailApplyTeamSectionHeader : UITableViewHeaderFooterView

@property (nonatomic, assign) NSInteger section;

@property (nonatomic, strong) MGResProjectDetailDataModel *dataModel;

@property (nonatomic, copy) MGCommomEventBlock expendButtonBlock;

@end
