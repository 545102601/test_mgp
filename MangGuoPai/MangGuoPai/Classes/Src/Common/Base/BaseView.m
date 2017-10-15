//
//  BaseView.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self prepareViewUI];
        
        [self prepareFrameViewUI];
        [self prepareFrameViewUI:frame];
    }
    return self;
}

- (void)prepareViewUI {}
- (void)prepareFrameViewUI {}
- (void)prepareFrameViewUI:(CGRect)frame {}
@end
