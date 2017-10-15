//
//  NSObject+Extend.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extend)

/// 弹Toast
- (void)showMBText:(NSString *)text;
+ (void)showMBText:(NSString *)text;

/// 弹Toasr 小字体
- (void)showMBDetailText:(NSString *)text;
+ (void)showMBDetailText:(NSString *)text;


@end
