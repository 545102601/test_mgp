//
//  MGTool.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/23.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTool.h"

@implementation MGTool


/// 最后一个变为红色字
+ (NSMutableAttributedString *)lastRedColorWithString:(NSString *)str attr:(NSDictionary *)attr {
    
    NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc] initWithString:str attributes:attr];
    [attrM addAttribute:NSForegroundColorAttributeName value:MGThemeColor_Red range:[str rangeOfString:@"*"]];
    
    return attrM;

}



@end
