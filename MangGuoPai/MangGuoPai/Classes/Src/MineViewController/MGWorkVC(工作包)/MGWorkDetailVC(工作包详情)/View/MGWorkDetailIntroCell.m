//
//  MGWorkDetailIntroCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/30.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkDetailIntroCell.h"

@interface MGWorkDetailIntroCell ()

@property (nonatomic, strong) UILabel *entryLabel;

@property (nonatomic, strong) UILabel *entryContentLabel;

@property (nonatomic, strong) UIButton *expendButton;

@end

@implementation MGWorkDetailIntroCell

- (void)preapreCellUI {
    _entryLabel = [MGUITool labelWithText:@"参赛说明" textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _entryLabel.frame = CGRectMake(SW(30), SH(20), kScreenWidth * 0.5, _entryLabel.fontLineHeight);
    
    _entryContentLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _entryContentLabel.frame = CGRectMake(SW(40), _entryLabel.bottom + SH(20), kScreenWidth - SW(80), 0);
    
    _expendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _expendButton.titleLabel.font = PFSC(28);
    [_expendButton setTitle:@"展开" forState:UIControlStateNormal];
    [_expendButton setTitle:@"收回" forState:UIControlStateSelected];
    [_expendButton setTitleColor:MGThemeColor_Common_Black forState:UIControlStateNormal];
    [_expendButton setTitleColor:MGThemeColor_Common_Black forState:UIControlStateSelected];
    
    [_expendButton addTarget:self action:@selector(expendButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    [_expendButton sizeToFit];
    _expendButton.right = kScreenWidth - SW(30);
    _expendButton.centerY = _entryLabel.centerY;
    
    [self.contentView sd_addSubviews:@[_entryLabel, _entryContentLabel, _expendButton]];
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

- (void)expendButtonOnClick {
    _expendButton.selected = !_expendButton.isSelected;
    self.dataModel.entryIsExpend = _expendButton.isSelected;
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
    
    if (dataModel.entryIsExpend) {
        _entryContentLabel.attributedText = dataModel.entryContentAttr;
        _entryContentLabel.height = dataModel.entryContentHeight;
    } else {
        _entryContentLabel.attributedText = nil;
        _entryContentLabel.height = 0;
    }
    _expendButton.hidden = dataModel.hiddenExpendButton;
    _expendButton.selected = dataModel.entryIsExpend;
}
@end
