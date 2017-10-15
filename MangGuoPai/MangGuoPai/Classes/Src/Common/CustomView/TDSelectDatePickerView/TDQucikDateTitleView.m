//
//  TDQucikDateTitleView.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/20.
//  Copyright © 2017年 梦创. All rights reserved.
//

#import "TDQucikDateTitleView.h"

@implementation TDQucikDateTitleView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _dateLabel = [MGUITool labelWithText:nil textColor:MGThemeBackgroundColor font:PFSC(36) textAlignment:NSTextAlignmentCenter];
        _dateLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        [self addSubview:_dateLabel];
        
    }
    return self;
}



@end
