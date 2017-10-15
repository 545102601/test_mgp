//
//  MGWorkDetailMoneyCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/30.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkDetailMoneyCell.h"

@interface MGWorkDetailMoneyCell ()

@property (nonatomic, strong) UILabel *prizesLabel;

@property (nonatomic, strong) UILabel *prizesContentLabel;

@property (nonatomic, strong) UIButton *expendButton;


@end

@implementation MGWorkDetailMoneyCell

- (void)preapreCellUI {
    
    _prizesLabel = [MGUITool labelWithText:@"奖品奖金" textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _prizesLabel.frame = CGRectMake(SW(30), SH(20), kScreenWidth * 0.5, _prizesLabel.fontLineHeight);
    
    _prizesContentLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _prizesContentLabel.frame = CGRectMake(SW(40), _prizesLabel.bottom + SH(20), kScreenWidth - SW(80), 0);
    
    _expendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _expendButton.titleLabel.font = PFSC(28);
    [_expendButton setTitle:@"展开" forState:UIControlStateNormal];
    [_expendButton setTitle:@"收回" forState:UIControlStateSelected];
    [_expendButton setTitleColor:MGThemeColor_Common_Black forState:UIControlStateNormal];
    [_expendButton setTitleColor:MGThemeColor_Common_Black forState:UIControlStateSelected];
    
    [_expendButton addTarget:self action:@selector(expendButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    [_expendButton sizeToFit];
    _expendButton.right = kScreenWidth - SW(30);
    _expendButton.centerY = _prizesLabel.centerY;
    
    [self.contentView sd_addSubviews:@[_prizesLabel, _prizesContentLabel, _expendButton]];

}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

- (void)expendButtonOnClick {
    _expendButton.selected = !_expendButton.isSelected;
    self.dataModel.prizesIsExpend = _expendButton.isSelected;
    if (_expendButtonBlock) {
        _expendButtonBlock(self.indexPath);
    }
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter
- (void)setDataModel:(MGResProjectDetailDataModel *)dataModel {
    _dataModel = dataModel;
    
    if (dataModel.prizesIsExpend) {
        _prizesContentLabel.attributedText = dataModel.prizesContentAttr;
        _prizesContentLabel.height = dataModel.prizesContentHeight;
    } else {
        _prizesContentLabel.attributedText = nil;
        _prizesContentLabel.height = 0;
    }    
    _expendButton.hidden = dataModel.hiddenExpendButton;
    _expendButton.selected = dataModel.prizesIsExpend;
}
@end
