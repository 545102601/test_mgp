//
//  MGFavListCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGFavListCell.h"

@interface MGFavListCell ()

/// icon
@property (nonatomic, strong) UIImageView *iconImageView;
/// username
@property (nonatomic, strong) UILabel *userNameLabel;
/// time
@property (nonatomic, strong) UILabel *timeLabel;
/// content
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation MGFavListCell

- (void)preapreCellUI {

    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(34), SH(39), SW(90), SW(90))];
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.layer.cornerRadius = SW(45);
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    _userNameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _userNameLabel.frame = CGRectMake(_iconImageView.right + SW(20), SH(34), SW(450), _userNameLabel.fontLineHeight);
    
    /// 时间
    _timeLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Placeholder_Black font:PFSC(24) textAlignment:NSTextAlignmentRight];
    _timeLabel.frame = CGRectMake(kScreenWidth - SW(34) - SW(200), 0, SW(200), _timeLabel.fontLineHeight);
    _timeLabel.centerY = _userNameLabel.centerY;
    
    _contentLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Placeholder_Black font:PFSC(24)];
    _contentLabel.numberOfLines = 2;
    
    _contentLabel.frame = CGRectMake(_userNameLabel.left, _userNameLabel.bottom + SH(20), SW(560), SH(75));
    
    
    [self.contentView sd_addSubviews:@[_iconImageView, _userNameLabel, _timeLabel, _contentLabel]];

}


- (void)setDataModel:(MGResFavListDataModel *)dataModel{
    _dataModel = dataModel;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.logo_rsurl] placeholderImage:SDWEB_PLACEHODER_IMAGE_ICON];
    
    _userNameLabel.text = dataModel.entity_name;
#warning TODO 未处理
    _contentLabel.text = dataModel.entity_name;
    
    CGFloat cHeight = [dataModel.entity_name heightForFont:PFSC(24) width:_contentLabel.width];
    
    if (cHeight > SH(75)) {
        cHeight = SH(75);
    }
    _contentLabel.height = cHeight;
    
    
    _timeLabel.text = @"01/12";
    
}


@end
