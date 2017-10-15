//
//  MGTeacherDetailFooterView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherDetailFooterView.h"

@interface MGTeacherDetailFooterView ()
/// 想听按钮
@property (nonatomic, strong) UIButton *wantButton;
@property (nonatomic, strong) UILabel *wantLabel;

/// 马上听
@property (nonatomic, strong) UIButton *atOneceWantButton;

@end

@implementation MGTeacherDetailFooterView


- (void)prepareFrameViewUI:(CGRect)frame {

    self.backgroundColor = [UIColor whiteColor];
    
    _wantButton = [TDExpendClickButtonNotHightLight buttonWithType:UIButtonTypeCustom];
    _wantButton.titleLabel.font = PFSC(30);
    [_wantButton setImage:[UIImage imageNamed:@"teacher_xiangting_nor"] forState:UIControlStateNormal];
    [_wantButton setImage:[UIImage imageNamed:@"teacher_xiangting_sel"] forState:UIControlStateSelected];
    
    _wantButton.frame = CGRectMake(SW(28), 0, SW(44), SW(44));
    _wantButton.centerY = frame.size.height * 0.5;
    [_wantButton addTarget:self action:@selector(wantButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _wantLabel = [MGUITool labelWithText:@"想听" textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _wantLabel.frame = CGRectMake(_wantButton.right + SW(12), 0, SW(300), _wantLabel.fontLineHeight);
    _wantLabel.centerY = _wantButton.centerY;
    
    
    _atOneceWantButton = [TDExpendClickButton buttonWithType:UIButtonTypeCustom];
    _atOneceWantButton.titleLabel.font = PFSC(30);
    [_atOneceWantButton setTitleColor:MGThemeColor_Title_Black forState:UIControlStateNormal];
    [_atOneceWantButton setTitle:@"立即听他的课" forState:UIControlStateNormal];
    _atOneceWantButton.backgroundColor = MGThemeYellowColor;
    _atOneceWantButton.layer.cornerRadius = MGButtonLayerCorner;
    
    _atOneceWantButton.frame = CGRectMake(frame.size.width - SW(224) - SW(30), 0, SW(224), SH(60));
    _atOneceWantButton.centerY = frame.size.height * 0.5;
    [_atOneceWantButton addTarget:self action:@selector(atOnceButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self sd_addSubviews:@[_wantButton, _wantLabel, _atOneceWantButton]];
    
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

- (void)wantButtonOnClick {
    if (_wantButton.selected) {
        return;
    }
    if (_wantBlock) {
        _wantBlock();
    }
}


- (void)atOnceButtonOnClick {
    if (_atOneceWantBlock) {
        _atOneceWantBlock();
    }
    
}

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter
- (void)setDataModel:(MGResCourseTutorDataModel *)dataModel {
    _dataModel = dataModel;
    
    self.wantButton.selected = dataModel.is_favor;
    
    
}

- (void)setWantButton:(BOOL)isWant {

    self.wantButton.selected = isWant;
}
@end
