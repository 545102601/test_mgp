//
//  TDSelectDatePickerView.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/7/8.
//  Copyright © 2017年 梦创. All rights reserved.
//

#import "TDSelectDatePickerView.h"


@interface TDSelectDatePickerView () <TDQucikSelectDateViewDelegate>

/// 内容
@property (nonatomic, strong) UIView *contentView;
/// 顶部背景内容
@property (nonatomic, strong) UIView *topBgView;
/// 按钮标题
@property (nonatomic, strong) UIButton *titleButton;

/// 确定按钮
@property (nonatomic, strong) UIButton *sureButton;
/// 线条
@property (nonatomic, strong) UIView *lineView;

/// 背景
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) TDQuickSelectDateModel *model;

@end

@implementation TDSelectDatePickerView



- (void)prepareViewUI {
    self.hidden = YES;
    
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panListener:)]];
    
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    
    
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor = RGBA(0, 0, 0, 1);
    _backgroundView.alpha = 0;
    [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTapOnClick)]];
    [self addSubview:_backgroundView];
    
    _topBgView = [[UIView alloc] init];
    _topBgView.backgroundColor = [UIColor clearColor];
    
    _sureButton = [MGUITool buttonWithBGColor:nil title:@"确定" titleColor:MGThemeBackgroundColor font:PFSC(32) target:self selector:@selector(sureButtonOnClick:)];
    
    _titleButton = [MGUITool buttonWithBGColor:nil title:@"选择日期" titleColor:MGThemeColor_Common_Black font:PFSC(32) target:nil selector:nil];
    _titleButton.userInteractionEnabled = NO;
    
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = MGSepColor;
    
    [_topBgView addSubview:_sureButton];
    
    [_topBgView addSubview:_titleButton];
    [_topBgView addSubview:_lineView];
    
    [_contentView addSubview:_topBgView];
    
    [self addSubview:_contentView];
    
    
    _dateView = [[TDQucikSelectDateView alloc] init];
    _dateView.topLabel.hidden = YES;
    [_contentView addSubview:_dateView];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        _model = [[TDQuickSelectDateModel alloc] init];
        _dateView.model = _model;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_dateView.pickerView reloadAllComponents];
            [_dateView setSelectDate:[NSDate date] animated:NO];
        });
    });
}
- (void)panListener:(UIPanGestureRecognizer *)pan {
    
    return;
    
}

- (void)bgTapOnClick {
    
    [self hideSelectDatePickViewWithAnimated:YES inView:self.superview];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _backgroundView.frame = self.bounds;
    
    _topBgView.frame = CGRectMake(0, 0, self.width, getScaleHeight(116));
    
    
    _sureButton.frame = CGRectMake(self.width - getScaleWidth(30) - getScaleWidth(80), 0,getScaleWidth(80), getScaleHeight(40));;
    
    _titleButton.frame = CGRectMake(0, 0, getScaleWidth(200), _titleButton.titleLabel.fontLineHeight);
    
    _sureButton.centerY = _topBgView.centerY;
    
    _titleButton.centerY = _topBgView.centerY;
    
    _titleButton.centerX = self.centerX;
    
    _lineView.frame = CGRectMake(0, _topBgView.bottom - MGSepLineHeight, _topBgView.width,MGSepLineHeight);
    
    
    _contentView.frame = CGRectMake(0, _backgroundView.height - getScaleHeight(404), _backgroundView.width, getScaleHeight(404));
    
    _dateView.frame = CGRectMake(0, _topBgView.bottom, _topBgView.width, SH(300));
    _dateView.delegate = self;
    [_dateView setTopLabelIsHidden:YES pickerViewHeight:300];
    /// 5 隐藏 年月日 label
    if (kScreenWidth == 320.0f) {
        [_dateView setLabelYearMonthDayIsHidden:YES];
        
    }
    
}


- (void)sureButtonOnClick:(id)sender {
    if ([TDCommonTool anySubViewScrolling:_dateView]) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectDatePickerView:didSureButtonOnClick:)]) {
        [self.delegate selectDatePickerView:self didSureButtonOnClick:[_dateView getCurrentSelectedDate]];
    }
    
}

#pragma mark - TDQucikSelectDateViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectDate:(NSDate *)date {
    
    /// 最小时间
    if (self.minDate) {
        
        if (date.timeIntervalSinceNow < self.minDate.timeIntervalSinceNow) {
            [_dateView setSelectDate:self.minDate animated:YES];
        }
        
    }
    /// 最大时间
    if (self.maxDate) {
        if (date.timeIntervalSinceNow > self.maxDate.timeIntervalSinceNow) {
            [_dateView setSelectDate:self.maxDate animated:YES];
        }
    }

}


- (void)showSelectDatePickViewWithAnimated:(BOOL)animated inView:(UIView *)view {
    
    
    if (animated && self.hidden) {
        self.hidden = NO;
        
        _contentView.y = _backgroundView.height;
        _backgroundView.alpha = 0;
        [UIView animateWithDuration:0.27 delay:0 options:458752 | UIViewAnimationOptionBeginFromCurrentState animations:^{
            _contentView.y = _backgroundView.height - getScaleHeight(404);
            _backgroundView.alpha = 0.3;
            
        } completion:nil];
        
    } else {
        _contentView.y = view.frame.size.height - getScaleHeight(404);
        _backgroundView.alpha = 0;
        
        self.hidden = NO;
    }
}

- (void)hideSelectDatePickViewWithAnimated:(BOOL)animated inView:(UIView *)view {
    if (animated && !self.hidden) {
        [UIView animateWithDuration:0.27 delay:0 options:458752 | UIViewAnimationOptionBeginFromCurrentState animations:^{
            _contentView.y = _backgroundView.height;
            _backgroundView.alpha = 0;
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    } else {
        self.hidden = YES;
    }
}


@end
