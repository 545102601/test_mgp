//
//  TDExpendClickImageView.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/6/5.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "TDExpendClickImageView.h"

@implementation TDExpendClickImageView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    CGFloat widthDelta = 44.0 - bounds.size.width;
    CGFloat heightDelta = 44.0 - bounds.size.height;
    bounds = CGRectInset(bounds, -0.5 *widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end
