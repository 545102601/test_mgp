//
//  MGAccountCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGAccountCell.h"

@interface MGAccountCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation MGAccountCell

- (void)preapreCellUI {

    CGFloat cellHeight = SH(98);
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(30) , 0, SW(44), SW(44))];
    _iconImageView.centerY = cellHeight * 0.5;
    
    
    _titleNameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _titleNameLabel.frame = CGRectMake(_iconImageView.right + SW(16), 0, kScreenWidth * 0.5, _titleNameLabel.fontLineHeight);
    _titleNameLabel.centerY = _iconImageView.centerY;
    
    _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - SW(44), 0, SW(44), SW(44))];
    _arrowImageView.image = [UIImage imageNamed:@"mine_more_2"];
    _arrowImageView.centerY = _iconImageView.centerY;;
    
    
    _subTitleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_subTitle_Black font:PFSC(30) textAlignment:NSTextAlignmentRight];
    _subTitleLabel.frame = CGRectMake(_arrowImageView.left - kScreenWidth * 0.5 + SW(5), 0, kScreenWidth * 0.5, _subTitleLabel.fontLineHeight);
    _subTitleLabel.centerY = _iconImageView.centerY;
    
    
    _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(30), cellHeight - MGSepLineHeight, kScreenWidth - SW(60), MGSepLineHeight)];
    _bottomLineView.backgroundColor = MGSepColor;
    
    
    
    [self.contentView sd_addSubviews:@[_iconImageView, _arrowImageView, _bottomLineView, _titleNameLabel, _subTitleLabel]];
    
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter
- (void)setTableModel:(MGAccountTableModel *)tableModel {

    _tableModel = tableModel;
    
    _iconImageView.image = [UIImage imageNamed:_tableModel.iconName];
    _titleNameLabel.text = _tableModel.titleName;
    _subTitleLabel.text = _tableModel.subTitleName;
    
    _bottomLineView.hidden = self.isHiddenBottomLine;
}

@end
