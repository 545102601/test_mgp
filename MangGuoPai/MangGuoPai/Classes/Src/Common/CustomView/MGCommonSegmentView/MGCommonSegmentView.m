//
//  MGCommonSegmentView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/1.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGCommonSegmentView.h"

@interface MGCommonSegmentView ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation MGCommonSegmentView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = SH(10);
        self.clipsToBounds = YES;
        UIView *bgView = [UIView new];
        bgView.frame = CGRectMake(0 ,0, frame.size.width  , frame.size.height);
        
        bgView.backgroundColor = colorHex(@"#ffef99");
        
        [self addSubview:bgView];
        
        CGFloat width = frame.size.width / 2.0;
        CGFloat height = frame.size.height;
        
        _leftButton = [TDNotHighlightButton buttonWithType:UIButtonTypeCustom];
        
        [_leftButton setTitle:@"我下的订单" forState:UIControlStateNormal];
        _leftButton.titleLabel.font = PFSC(28);
        [_leftButton setTitleColor:MGThemeColor_Title_Black forState:UIControlStateNormal];
        [_leftButton setTitleColor:MGThemeColor_Title_Black forState:UIControlStateSelected];
        
        _leftButton.tag = 1;
        _leftButton.selected = YES;
        [_leftButton setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        [_leftButton setBackgroundImage:[UIImage imageWithColor:colorHex(@"#ffcc44")] forState:UIControlStateSelected];
        _leftButton.frame = CGRectMake(0, 0, width, height);
        [_leftButton addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _rightButton = [TDNotHighlightButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitle:@"我收到的订单" forState:UIControlStateNormal];
        [_rightButton setTitleColor:MGThemeColor_Title_Black forState:UIControlStateNormal];
        [_rightButton setTitleColor:MGThemeColor_Title_Black forState:UIControlStateSelected];
        
        _rightButton.titleLabel.font = PFSC(28);
        _rightButton.tag = 2;
        [_rightButton setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        [_rightButton setBackgroundImage:[UIImage imageWithColor:colorHex(@"#ffcc44")] forState:UIControlStateSelected];
        
        
        _rightButton.frame = CGRectMake(width, 0, width, height);
        [_rightButton addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self sd_addSubviews:@[_leftButton, _rightButton]];
        
    }
    return self;
}


- (void)buttonOnClick:(UIButton *)button {
    if (button.selected) return;
    
    if (button.tag == _leftButton.tag) {
        _leftButton.selected = YES;
        _rightButton.selected = NO;
    } else {
        _leftButton.selected = NO;
        _rightButton.selected = YES;
    }
    
    if (_buttonOnClickBlock) {
        _buttonOnClickBlock(button);
    }
    
}


- (void)setSelectedButtonWithTag:(NSInteger)tag {
    
    if (tag == _leftButton.tag) {
        _leftButton.selected = YES;
        _rightButton.selected = NO;
    } else {
        _leftButton.selected = NO;
        _rightButton.selected = YES;
    }
    
}

- (void)setLeftTitle:(NSString *)leftTitle {

    _leftTitle = leftTitle;
    
    [_leftButton setTitle:_leftTitle forState:UIControlStateNormal];
    
}
- (void)setRightTitle:(NSString *)rightTitle {
    _rightTitle = rightTitle;
    
    [_rightButton setTitle:_rightTitle forState:UIControlStateNormal];
    
}

@end
