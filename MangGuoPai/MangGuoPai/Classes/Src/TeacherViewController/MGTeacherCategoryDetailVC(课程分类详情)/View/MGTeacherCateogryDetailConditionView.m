//
//  MGTeacherCateogryDetailConditionView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/23.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherCateogryDetailConditionView.h"

@interface MGTeacherCateogryDetailConditionView ()
/// 默认筛选
@property (nonatomic, strong) UIView *defaultBgView;
@property (nonatomic, strong) UILabel *defaultLabel;
@property (nonatomic, strong) UIImageView *defaultImageView;
/// 价格筛选
@property (nonatomic, strong) UIView *priceBgView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *priceImageView;


@end

@implementation MGTeacherCateogryDetailConditionView


- (void)prepareFrameViewUI:(CGRect)frame {

    _defaultBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width * 0.5, frame.size.height)];
    
    _defaultLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24) textAlignment:NSTextAlignmentCenter];
    _defaultLabel.frame = CGRectMake(0, 0, SW(100),_defaultBgView.height);
    _defaultLabel.centerX = _defaultBgView.centerX;
    
    _defaultImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_defaultLabel.right + SW(8), 0, SW(38), SW(38))];
    _defaultImageView.centerY = _defaultBgView.centerY;
    
    [_defaultBgView sd_addSubviews:@[_defaultLabel, _defaultImageView]];
    
    _priceBgView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width * 0.5, 0, frame.size.width * 0.5, frame.size.height)];
    
    _priceLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24) textAlignment:NSTextAlignmentCenter];
    _priceLabel.frame = CGRectMake(0, 0, SW(100),_priceBgView.height);
    _priceLabel.centerX = _priceBgView.centerX;
    
    _priceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_priceLabel.right + SW(8), 0, SW(38), SW(38))];
    _priceImageView.centerY = _priceBgView.centerY;
    
    [_priceBgView sd_addSubviews:@[_priceLabel, _priceImageView]];

    
    
    [self sd_addSubviews:@[_defaultBgView, _priceBgView]];
    
}

@end
