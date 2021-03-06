//
//  MGWorkDetailApplyTeamSectionHeader.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/14.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkDetailApplyTeamSectionHeader.h"

@interface MGWorkDetailApplyTeamSectionHeader ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *applyTeamLabel;

@property (nonatomic, strong) UIButton *expendButton;

@end

@implementation MGWorkDetailApplyTeamSectionHeader


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    self.contentView.backgroundColor = [UIColor clearColor];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, SH(4), kScreenWidth, kMGWorkDetailApplyTeamSectionHeaderHeight - SH(4))];
    _bgView.backgroundColor = [UIColor whiteColor];
    
    _applyTeamLabel = [MGUITool labelWithText:@"报名团队" textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _applyTeamLabel.frame = CGRectMake(SW(30), SH(20), kScreenWidth * 0.5, _applyTeamLabel.fontLineHeight);
    
    _expendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _expendButton.titleLabel.font = PFSC(28);
    [_expendButton setTitle:@"展开" forState:UIControlStateNormal];
    [_expendButton setTitle:@"收回" forState:UIControlStateSelected];
    [_expendButton setTitleColor:MGThemeColor_Common_Black forState:UIControlStateNormal];
    [_expendButton setTitleColor:MGThemeColor_Common_Black forState:UIControlStateSelected];
    
    [_expendButton addTarget:self action:@selector(expendButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    [_expendButton sizeToFit];
    _expendButton.right = kScreenWidth - SW(30);
    _expendButton.centerY = _applyTeamLabel.centerY;
    
    [self.contentView sd_addSubviews:@[_bgView, _applyTeamLabel, _expendButton]];
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
- (void)expendButtonOnClick {
    _expendButton.selected = !_expendButton.isSelected;
    self.dataModel.teamIsExpend = _expendButton.isSelected;
    if (_expendButtonBlock) {
        _expendButtonBlock(self.section);
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
    
    _expendButton.hidden = dataModel.hiddenExpendButton;
    _expendButton.selected = dataModel.teamIsExpend;
}

@end
