//
//  NSObject+RouterExtend.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RouterExtend)


+ (void)routerWithParams:(NSDictionary *)params;
- (void)routerWithParams:(NSDictionary *)params;


+ (void)routerWithEntityType:(MGGlobalEntityType)entityType id:(long)id;
- (void)routerWithEntityType:(MGGlobalEntityType)entityType id:(long)id;


+ (UIViewController *)getCurrentViewController;
- (UIViewController *)getCurrentViewController;

@end

