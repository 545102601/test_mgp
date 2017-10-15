//
//  MGSelectPhotoView.m
//  MGBeijiaBill
//
//  Created by ZYN on 2017/5/4.
//  Copyright © 2017年 团贷网. All rights reserved.
//

#import "TDSelectPhotoView.h"

@interface TDSelectPhotoView ()

/// 内容
@property (nonatomic, strong) UIView *contentView;
/// 上部
@property (nonatomic, strong) UIButton *topBtn;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UIView *topLineView;

@property (nonatomic, strong) UIImageView *arrowImageView1;
/// 中间
@property (nonatomic, strong) UIButton *centerBtn;
@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UIView *centerLineView;
@property (nonatomic, strong) UIImageView *arrowImageView;

/// 底部
@property (nonatomic, strong) UIButton *bottomBtn;
@property (nonatomic, strong) UILabel *bottomLabel;




/// 背景
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation TDSelectPhotoView


- (void)prepareViewUI {
    
    self.hidden = YES;
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    
    _topBtn = [MGUITool buttonWithBGColor:[UIColor clearColor] title:nil titleColor:nil font:nil target:self selector:@selector(topBtnOnClick)];
    
    _topLabel = [MGUITool labelWithText:@"拍照" textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _topLabel.textAlignment = NSTextAlignmentCenter;
    _topLineView = [[UIView alloc] init];
    _topLineView.backgroundColor = MGSepColor;
    
    _arrowImageView1 = [[UIImageView alloc] init];
    _arrowImageView1.image = [UIImage imageNamed:@"mine_more_2"];
    _arrowImageView1.hidden = YES;
    
    _centerBtn = [MGUITool buttonWithBGColor:[UIColor clearColor] title:nil titleColor:nil font:nil target:self selector:@selector(centerBtnOnClick)];
    
    _centerLabel = [MGUITool labelWithText:@"上传图片" textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _centerLabel.textAlignment = NSTextAlignmentCenter;
    _centerLineView = [[UIView alloc] init];
    _centerLineView.backgroundColor = MGSepColor;
    
    _arrowImageView = [[UIImageView alloc] init];
    _arrowImageView.image = [UIImage imageNamed:@"mine_more_2"];
    _arrowImageView.hidden = YES;
    
    _bottomBtn = [MGUITool buttonWithBGColor:[UIColor clearColor] title:nil titleColor:nil font:nil target:self selector:@selector(bottomBtnOnClick)];
    
    _bottomLabel = [MGUITool labelWithText:@"查看" textColor:MGThemeColor_Common_Black font:PFSC(28) ];
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor = RGBA(0, 0, 0, 1);
    _backgroundView.alpha = 0;
    [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTapOnClick)]];
    
    [self addSubview:_backgroundView];
    [self addSubview:_contentView];
    
    [_contentView sd_addSubviews:@[_topBtn, _topLabel, _topLineView, _arrowImageView1,  _centerBtn, _centerLabel, _centerLineView, _arrowImageView, _bottomBtn, _bottomLabel]];
    

    
}

- (void)layoutSubviews {
    [super layoutSubviews];

    
    _backgroundView.frame = self.bounds;
    
    _contentView.frame = CGRectMake(0, _backgroundView.height - getScaleHeight(300), _backgroundView.width, getScaleHeight(300));
    
    _topBtn.frame = CGRectMake(0, 0, _backgroundView.width, SH(100));
    _topLabel.frame = CGRectMake(0, 0, SW(200), _topLabel.fontLineHeight);
    _topLabel.centerY = _topBtn.height * 0.5;
    _topLabel.centerX = _topBtn.width * 0.5;
    
    
    _topLineView.frame = CGRectMake(SW(30), _topBtn.bottom - MGSepLineHeight, _topBtn.width - SW(30), MGSepLineHeight);
    
    _arrowImageView1.frame = CGRectMake(_topBtn.width - SW(30) - SW(20), 0, SW(20), SH(32));
    _arrowImageView1.centerY = _topBtn.height * 0.5;
    
    
    _centerBtn.frame = CGRectMake(0, _topBtn.bottom, _backgroundView.width, SH(100));
    _centerLabel.frame = CGRectMake(0, 0, _centerBtn.width * 0.5, _centerLabel.fontLineHeight);
    _centerLabel.centerY = _centerBtn.bottom - _centerBtn.height * 0.5;
    _centerLabel.centerX = _centerBtn.width * 0.5;
    
    
    _centerLineView.frame = CGRectMake(SW(30), _centerBtn.bottom, _centerBtn.width - SW(30), MGSepLineHeight);
    _arrowImageView.frame = CGRectMake(_centerBtn.width - SW(30) - SW(20), 0, SW(20), SH(32));
    _arrowImageView.centerY = _centerBtn.bottom - _centerBtn.height * 0.5;
 
    
    _bottomBtn.frame = CGRectMake(0, _centerBtn.bottom, _backgroundView.width, SH(100));
    _bottomLabel.frame = CGRectMake(0, 0, _bottomBtn.width * 0.5, _bottomLabel.fontLineHeight);
    _bottomLabel.centerY = _bottomBtn.bottom - _bottomBtn.height * 0.5;
    _bottomLabel.centerX = _bottomBtn.width * 0.5;
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

- (void)bgTapOnClick {
    
    [self hideSelectPhotoWithAnimated:YES inView:self.superview];
    
}

- (void)topBtnOnClick {
    
    [self hideSelectPhotoWithAnimated:YES inView:self.superview];
    
    if (_buttonPhotoOnClickBlock) {
        _buttonPhotoOnClickBlock(SelectPhotoViewTypeTakePhoto);
    }
    
}
- (void)centerBtnOnClick {
    
    
    [self hideSelectPhotoWithAnimated:YES inView:self.superview];
    
    if (_buttonPhotoOnClickBlock) {
        _buttonPhotoOnClickBlock(SelectPhotoViewTypeSelectPhoto);
    }
    
}


- (void)bottomBtnOnClick {
    
    
    [self hideSelectPhotoWithAnimated:YES inView:self.superview];
    
    if (_buttonPhotoOnClickBlock) {
        _buttonPhotoOnClickBlock(SelectPhotoViewTypeLook);
    }
    
}

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

- (void)setBottomTtitleWithString:(NSString *)string {
    
    self.bottomLabel.text = string;
    
}


- (void)showSelectPhotoWithAnimated:(BOOL)animated inView:(UIView *)view {
    
    
    if (animated && self.hidden) {
        self.hidden = NO;
        
        _contentView.y = _backgroundView.height;
        _backgroundView.alpha = 0;
        [UIView animateWithDuration:0.27 delay:0 options:458752 | UIViewAnimationOptionBeginFromCurrentState animations:^{
            _contentView.y = _backgroundView.height - getScaleHeight(300);
            _backgroundView.alpha = 0.3;
            
        } completion:nil];
        
    } else {
        _contentView.y = view.frame.size.height - getScaleHeight(300);
        _backgroundView.alpha = 0;
        
        self.hidden = NO;
    }
}

- (void)hideSelectPhotoWithAnimated:(BOOL)animated inView:(UIView *)view {
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

#pragma mark - Private Function

#pragma mark - Getter and Setter


@end
