//
//  NSObject+RouterExtend.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RouterExtend)


+ (void)routerWithPrarms:(NSDictionary *)params;
- (void)routerWithPrarms:(NSDictionary *)params;

+ (UIViewController *)getCurrentViewController;
- (UIViewController *)getCurrentViewController;

@end

