//
//  MGWorkCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/30.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkCell.h"
#import "MGWorkProgressView.h"
#import "UIImage+Extend.h"

@interface MGWorkCell ()
/// 标题
@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *inviteLabel;
@property (nonatomic, strong) UIButton *inviteButton;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *processTipLabel;
@property (nonatomic, strong) MGWorkProgressView *progressView;
/// 关注人数
@property (nonatomic, strong) UILabel *attentionLabel;
/// 报名人数
@property (nonatomic, strong) UILabel *enterLabel;
@property (nonatomic, strong) UIView *bottomLineView;
/// 状态
@property (nonatomic, strong) UILabel *stateLabel;

@property (nonatomic, strong) UIButton *photoButton;
@property (nonatomic, strong) UIButton *teamButton;
@property (nonatomic, strong) UIButton *detailButton;

@end

@implementation MGWorkCell

- (void)preapreCellUI {
    
    _titleNameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _titleNameLabel.frame = CGRectMake(SW(30), SH(30), SW(500), _titleNameLabel.fontLineHeight);
    
    
    _inviteButton = [TDExpendClickButtonNotHightLight buttonWithType:UIButtonTypeCustom];
    UIImage *shareImage = [UIImage imageNamed:@"found_icon_share"];
    shareImage = [UIImage imageWithImage:shareImage scaledToSize:CGSizeMake(SW(54), SW(54))];
    [_inviteButton setImage:shareImage forState:UIControlStateNormal];
    
    _inviteButton.frame = CGRectMake(kScreenWidth - SW(44) - SW(34), 0, SW(54), SW(54));
    _inviteButton.centerY = _titleNameLabel.centerY - SH(2);
    _inviteButton.tag = 1000;
    [_inviteButton addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _inviteLabel = [MGUITool labelWithText:@"邀请投票" textColor:MGThemeColor_Title_Black font:PFSC(26)];
    _inviteLabel.textAlignment = NSTextAlignmentRight;
    _inviteLabel.frame = CGRectMake(_inviteButton.left - SW(2) - SW(200) , 0, SW(200), _inviteLabel.fontLineHeight);
    _inviteLabel.centerY = _titleNameLabel.centerY;
    
    _timeLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _timeLabel.frame = CGRectMake(SW(30), _titleNameLabel.bottom + SH(40), kScreenWidth - SW(60), _timeLabel.fontLineHeight);
    
    
    _processTipLabel = [MGUITool labelWithText:@"进度  " textColor:MGThemeColor_Common_Black font:PFSC(26)];
    [_processTipLabel sizeToFit];
    _processTipLabel.left = SW(30);
    _processTipLabel.top = _timeLabel.bottom + SH(52);
    
    _progressView = [[MGWorkProgressView alloc] initWithFrame:CGRectMake(_processTipLabel.right, 0, kScreenWidth - SW(30) - _processTipLabel.right, SH(20))];
    _progressView.centerY = _processTipLabel.centerY;
    
    
    _attentionLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24)];
    _attentionLabel.frame = CGRectMake(_progressView.left, _progressView.bottom + SH(30), kScreenWidth * 0.5, _attentionLabel.fontLineHeight);
    
    _enterLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24) textAlignment:NSTextAlignmentRight];
    _enterLabel.frame = CGRectMake(kScreenWidth - SW(30) - SW(120), _progressView.bottom + SH(30), SW(120), _enterLabel.fontLineHeight);

    
    _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _attentionLabel.bottom + SH(30), kScreenWidth - 2 * SW(24), MGSepLineHeight)];
    _bottomLineView.backgroundColor = MGSepColor;
    
    
    
    _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _detailButton.titleLabel.font = PFSC(28);
    [_detailButton setTitle:@"详情" forState:UIControlStateNormal];
    [_detailButton setTitleColor:MGThemeYellowColor forState:UIControlStateNormal];
    _detailButton.layer.cornerRadius = MGButtonLayerCorner;
    _detailButton.layer.borderWidth = MGSepLineHeight;
    _detailButton.layer.borderColor = MGThemeYellowColor.CGColor;
    _detailButton.frame = CGRectMake(kScreenWidth - SW(140) - SW(30), _bottomLineView.bottom + SH(20), SW(140), SH(60));
    _detailButton.tag = 1003;
    [_detailButton addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _teamButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _teamButton.titleLabel.font = PFSC(28);
    [_teamButton setTitle:@"团队" forState:UIControlStateNormal];
    [_teamButton setTitleColor:MGThemeColor_Common_Black forState:UIControlStateNormal];
    _teamButton.layer.cornerRadius = MGButtonLayerCorner;
    _teamButton.layer.borderWidth = MGSepLineHeight;
    _teamButton.layer.borderColor = MGThemeColor_Common_Black.CGColor;
    _teamButton.frame = CGRectMake(_detailButton.left - SW(140) - SW(20), _bottomLineView.bottom + SH(20), SW(140), SH(60));
    _teamButton.tag = 1002;
    [_teamButton addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _photoButton.titleLabel.font = PFSC(28);
    [_photoButton setTitle:@"作品" forState:UIControlStateNormal];
    [_photoButton setTitleColor:MGThemeColor_Common_Black forState:UIControlStateNormal];
    _photoButton.layer.cornerRadius = MGButtonLayerCorner;
    _photoButton.layer.borderWidth = MGSepLineHeight;
    _photoButton.layer.borderColor = MGThemeColor_Common_Black.CGColor;
    _photoButton.frame = CGRectMake(_teamButton.left - SW(140) - SW(30), _bottomLineView.bottom + SH(20), SW(140), SH(60));
    _photoButton.tag = 1001;
    [_photoButton addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _stateLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _stateLabel.frame = CGRectMake(SW(30), 0, SW(120), _enterLabel.fontLineHeight);
    _stateLabel.centerY = _detailButton.centerY;
    
    
    [self.contentView sd_addSubviews:@[_titleNameLabel, _inviteLabel, _inviteButton, _timeLabel, _processTipLabel, _progressView, _attentionLabel, _enterLabel, _bottomLineView, _detailButton, _teamButton, _photoButton, _stateLabel]];
    
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

/// 底部按钮点击   1000 是 邀请
- (void)buttonOnClick:(UIButton*)btn {
    
    if (_buttonEventBlock) {
        _buttonEventBlock(btn.tag, self.dataModel);
    }
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter
- (void)setDataModel:(MGResWorkListDataModel *)dataModel {
    _dataModel = dataModel;
    
    _titleNameLabel.text = dataModel.project_name;
    
    _timeLabel.text = [NSString stringWithFormat:@"起始  %@   报名  %@", dataModel.publish_time_str, dataModel.apply_abort_time_str];
    
    _progressView.progressNumber = dataModel.progress;
    
    _attentionLabel.text = [NSString stringWithFormat:@"关注   %zd人", dataModel.focus_count];

    _enterLabel.text = [NSString stringWithFormat:@"报名   %zd人", dataModel.applied_count];
    
    _stateLabel.text = dataModel.state_label;
    
    _teamButton.hidden = memberDataModelInstance.isCompanyID;
    
    _photoButton.hidden = memberDataModelInstance.isCompanyID;
    
    _inviteLabel.hidden = memberDataModelInstance.isCompanyID;
    
    if ([dataModel.actor_member_type isEqualToString:@"team"]) { /// 团队
        _teamButton.hidden = NO;
        _teamButton.left = _detailButton.left - SW(140) - SW(20);
        _photoButton.left = _teamButton.left - SW(140) - SW(30);
    } else {  /// 单人参加
        _teamButton.hidden = YES;
        _photoButton.left = _detailButton.left - SW(140) - SW(20);
    }
}
@end
