//
//  MGWorkDetailApplyTeamCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/14.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkDetailApplyTeamCell.h"

@interface MGWorkDetailApplyTeamCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleTextLabel;

@property (nonatomic, strong) UIButton *commentButton;

@property (nonatomic, strong) UIButton *productionButton;

@property (nonatomic, strong) UILabel *ticketLabel;

@end

@implementation MGWorkDetailApplyTeamCell

- (void)preapreCellUI {
   
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(SW(50), 0, kScreenWidth - SW(100), kMGWorkDetailApplyTeamCellHeight - SH(10))];
    _bgView.backgroundColor = RGB(238, 238, 238);
    
    _titleTextLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _titleTextLabel.frame = CGRectMake(SW(24), 0, SW(320), _titleTextLabel.fontLineHeight);
    _titleTextLabel.centerY = _bgView.height * 0.5;
    
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentButton setTitle:@"写评价" forState:UIControlStateNormal];
    [_commentButton setTitle:@"已评" forState:UIControlStateDisabled];
    _commentButton.titleLabel.font = PFSC(28);
    [_commentButton setTitleColor:MGThemeShenYellowColor forState:UIControlStateNormal];
    [_commentButton setTitleColor:MGThemeColor_Common_Black forState:UIControlStateDisabled];
    _commentButton.frame = CGRectMake(_bgView.width - SW(90) - SW(10), 0, SW(90), SH(50));
    _commentButton.centerY = _bgView.height * 0.5;
    [_commentButton addTarget:self action:@selector(commentButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _productionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_productionButton setTitle:@"看作品" forState:UIControlStateNormal];
    _productionButton.titleLabel.font = PFSC(28);
    [_productionButton setTitleColor:MGThemeColor_Red forState:UIControlStateNormal];
    
    _productionButton.frame = CGRectMake(_commentButton.left - SW(90) - SW(24), 0, SW(90), SH(50));
    _productionButton.centerY = _bgView.height * 0.5;
    [_productionButton addTarget:self action:@selector(productionButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _ticketLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28) textAlignment:NSTextAlignmentRight];
    _ticketLabel.frame = CGRectMake(_productionButton.left - SW(100) - SW(24), 0, SW(100), _ticketLabel.fontLineHeight);
    _ticketLabel.centerY = _bgView.height * 0.5;
    
    
    [_bgView sd_addSubviews:@[_productionButton, _commentButton, _titleTextLabel, _ticketLabel]];
    
    [self.contentView addSubview:_bgView];
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

- (void)productionButtonOnClick {
    
    if (_applyTeamProductBlock) {
        _applyTeamProductBlock(self.actorModel);
    }
    
}

- (void)commentButtonOnClick {
    
    if (_applyTeamCommentBlock) {
        _applyTeamCommentBlock(self.actorModel);
    }
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter
- (void)setActorModel:(MGResProjectActorDataModel *)actorModel {
    _actorModel = actorModel;
    
    _titleTextLabel.text = actorModel.actor_name;
    
    _ticketLabel.text = [NSString stringWithFormat:@"%zd票", actorModel.vote_count];
    
    _commentButton.enabled = actorModel.company_comments.length == 0 ? YES : NO;
    
    
}

@end
