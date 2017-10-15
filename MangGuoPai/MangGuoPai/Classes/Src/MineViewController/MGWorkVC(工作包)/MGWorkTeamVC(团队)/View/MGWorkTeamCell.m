//
//  MGWorkTeamCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/13.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkTeamCell.h"

@interface MGWorkTeamCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleTextLabel;

@property (nonatomic, strong) UILabel *subTitleTextLabel;

@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation MGWorkTeamCell

- (void)preapreCellUI {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(40), 0, SW(80), SW(80))];
    _iconImageView.centerY = kMGWorkTeamCellHeight * 0.5;
    _iconImageView.layer.cornerRadius = _iconImageView.width * 0.5;
    _iconImageView.layer.masksToBounds = YES;
    
    _titleTextLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _titleTextLabel.frame = CGRectMake(_iconImageView.right + SW(20), 0, SW(450), _titleTextLabel.fontLineHeight);
    _titleTextLabel.centerY = _iconImageView.centerY;
    
    _subTitleTextLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28) textAlignment:NSTextAlignmentRight];
    _subTitleTextLabel.frame = CGRectMake(kScreenWidth - SW(150) - SW(30), 0, SW(150), _subTitleTextLabel.fontLineHeight);
    _subTitleTextLabel.centerY = _iconImageView.centerY;
    
    _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), kMGWorkTeamCellHeight - MGSepLineHeight, kScreenWidth - SW(48), MGSepLineHeight)];
    _bottomLineView.backgroundColor = MGSepColor;
    
    [self.contentView sd_addSubviews:@[_iconImageView, _titleTextLabel, _subTitleTextLabel, _bottomLineView]];

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

- (void)setDataModel:(MGResProjectTeamMemberDataModel *)dataModel {
    _dataModel = dataModel;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.avatar_rsurl] placeholderImage:SDWEB_PLACEHODER_IMAGE(_iconImageView)];
    
    if (dataModel.role_name.length > 0) {
        _titleTextLabel.text = [NSString stringWithFormat:@"%@ ( %@ )",dataModel.nick_name, dataModel.role_name];
    } else {
        _titleTextLabel.text = [NSString stringWithFormat:@"%@ ",dataModel.nick_name];
    }
    
    _subTitleTextLabel.text = memberDataModelInstance.id == dataModel.member_id ? @"本人" : @"";
    
}

@end
