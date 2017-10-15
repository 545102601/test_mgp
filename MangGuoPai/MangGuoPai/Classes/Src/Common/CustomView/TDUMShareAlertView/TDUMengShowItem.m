//
//  TDUMengShowItem.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/26.
//  Copyright © 2017年 梦创. All rights reserved.
//

#import "TDUMengShowItem.h"

@implementation TDUMengShowItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *btn = [[UIButton alloc]init];
        btn.userInteractionEnabled = NO;
        [self addSubview:btn];
        self.button = btn;
        
        //文字
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = PFSC(24);
        label.userInteractionEnabled = NO;
        [self addSubview:label];
        self.label = label;
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)]];
        
    }
    return self;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    //按钮
    CGFloat margin = SW(20);
    CGFloat btnWidth = width - 2 *margin;
    CGFloat btnHeight = height - 2 *margin;
    self.button.frame = CGRectMake(margin,margin, btnWidth, btnHeight);
    
    self.label.frame = CGRectMake(0, margin + CGRectGetMaxY(self.button.frame), width,height - CGRectGetMaxY(self.button.frame));
    
    
}

#pragma mark - Publick

- (void)setItemImage:(UIImage *)image{
    
    [self.button setBackgroundImage:image forState:UIControlStateNormal];
    
}

- (void)setItemTtile:(NSString *)title{
    
    [self.label setText:title];
}

#pragma mark - Actions

- (void)tap{
    
    if (self.itemTapBlock) {
        self.itemTapBlock(self);
    }
    
}

@end
