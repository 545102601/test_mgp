//
//  TDExpendClickButton.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/6/3.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "TDExpendClickButton.h"

@implementation TDExpendClickButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    CGFloat widthDelta = 44.0 - bounds.size.width;
    CGFloat heightDelta = 44.0 - bounds.size.height;
    bounds = CGRectInset(bounds, -0.5 *widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end

@implementation TDExpendClickButtonNotHightLight

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    CGFloat widthDelta = 44.0 - bounds.size.width;
    CGFloat heightDelta = 44.0 - bounds.size.height;
    bounds = CGRectInset(bounds, -0.5 *widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

- (void)setHighlighted:(BOOL)highlighted {
    
    [super setHighlighted:NO];
    
}

@end


@implementation TDNotHighlightButton


- (void)setHighlighted:(BOOL)highlighted {
    
    [super setHighlighted:NO];
    
}

+ (TDNotHighlightButton *)buttonWithFrame:(CGRect)rect
                                imageName:(NSString *)name
                                   target:(id)target
                                 selector:(SEL)selector {
    TDNotHighlightButton *btn = [[TDNotHighlightButton alloc] initWithFrame:rect];
    if (name.length > 0) {
        [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    }
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
@end
