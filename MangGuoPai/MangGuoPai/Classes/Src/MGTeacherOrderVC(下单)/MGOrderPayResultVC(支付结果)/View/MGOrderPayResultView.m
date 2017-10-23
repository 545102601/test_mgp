//
//  MGOrderPayResultView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/17.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGOrderPayResultView.h"

@implementation MGOrderPayResultView

- (void)prepareFrameViewUI:(CGRect)frame {

    _leftLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_subTitle_Black font:PFSC(28)];
    _leftLabel.frame = CGRectMake(SW(24), 0, frame.size.width * 0.5, _leftLabel.fontLineHeight);
    
    _rightLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_subTitle_Black font:PFSC(28) textAlignment:NSTextAlignmentRight];
    _rightLabel.frame = CGRectMake(frame.size.width * 0.5 - SW(24), 0, frame.size.width * 0.5, _rightLabel.fontLineHeight);
    
    [self sd_addSubviews:@[_leftLabel, _rightLabel]];
}

@end
