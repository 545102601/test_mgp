//
//  MGMineSettingView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/23.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMineSettingView.h"

@implementation MGMineSettingView

- (void)prepareViewUI {
    
    self.backgroundColor = MGThemeColor_White;
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTap)]];
    
    /// 默认隐藏
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.hidden = YES;
    
    _titleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(28)];
    
    _subTitlelabel = [MGUITool labelWithText:nil textColor:MGThemeColor_subTitle_Black font:PFSC(28) textAlignment:NSTextAlignmentRight];
    
    _arrowImageView = [[UIImageView alloc] init];
    _arrowImageView.image = [UIImage imageNamed:@"mine_more_2"];
    
    _bottomLine = [[UIView alloc] init];
    _bottomLine.backgroundColor = MGSepColor;
    
    [self sd_addSubviews:@[_iconImageView, _titleLabel, _subTitlelabel, _arrowImageView, _bottomLine]];
    
}


- (void)prepareFrameViewUI {
    
    _iconImageView.frame = CGRectMake(SW(30), 0, SW(40), SH(40));
    _iconImageView.centerY = self.height * 0.5;
    
    _titleLabel.frame = CGRectMake(SW(30), 0, SW(300), _titleLabel.fontLineHeight);
    _titleLabel.centerY = self.height * 0.5;
    
    _arrowImageView.frame = CGRectMake(self.width - SW(60), 0, SW(44), SW(44));
    _arrowImageView.centerY = self.height * 0.5;
    
    
    _subTitlelabel.frame = CGRectMake(_arrowImageView.left - SW(400), 0, SW(400), _subTitlelabel.fontLineHeight);
    _subTitlelabel.centerY = self.height * 0.5;
    
    
    _bottomLine.frame = CGRectMake(SW(30), self.height - MGSepLineHeight, self.width - SW(60), MGSepLineHeight);
    
}

- (void)bgTap {
    
    if (_backgroundTapBlock) {
        _backgroundTapBlock();
    }
    if (_backgroundTapWithTagBlock) {
        _backgroundTapWithTagBlock(self.tag);
    }
}

- (void)setCustomSubView:(UIView *)customSubView {
    
    if (!_customSubView) {
        _customSubView = customSubView;
        /// 隐藏子标题
        _subTitlelabel.hidden = YES;
        [self addSubview:_customSubView];
    };
    
}


/// 隐藏右边按钮
- (void)setArrowImageHidden {
    
    _arrowImageView.hidden = YES;
    
    _subTitlelabel.right = self.width - SW(30);
    
}
/// 隐藏底部线条隐藏
- (void)setBottomLineHidden {
    
    _bottomLine.hidden = YES;
    
}

- (void)setIconImageNotHidden {
    _iconImageView.hidden = NO;
    
    _titleLabel.frame = CGRectMake(_iconImageView.right + SW(30), 0, SW(300), _titleLabel.fontLineHeight);
}


@end
