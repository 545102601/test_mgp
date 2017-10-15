//
//  MGWorkProductionView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/14.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"
#import "MGResProjectActorModel.h"

typedef NS_ENUM(NSInteger, MGWorkProductionViewType) {
    MGWorkProductionViewTypephoto = 0,
    MGWorkProductionViewTypeFile  = 1,
    MGWorkProductionViewTypeTeam  = 2,
};

@interface MGWorkProductionView : BaseView

@property (nonatomic, assign) MGWorkProductionViewType type;

/// 相册URL数组
@property (nonatomic, strong) NSMutableArray *dataArrayM;

@end
