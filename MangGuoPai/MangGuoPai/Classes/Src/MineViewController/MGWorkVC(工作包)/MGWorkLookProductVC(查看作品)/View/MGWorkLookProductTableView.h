//
//  MGWorkLookProductTableView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/15.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "YNBaseTableView.h"
#import "MGResProjectActorModel.h"

@interface MGWorkLookProductTableView : YNBaseTableView

@property (nonatomic, strong) MGResProjectActorDataModel *actorDataModel;

@property (nonatomic, copy) MGCommomEventBlock lookOtherFileButtonBlock;

@end
