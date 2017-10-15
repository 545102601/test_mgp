//
//  MGUpdateInfoVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/2.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MGMineInfoHeader.h"

@interface MGUpdateInfoVC : BaseViewController

@property (nonatomic, copy) NSString *contentString;

@property (nonatomic, assign) MineInfoTagType type;

@property (nonatomic, copy) MGCommomEventBlock completionBlock;

@end
