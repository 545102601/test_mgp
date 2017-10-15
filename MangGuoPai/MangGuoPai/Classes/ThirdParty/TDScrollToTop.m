//
//  TDScrollToTop.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "TDScrollToTop.h"

@implementation TDScrollToTop

+ (void)scrollViewScrollToTop:(UIEvent *)event
{
    
    CGPoint location = [[[event allTouches] anyObject] locationInView:ApplicationDelegate.window];
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    
    if (CGRectContainsPoint(statusBarFrame, location)) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [self searchScrollViewInView:window];
    }
    
}

+ (void)statusBarWindowClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+ (BOOL)isShowingOnKeyWindow:(UIView *)view
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect newFrame = [keyWindow convertRect:view.frame fromView:view.superview];
    CGRect winBounds = keyWindow.bounds;
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    return !view.isHidden && view.alpha > 0.01 && view.window == keyWindow && intersects;
}

+ (void)searchScrollViewInView:(UIView *)supView
{
    for (UIScrollView *subView in supView.subviews) {
        if ([subView isKindOfClass:[UIScrollView class]] && [self isShowingOnKeyWindow:supView]) {
            CGPoint offset = subView.contentOffset;
            offset.y = -subView.contentInset.top;
            [subView setContentOffset:offset animated:YES];
        }
        
        [self searchScrollViewInView:subView];
    }
}


@end
