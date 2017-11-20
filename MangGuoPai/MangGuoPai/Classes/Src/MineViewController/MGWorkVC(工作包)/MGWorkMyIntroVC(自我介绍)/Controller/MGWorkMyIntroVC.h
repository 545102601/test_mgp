//
//  MGWorkMyIntroVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/11/15.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"

@interface MGWorkMyIntroVC : BaseViewController

@property (nonatomic, copy) MGCommomEventBlock saveCompletionBlock;

@property (nonatomic, strong) NSMutableDictionary *resultDictM;

@end
