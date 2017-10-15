//
//  UITabBar+Extend.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Extend)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
