//
//  MGHomeBottomTipCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/16.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGHomeBottomTipCell.h"

@interface MGHomeBottomTipCell ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation MGHomeBottomTipCell

- (void)preapreCellUI {
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [MGUITool labelWithText:@"更多服务咨询 , 请关注我们公众号 : 芒果派" textColor:MGThemeColor_Common_Black font:PFSC(24)];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 0, kScreenWidth, label.fontLineHeight);
    _label = label;
    [self.contentView addSubview:label];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _label.centerY = self.contentView.centerY;
    
}

@end
