//
//  MGWorkProgressView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/30.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkProgressView.h"

@interface MGWorkProgressView ()

/// 数字背景
@property (nonatomic, strong) UIImageView *numberImageView;
/// 数字
@property (nonatomic, strong) UILabel *numberLabel;
/// 进度条背景
@property (nonatomic, strong) UIView *progressBgView;
/// 进度条
@property (nonatomic, strong) UIView *progressView;

@end

@implementation MGWorkProgressView


- (void)prepareFrameViewUI:(CGRect)frame {

    
  
    _numberImageView = [[UIImageView alloc] init];
    _numberImageView.image = [UIImage imageNamed:@"mine_work_icon_bu"];
    _numberImageView.frame = CGRectMake(0, frame.size.height - SH(20) - SH(40), SW(60), SH(40));
    
    _numberLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(18) textAlignment:NSTextAlignmentCenter];
    _numberLabel.adjustsFontSizeToFitWidth = YES;
    _numberLabel.frame = CGRectMake(0, _numberImageView.top + SH(2), _numberImageView.width, _numberLabel.fontLineHeight);
    
    
    _progressBgView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - SH(20), frame.size.width, SH(20))];
    _progressBgView.layer.cornerRadius = SH(10);
    _progressBgView.backgroundColor = RGB(255, 249, 233);
    
    
    _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - SH(20), 0, SH(20))];
    _progressView.layer.cornerRadius = SH(10);
    _progressView.backgroundColor = RGB(255, 203, 93);;
    
    
    [self sd_addSubviews:@[_numberImageView, _numberLabel, _progressBgView, _progressView]];

}

- (void)setProgressNumber:(NSInteger)progressNumber {

    _progressNumber = progressNumber;

    _numberLabel.text = [NSString stringWithFormat:@"%zd%%",progressNumber];
    
    
    CGFloat width = self.width * progressNumber / 100;
    
    _progressView.width = width;
    
    _numberImageView.centerX = width;
    
    _numberLabel.centerX = width;
    _numberLabel.centerY = _numberImageView.centerY - SH(4);
    
}



@end
