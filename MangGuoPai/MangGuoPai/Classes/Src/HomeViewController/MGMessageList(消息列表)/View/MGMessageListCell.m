//
//  MGMessageListCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMessageListCell.h"

@interface MGMessageListCell ()

/// icon
@property (nonatomic, strong) UIImageView *iconImageView;
/// username
@property (nonatomic, strong) UILabel *userNameLabel;
/// time
@property (nonatomic, strong) UILabel *timeLabel;
/// content
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *isReadImageView;

@end

@implementation MGMessageListCell



- (void)preapreCellUI {
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(34), SH(20), SW(86), SW(86))];
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.layer.cornerRadius = SW(86) * 0.5;
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    
    
    _userNameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _userNameLabel.frame = CGRectMake(_iconImageView.right + SW(20), SH(30), SW(450), _userNameLabel.fontLineHeight);
    
    /// 时间
    _timeLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Placeholder_Black font:PFSC(24) textAlignment:NSTextAlignmentRight];
    _timeLabel.frame = CGRectMake(kScreenWidth - SW(30) - SW(200), 0, SW(200), _timeLabel.fontLineHeight);
    _timeLabel.centerY = _userNameLabel.centerY;
    
    _contentLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Placeholder_Black font:PFSC(24)];
    _contentLabel.numberOfLines = 1;
    
    _contentLabel.frame = CGRectMake(_userNameLabel.left, _userNameLabel.bottom + SH(12), SW(560), _contentLabel.fontLineHeight);
    
    _isReadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _isReadImageView.image = [UIImage imageNamed:@"message_unread"];
    _isReadImageView.centerY = _contentLabel.centerY;
    _isReadImageView.right = _timeLabel.right;
    
    [self.contentView sd_addSubviews:@[_iconImageView, _userNameLabel, _timeLabel, _contentLabel, _isReadImageView]];
    
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
- (void)setDataModel:(MGResMessageDataModel *)dataModel {
    _dataModel = dataModel;

    self.iconImageView.image = [UIImage imageNamed:@"mine_manguo_fx"];
    
    self.timeLabel.text = dataModel.create_time_label;
    
    self.userNameLabel.text = dataModel.send_user_name;
    
    NSMutableString *strM = [NSString stringWithFormat:@"%@:%@",dataModel.title, dataModel.result].mutableCopy;
    
    if (dataModel.remark.length > 0) {
        [strM appendFormat:@",%@",dataModel.remark];
    }
    
    self.contentLabel.text = strM;
    
    self.isReadImageView.hidden = dataModel.isRead;
}

@end
