//
//  MGTool.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/23.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGTool : NSObject

/// 最后一个变为红色字
+ (NSMutableAttributedString *)lastRedColorWithString:(NSString *)str attr:(NSDictionary *)attr;


@end
