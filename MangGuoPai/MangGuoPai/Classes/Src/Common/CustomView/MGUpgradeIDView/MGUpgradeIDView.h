//
//  MGUpgradeIDView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/14.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"

typedef void(^UpgradeIDViewDidCloseBlock)(void);

typedef void(^UpgradeIDViewDidUpgradeBlock)(void);

@interface MGUpgradeIDView : BaseView

@property (nonatomic, copy) UpgradeIDViewDidCloseBlock didCloseBlock;

@property (nonatomic, copy) UpgradeIDViewDidUpgradeBlock didUpgradeBlock;

@end
