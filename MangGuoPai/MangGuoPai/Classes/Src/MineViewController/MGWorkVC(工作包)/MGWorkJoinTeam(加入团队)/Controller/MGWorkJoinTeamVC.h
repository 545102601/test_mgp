//
//  MGWorkJoinTeamVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/11/15.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MGResProjectListTeamModel.h"
#import "MGResProjectDetailModel.h"

@interface MGWorkJoinTeamVC : BaseViewController

@property (nonatomic, strong) MGResProjectDetailDataModel *dataModel;

@property (nonatomic, strong) MGResProjectListTeamDataModel *teamDataModel;

@end
