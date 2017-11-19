//
//  MGWorkDetailTableHeader.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/30.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"
#import "MGResProjectDetailModel.h"

@interface MGWorkDetailTableHeader : BaseView

@property (nonatomic, strong) MGResProjectDetailDataModel *dataModel;

@property (nonatomic, copy) MGCommomEventBlock iconImageViewLoadCompletion;

- (CGFloat)headerHeight;

@end
