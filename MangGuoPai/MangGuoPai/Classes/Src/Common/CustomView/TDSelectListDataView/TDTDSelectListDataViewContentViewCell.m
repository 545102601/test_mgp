//
//  TDTDSelectListDataViewContentViewCell.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/7/6.
//  Copyright © 2017年 梦创. All rights reserved.
//

#import "TDTDSelectListDataViewContentViewCell.h"


@interface TDTDSelectListDataViewContentViewCell ()
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 钩
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation TDTDSelectListDataViewContentViewCell


- (void)preapreCellUI {
    
    
//    self.contentView.backgroundColor = colorHex(@"#EDEFF3");
    
    _titleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    
    
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.image = [UIImage imageNamed:@"mine_icon_play"];
    _iconImageView.hidden = YES;
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = MGSepColor;
    
    
    [self.contentView sd_addSubviews:@[_titleLabel, _iconImageView, _lineView]];
    
    _titleLabel.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView, SW(20))
    .heightIs(_titleLabel.fontLineHeight);
    
    _iconImageView.sd_layout
    .centerYEqualToView(self.contentView)
    .widthIs(SW(24))
    .heightIs(SW(24));
    
    _lineView.sd_layout
    .bottomEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(MGSepLineHeight);
    
}

- (void)setModel:(TDSelectListDataViewContentModel *)model {
    _model = model;

    _titleLabel.text = model.name;
    
    CGFloat width = [_titleLabel.text boundingRectWithSize:CGSizeMake(HUGE, _titleLabel.fontLineHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : PFSC(28)} context:nil].size.width;
    
    _titleLabel.sd_layout.widthIs(width);
    _iconImageView.sd_layout.leftSpaceToView(_titleLabel, SW(10));
    
    _iconImageView.hidden = !model.isSelected;

    _lineView.hidden = self.hiddenBottomLine;
    
}



@end
