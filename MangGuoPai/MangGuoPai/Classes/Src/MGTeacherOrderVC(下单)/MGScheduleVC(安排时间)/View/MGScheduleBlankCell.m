//
//  MGScheduleBlankCell.m
//  FSCalendar
//
//  Created by ZYN on 2017/9/28.
//  Copyright © 2017年 wenchaoios. All rights reserved.
//

#import "MGScheduleBlankCell.h"

@interface MGScheduleBlankCell ()

@property (weak, nonatomic) CAShapeLayer *bgLayer;

@end

@implementation MGScheduleBlankCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentView.frame = CGRectInset(self.bounds, MGSepLineHeight, MGSepLineHeight);

}
@end
