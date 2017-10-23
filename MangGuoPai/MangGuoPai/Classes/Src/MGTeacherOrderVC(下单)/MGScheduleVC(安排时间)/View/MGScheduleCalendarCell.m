//
//  MGScheduleCalendarCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/28.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGScheduleCalendarCell.h"

@interface MGScheduleCalendarCell ()

@end

@implementation MGScheduleCalendarCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CAShapeLayer *selectionLayer = [[CAShapeLayer alloc] init];
        selectionLayer.fillColor = colorHex(@"#FBCC38").CGColor;
        selectionLayer.actions = @{@"hidden":[NSNull null]};
        
        [self.contentView.layer insertSublayer:selectionLayer below:self.titleLabel.layer];
        self.selectionLayer = selectionLayer;
        
        _keImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MGSepLineHeight, MGSepLineHeight, SW(52), SW(32))];
        _keImageView.contentMode = UIViewContentModeTopLeft;
        
        _keImageView.image = [UIImage imageNamed:@"order_icon_ke"];
        _keImageView.hidden = YES;
        
        [self.contentView addSubview:_keImageView];
        
        self.shapeLayer.hidden = YES;
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.backgroundView.frame = CGRectInset(self.bounds, MGSepLineHeight, MGSepLineHeight);
    self.selectionLayer.frame = self.bounds;
    self.selectionLayer.path = [UIBezierPath bezierPathWithRect:self.selectionLayer.bounds].CGPath;
    _keImageView.left = MGSepLineHeight;
    _keImageView.top = MGSepLineHeight;
    
}

- (void)configureAppearance
{
    [super configureAppearance];
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter


@end
