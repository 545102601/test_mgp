//
//  MGContentDetailVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MGResContentModel.h"

typedef NS_ENUM(NSInteger, ContentDetailSouceType) {
    ContentDetailSouceTypeCommon = 0,
    ContentDetailSouceTypeBulletin = 1,
};

@interface MGContentDetailVC : BaseViewController

@property (nonatomic, assign) long id;

@property (nonatomic, assign) ContentDetailSouceType type;

@end
