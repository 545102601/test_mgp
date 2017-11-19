//
//  MGMyLessonTriangleView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMyLessonTriangleView.h"

@implementation MGMyLessonTriangleView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, self.width, 0);
    
    CGContextAddLineToPoint(context, 0, self.height);
    
    CGContextAddLineToPoint(context, 0, 0);
    
    CGContextClosePath(context);
    
    [[UIColor clearColor] setStroke];
    
    [self.fillBgColor setFill];
    
    CGContextDrawPath(context, kCGPathFillStroke);
}


@end
