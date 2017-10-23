//
//  MGMineTableHeaderView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/16.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMineTableHeaderView.h"
#import "UIButton+NYImageLocation.h"

@interface MGMineTableHeaderView ()
/// 黄色
@property (nonatomic, strong) UIView *backgroundView;
/// 白色
@property (nonatomic, strong) UIView *twoBackgroundView;

/// 内容
@property (nonatomic, strong) UIView *cotentInfoView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *updateInfoLabel;
@property (nonatomic, strong) UIImageView *updateInfoArrowImageView;
/// 收藏 - 消息 - 动态
@property (nonatomic, strong) UIButton *favButton;
@property (nonatomic, strong) UILabel *favCountLabel;
@property (nonatomic, strong) UIButton *msgButton;
@property (nonatomic, strong) UILabel *msgCountLabel;
@property (nonatomic, strong) UIButton *friendButton;
@property (nonatomic, strong) UILabel *friendCountLabel;



@end

@implementation MGMineTableHeaderView

- (void)prepareFrameViewUI:(CGRect)frame {
    
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(340))];
    _backgroundView.backgroundColor = MGThemeBackgroundColor;
    
    _twoBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(SW(40), SH(120), kScreenWidth - SW(80), SH(340))];
    _twoBackgroundView.backgroundColor = [UIColor whiteColor];
    _twoBackgroundView.layer.cornerRadius = SH(8);
    //添加阴影效果
    _twoBackgroundView.layer.shadowColor = [UIColor blackColor].CGColor;
    _twoBackgroundView.layer.shadowOffset = CGSizeMake(0, 2);
    _twoBackgroundView.layer.shadowOpacity = 0.2;
    
    
    _cotentInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, frame.size.height - SH(48))];
    /// 头像
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SH(60), SW(120), SW(120))];
    _iconImageView.centerX = kScreenWidth * 0.5;
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    _iconImageView.layer.cornerRadius = SW(60);
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _iconImageView.layer.borderWidth = SW(3);
    _iconImageView.image = [UIImage imageNamed:@"mine_user_women"];
    _iconImageView.userInteractionEnabled = YES;
    [_iconImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateInfoTap)]];
    
    
    /// 用户名
    _nameLabel = [MGUITool labelWithText:@"用户名" textColor:colorHex(@"#252525") font:PFSC(34) textAlignment:NSTextAlignmentCenter];
    _nameLabel.frame = CGRectMake(0, _iconImageView.bottom + SH(10), kScreenWidth, PFSC(34).lineHeight);
    _nameLabel.userInteractionEnabled = YES;
    [_nameLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateInfoTap)]];
    
    
    
    _updateInfoLabel = [MGUITool labelWithText:@"请登录" textColor:MGThemeColor_Common_Black font:PFSC(24)];
    _updateInfoLabel.frame = CGRectMake(0, _nameLabel.bottom + SH(24), 0, 0);
    _updateInfoLabel.numberOfLines = 1;
    
    _updateInfoLabel.userInteractionEnabled = YES;
    [_updateInfoLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateInfoTap)]];
    
    _updateInfoArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _updateInfoArrowImageView.image = [UIImage imageNamed:@"mine_more"];
    _updateInfoArrowImageView.size = CGSizeMake(SW(44), SH(44));
    /// 默认隐藏
    _updateInfoArrowImageView.hidden = YES;
    _updateInfoArrowImageView.userInteractionEnabled = YES;
    [_updateInfoArrowImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateInfoTap)]];
    
    
    _favButton = [TDExpendClickButtonNotHightLight buttonWithType:UIButtonTypeCustom];
    [_favButton setTitle:@"收藏" forState:UIControlStateNormal];
    [_favButton setTitleColor:MGThemeColor_Title_Black forState:UIControlStateNormal];
    _favButton.titleLabel.font = PFSC(24);
    [_favButton setImage:[UIImage imageNamed:@"mine_icon_shoucang"] forState:UIControlStateNormal];
    _favButton.frame = CGRectMake(SW(112), 0, SW(120), SW(90) + SH(8) + PFSC(24).lineHeight);
    _favButton.tag = 1001;
    [_favButton addTarget:self action:@selector(smallButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    _favCountLabel = [MGUITool labelWithText:@"一" textColor:MGThemeColor_Title_Black font:PFSC(48)textAlignment:NSTextAlignmentCenter];
    _favCountLabel.frame = CGRectMake(0, _favButton.bottom +  SH(15), SW(90), _favCountLabel.fontLineHeight);
    _favCountLabel.centerX = _favButton.centerX;
    
    
    _msgButton = [TDExpendClickButtonNotHightLight buttonWithType:UIButtonTypeCustom];
    [_msgButton setTitle:@"消息" forState:UIControlStateNormal];
    [_msgButton setTitleColor:MGThemeColor_Title_Black forState:UIControlStateNormal];
    _msgButton.titleLabel.font = PFSC(24);
    
    [_msgButton setImage:[UIImage imageNamed:@"mine_icon_xiaox"] forState:UIControlStateNormal];
    _msgButton.frame = CGRectMake(SW(0), 0, SW(120), SW(90) + SH(8) + PFSC(24).lineHeight);
    _msgButton.centerX = kScreenWidth * 0.5;
    _msgButton.tag = 1002;
    [_msgButton addTarget:self action:@selector(smallButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _msgCountLabel = [MGUITool labelWithText:@"一" textColor:MGThemeColor_Title_Black font:PFSC(48)textAlignment:NSTextAlignmentCenter];
    _msgCountLabel.frame = CGRectMake(0,_msgButton.bottom +  SH(15), SW(90), _favCountLabel.fontLineHeight);
    _msgCountLabel.centerX = _msgButton.centerX;
    
    
    _friendButton = [TDExpendClickButtonNotHightLight buttonWithType:UIButtonTypeCustom];
    [_friendButton setTitle:@"动态" forState:UIControlStateNormal];
    [_friendButton setTitleColor:MGThemeColor_Title_Black forState:UIControlStateNormal];
    _friendButton.titleLabel.font = PFSC(24);
    
    [_friendButton setImage:[UIImage imageNamed:@"mine_icon_pinglun"] forState:UIControlStateNormal];
    _friendButton.frame = CGRectMake(kScreenWidth - SW(120) - SW(112),0 ,  SW(120), SW(90) + SH(8) + PFSC(24).lineHeight);
    _friendButton.tag = 1003;
    [_friendButton addTarget:self action:@selector(smallButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _friendCountLabel = [MGUITool labelWithText:@"一" textColor:MGThemeColor_Title_Black font:PFSC(48)textAlignment:NSTextAlignmentCenter];
    _friendCountLabel.frame = CGRectMake(0, _friendButton.bottom + SH(15), SW(90), _favCountLabel.fontLineHeight);
    _friendCountLabel.centerX = _friendButton.centerX;
    
    [_cotentInfoView sd_addSubviews:@[_iconImageView, _nameLabel, _updateInfoLabel, _updateInfoArrowImageView, _favButton, _favCountLabel, _msgButton, _msgCountLabel, _friendButton, _friendCountLabel]];
    
    
    [self sd_addSubviews:@[_backgroundView, _twoBackgroundView, _cotentInfoView]];
    
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_updateInfoLabel sizeToFit];
    _updateInfoLabel.centerX = kScreenWidth * 0.5;
    
    _updateInfoArrowImageView.left = _updateInfoLabel.right + SW(6);
    _updateInfoArrowImageView.centerY = _updateInfoLabel.centerY;
    
    _favButton.top = _updateInfoLabel.bottom + SH(0);
    _msgButton.top = _updateInfoLabel.bottom + SH(0);
    _friendButton.top = _updateInfoLabel.bottom + SH(0);
    
    [_favButton setImageLocation:NYImageLocationTop spacing:SH(8)];
    [_msgButton setImageLocation:NYImageLocationTop spacing:SH(8)];
    [_friendButton setImageLocation:NYImageLocationTop spacing:SH(8)];
    
    _favCountLabel.top = _favButton.bottom - SH(20);
    _msgCountLabel.top = _msgButton.bottom - SH(20);
    _friendCountLabel.top = _friendButton.bottom - SH(20);
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 修改个人信息
- (void)updateInfoTap {
    
    if (self.dataModel) { /// 已经登录的状态
        
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSmallButtonOnClickWithTag:)]) {
            [self.delegate didSmallButtonOnClickWithTag:1004];
        }
        
        
    }
}
/// tag = 1001 收藏， 1002 = msg  , 1003 = 动态
- (void)smallButtonOnClick:(UIButton *)btn {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSmallButtonOnClickWithTag:)]) {
        [self.delegate didSmallButtonOnClickWithTag:btn.tag];
    }
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter
- (void)setDataModel:(MGResMemberDataModel *)dataModel {

    
    _dataModel = dataModel;
    
    self.nameLabel.text = dataModel.nick_name.length > 0 ? dataModel.nick_name : @"用户名";
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.avatar_rsurl] placeholderImage: dataModel.gender == 1 ? [UIImage imageNamed:@"mine_user_man"] :[UIImage imageNamed:@"mine_user_women"]];
    
    self.updateInfoLabel.text = dataModel ? @"修改个人信息" : @"请登录";
    self.updateInfoArrowImageView.hidden = dataModel ? NO : YES;
    
    self.favCountLabel.text = dataModel ? [NSString stringWithFormat:@"%ld",dataModel.fav_count] : @"一";
    
    self.msgCountLabel.text = dataModel ? [NSString stringWithFormat:@"%ld",dataModel.message_count] : @"一";
    
    self.friendCountLabel.text = dataModel ? [NSString stringWithFormat:@"%ld",dataModel.trend_count] : @"一";
    
    [self layoutSubviews];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    InterceptLoginShowAlert
}

@end
