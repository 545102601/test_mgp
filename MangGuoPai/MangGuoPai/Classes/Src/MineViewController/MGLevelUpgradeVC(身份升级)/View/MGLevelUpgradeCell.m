//
//  MGLevelUpgradeCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/21.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGLevelUpgradeCell.h"

@interface MGLevelUpgradeCell ()

@property (nonatomic, strong) UIButton *levelButton;

@property (nonatomic, strong) UILabel *titleTipLabel;

@property (nonatomic, strong) UILabel *contentTipLabel;


@end

@implementation MGLevelUpgradeCell

- (void)preapreCellUI {

    _levelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _levelButton.frame = CGRectMake(SW(30), SH(36), SW(78), SW(78));
    
    
    _titleTipLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(36)];
    _titleTipLabel.frame = CGRectMake(_levelButton.right + SH(15), SH(36), SW(300), _titleTipLabel.fontLineHeight);
    
    _contentTipLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24)];
    _contentTipLabel.frame = CGRectMake(_titleTipLabel.left, _titleTipLabel.bottom + SH(12), kScreenWidth - SW(30) - _titleTipLabel.left, 0);
    
    [self.contentView sd_addSubviews:@[_levelButton, _titleTipLabel, _contentTipLabel]];
    
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

- (void)setModel:(MGLevelUpgradeTableModel *)model {
    _model = model;

    [_levelButton setBackgroundImage:[UIImage imageNamed:model.levelImageNor] forState:UIControlStateNormal];
    [_levelButton setBackgroundImage:[UIImage imageNamed:model.levelImageSel] forState:UIControlStateSelected];
    
    _levelButton.selected = model.isSelected;
    
    _titleTipLabel.text = model.titleName;
    
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:SH(10)];
    UIColor *color = MGThemeColor_Common_Black;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:model.contentName attributes:@{NSFontAttributeName : PFSC(24),NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle}];
    
    
    _contentTipLabel.attributedText = string;
    
    _contentTipLabel.height = [string boundingRectWithSize:CGSizeMake(_contentTipLabel.width, HUGE) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
}
@end
