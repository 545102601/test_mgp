//
//  MGCommonWebViewVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"

@interface MGCommonWebViewVC : BaseViewController

@property (nonatomic, copy) NSString *urlString;

@property (nonatomic, copy) NSString *titleString;

@property(nonatomic,strong) NSMutableDictionary * params;

@end
