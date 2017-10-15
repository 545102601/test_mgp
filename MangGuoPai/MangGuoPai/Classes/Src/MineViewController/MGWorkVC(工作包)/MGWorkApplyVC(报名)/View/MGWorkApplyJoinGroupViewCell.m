//
//  MGWorkApplyJoinGroupViewCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkApplyJoinGroupViewCell.h"

@interface MGWorkApplyJoinGroupViewCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *topBgView;

@property (nonatomic, strong) UILabel *prjectNameLabel;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UILabel *instruLabel;

@property (nonatomic, strong) UIButton *joinButton;

@end

@implementation MGWorkApplyJoinGroupViewCell

- (void)preapreCellUI {

    _bgView = [[UIView alloc] initWithFrame:CGRectMake(SW(30), 0, kScreenWidth - SW(60), kMGWorkApplyJoinGroupViewCellHeight)];
    _bgView.backgroundColor = [UIColor clearColor];
    _bgView.layer.borderWidth = MGSepLineHeight * 2;
    _bgView.layer.borderColor = MGSepColor.CGColor;
    _bgView.layer.cornerRadius = 5;
    _bgView.layer.masksToBounds = YES;
    
    _topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _bgView.width, kMGWorkApplyJoinGroupViewCellHeight - SH(140))];
    _topBgView.backgroundColor = [UIColor clearColor];
    
    _prjectNameLabel = [MGUITool labelWithText:nil textColor:colorHex(@"#252525") font:PFSC(30)];
    _prjectNameLabel.frame = CGRectMake(SW(30), SH(40), SW(440), _prjectNameLabel.fontLineHeight);
    
    _numberLabel = [MGUITool labelWithText:nil textColor:colorHex(@"#999999") font:PFSC(24) textAlignment:NSTextAlignmentRight];
    _numberLabel.frame = CGRectMake(_bgView.width - SW(180), 0, SW(150), _numberLabel.fontLineHeight);
    _numberLabel.centerY = _prjectNameLabel.centerY;
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(40), _prjectNameLabel.bottom + SH(30), SW(80), SW(80))];
    _iconImageView.layer.cornerRadius = SW(40);
    _iconImageView.layer.masksToBounds = YES;
    
    
    _nameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _nameLabel.frame = CGRectMake(_iconImageView.right + SW(20), 0, SW(500), _nameLabel.fontLineHeight);
    _nameLabel.centerY = _iconImageView.centerY;
    
    [_topBgView sd_addSubviews:@[_prjectNameLabel, _iconImageView, _nameLabel, _numberLabel]];
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _topBgView.bottom, _bgView.width, SH(140))];
    _bottomView.backgroundColor = RGB(251, 251, 251);
    
    _joinButton = [MGUITool buttonWithBGColor:nil title:@"+加入" titleColor:MGThemeColor_Title_Black font:MGThemeFont_28 target:self selector:@selector(joinButtonOnClick)];
    [_joinButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_joinButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    _joinButton.frame = CGRectMake(_bgView.width - SW(160) - SW(44), 0, SW(160), SW(60));
    _joinButton.centerY = _bottomView.height * 0.5;
    _joinButton.layer.cornerRadius = MGButtonLayerCorner;
    _joinButton.layer.masksToBounds = YES;
    
    
    /// 未设置高度 y
    _instruLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _instruLabel.frame = CGRectMake(SW(40), 0, _joinButton.left - SW(80), 0);
    
    [_bottomView sd_addSubviews:@[_joinButton, _instruLabel]];
    
    [_bgView sd_addSubviews:@[_topBgView, _bottomView]];
    
    [self.contentView addSubview:_bgView];
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
- (void)joinButtonOnClick {
    
    if (_joinBlock) {
        _joinBlock(self.dataModel);
    }
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter


- (void)setDataModel:(MGResProjectListTeamDataModel *)dataModel {
    _dataModel = dataModel;
    
    _prjectNameLabel.text = dataModel.team_name;
    
    _numberLabel.text = [NSString stringWithFormat:@"已有%zd人",dataModel.member_count];
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.avatar_rsurl] placeholderImage:SDWEB_PLACEHODER_IMAGE(_iconImageView)];
    
    
    if (dataModel.role_name.length > 0) {
        _nameLabel.text = [NSString stringWithFormat:@"发起人: %@  (%@)",dataModel.actor_name, dataModel.role_name];
    } else {
        _nameLabel.text = [NSString stringWithFormat:@"发起人: %@ ",dataModel.actor_name];
    }
    
    _instruLabel.text = dataModel.bulletin;
    
    _instruLabel.height = [_instruLabel.text heightForFont:_instruLabel.font width:_instruLabel.width];
    _instruLabel.centerY = _bottomView.height * 0.5;
    
}

@end
