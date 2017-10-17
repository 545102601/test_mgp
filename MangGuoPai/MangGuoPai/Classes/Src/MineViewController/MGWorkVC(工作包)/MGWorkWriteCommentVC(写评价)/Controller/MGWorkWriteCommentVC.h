//
//  MGWorkWriteCommentVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/15.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MGResProjectActorModel.h"

@interface MGWorkWriteCommentVC : BaseViewController

@property (nonatomic, copy) MGCommomEventBlock completionBlock;

@property (nonatomic, strong) MGResProjectActorDataModel *actorModel;

@end
