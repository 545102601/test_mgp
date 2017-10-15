//
//  MGPayOrderWayCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/1.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGPayOrderWayCell.h"

@interface MGPayOrderWayCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *wayNamelLabel;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation MGPayOrderWayCell

- (void)preapreCellUI {

    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(30), 0, SW(62), SW(62))];
    
    _wayNamelLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _wayNamelLabel.frame = CGRectMake(_iconImageView.right + SW(38), 0, kScreenWidth * 0.5, _wayNamelLabel.fontLineHeight);
    
    _selectButton = [TDExpendClickButtonNotHightLight buttonWithType:UIButtonTypeCustom];
    
    [_selectButton setImage:[UIImage imageWithColor:[UIColor greenColor] size:CGSizeMake(SW(44), SW(44))] forState:UIControlStateNormal];
    
    [_selectButton setImage:[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(SW(44), SW(44))] forState:UIControlStateSelected];
    _selectButton.frame = CGRectMake(kScreenWidth - SW(27) - SW(44), 0, SW(44), SW(44));
    
    [_selectButton addTarget:self action:@selector(didOnClickSelected) forControlEvents:UIControlEventTouchUpInside];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(SW(30), 0, kScreenWidth - SW(60), MGSepLineHeight)];
    _lineView.backgroundColor = MGSepColor;
    [self.contentView sd_addSubviews:@[_iconImageView, _wayNamelLabel, _selectButton, _lineView]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _iconImageView.centerY = self.contentView.centerY;
    _wayNamelLabel.centerY = self.contentView.centerY;
    _selectButton.centerY = self.contentView.centerY;
    
    _lineView.bottom = self.contentView.height;
    
}

- (void)setModel:(MGPayOrderWayModel *)model {
    _model = model;
    
    _iconImageView.image = [UIImage imageNamed:model.iconName];
    
    _wayNamelLabel.text = model.titleName;
    
    _selectButton.selected = model.isSelected;
    
}

- (void)didOnClickSelected {
    if (_didOnClickSelectedBlock) {
        _didOnClickSelectedBlock(self.indexPath);
    }
    
}

@end
