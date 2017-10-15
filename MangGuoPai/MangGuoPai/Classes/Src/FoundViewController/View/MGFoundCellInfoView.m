//
//  MGFoundCellInfoView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/4.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGFoundCellInfoView.h"

@interface MGFoundCellInfoView ()
/// icon
@property (nonatomic, strong) UIImageView *iconImageView;
/// username
@property (nonatomic, strong) UILabel *userNameLabel;
/// 时间
@property (nonatomic, strong) UILabel *timeLabel;
/// 收藏按钮
@property (nonatomic, strong) UIButton *favButton;

@end


@implementation MGFoundCellInfoView

- (void)prepareFrameViewUI:(CGRect)frame {

    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(28), SH(40), SW(80), SW(80))];
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.layer.cornerRadius = SW(40);
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    _userNameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _userNameLabel.frame = CGRectMake(_iconImageView.right + SW(20), SH(42), SW(480), _userNameLabel.fontLineHeight);
    
    
    _timeLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_subTitle_Black font:PFSC(24)];
    _timeLabel.frame = CGRectMake(_userNameLabel.left, _userNameLabel.bottom + SH(10), SW(200), _timeLabel.fontLineHeight);
    
    
    _favButton = [TDExpendClickButtonNotHightLight buttonWithType:UIButtonTypeCustom];
    [_favButton setImage:[UIImage imageNamed:@"found_icon_shoucang_nor"] forState:UIControlStateNormal];
    [_favButton setImage:[UIImage imageNamed:@"found_icon_shoucang_pressed"] forState:UIControlStateSelected];
    _favButton.frame = CGRectMake(frame.size.width - SW(26) - SW(44), 0, SW(44), SW(44));
    _favButton.centerY = _userNameLabel.centerY;
    [_favButton addTarget:self action:@selector(favButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self sd_addSubviews:@[_iconImageView, _userNameLabel, _timeLabel, _favButton]];
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 收藏
- (void)favButtonOnClick {
    
    if (_favEventBlock) {
        _favEventBlock(self.dataModel, self.indexPath);
    }
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function
/// 设置是否收藏
- (void)setFavIsCollection:(BOOL)collection {
    
//    _favButton.selected = collection;

}
#pragma mark - Private Function

#pragma mark - Getter and Setter

- (void)setDataModel:(MGResTrendListDataModel *)dataModel {
    _dataModel = dataModel;
    
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.avatar_rsurl] placeholderImage:SDWEB_PLACEHODER_IMAGE_ICON];
    
    _userNameLabel.text = dataModel.publisher_name;
    
    _timeLabel.text = dataModel.publish_time_str;
    
#warning todo 未处理 收藏
    
}

@end
