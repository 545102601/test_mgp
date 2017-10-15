//
//  NSString+HTMLImageAdapt.m
//  YooYoWeekend
//
//  Created by JK on 15/9/10.
//  Copyright (c) 2015年 JK. All rights reserved.
//

#import "NSString+HTMLImageAdapt.h"

@implementation NSString (HTMLImageAdapt)
-(NSString*)htmlImageAdaptWith:(long)width
{     NSString *newString = [NSString stringWithFormat:@".jpg\" width=\"%ldpx\"",width];
    
     return [self stringByReplacingOccurrencesOfString:@".jpg\"" withString:newString];
}
@end

