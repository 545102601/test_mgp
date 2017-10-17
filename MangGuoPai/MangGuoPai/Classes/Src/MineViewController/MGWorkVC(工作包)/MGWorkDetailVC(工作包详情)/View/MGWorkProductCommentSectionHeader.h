//
//  MGWorkProductCommentSectionHeader.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/16.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#define KMGWorkProductCommentSectionHeaderHeight SH(80)

#import <UIKit/UIKit.h>
#import "MGResProjectDetailModel.h"

@interface MGWorkProductCommentSectionHeader : UITableViewHeaderFooterView

@property (nonatomic, assign) NSInteger section;

@property (nonatomic, strong) MGResProjectDetailDataModel *dataModel;

@property (nonatomic, copy) MGCommomEventBlock expendButtonBlock;

@end
