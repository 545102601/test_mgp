//
//  MGMineCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/17.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMineCell.h"

@interface MGMineCell ()
/// 图标
@property (nonatomic, strong) UIImageView *iconImageView;
///
@property (nonatomic, strong) UILabel *titleLabel;
/// 子标题
@property (nonatomic, strong) UILabel *subTitleLabel;

/// 箭头
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation MGMineCell

- (void)preapreCellUI {
    
    _iconImageView = [[UIImageView alloc] init];
    
    _titleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    
    _subTitleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28) textAlignment:NSTextAlignmentRight];
    
    _arrowImageView = [[UIImageView alloc] init];
    _arrowImageView.image = [UIImage imageNamed:@"mine_more_2"];
    
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = MGSepColor;
    
    [self.contentView sd_addSubviews:@[_iconImageView, _titleLabel, _subTitleLabel, _arrowImageView, _lineView]];
}

- (void)preapreCellFrame {
    
    
    _iconImageView.sd_layout
    .leftSpaceToView(self.contentView, SW(38))
    .centerYEqualToView(self.contentView)
    .widthIs(SW(44))
    .heightEqualToWidth();
    
    
    _titleLabel.sd_layout
    .leftSpaceToView(_iconImageView, SW(18))
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, SW(40))
    .heightIs(_titleLabel.fontLineHeight);
    
    
    _arrowImageView.sd_layout
    .rightSpaceToView(self.contentView, SW(26))
    .centerYEqualToView(self.contentView)
    .widthIs(SW(44))
    .heightIs(SW(44));
    
    _subTitleLabel.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(_arrowImageView, SW(2))
    .widthIs(kScreenWidth * 0.4)
    .heightIs(_subTitleLabel.fontLineHeight);
    
    
    _lineView.sd_layout
    .leftSpaceToView(self.contentView, SW(0))
    .rightEqualToView(self.contentView)
    .bottomSpaceToView(self.contentView, 0)
    .heightIs(MGSepLineHeight);
}


- (void)setModel:(MGMineTableViewModel *)model {
    _model = model;
    
    self.titleLabel.text = model.title;
    
    self.iconImageView.image = [UIImage imageNamed:model.icon];
    
    self.subTitleLabel.text = model.subTtile;
    
    self.lineView.hidden = self.hiddenLine;
}

@end
