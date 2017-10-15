//
//  MGWorkTeamSectionHeader.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/13.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkTeamSectionHeader.h"

@interface MGWorkTeamSectionHeader ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UILabel *titleTextLabel;
@property (nonatomic, strong) UILabel *subTitleTextLabel;
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation MGWorkTeamSectionHeader


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kMGWorkTeamSectionHeaderHeight)];
    _bgView.backgroundColor = MGBackgroundViewColor;
    
    _contentBgView = [[UIView alloc] initWithFrame:CGRectMake(0, SH(20), kScreenWidth, kMGWorkTeamSectionHeaderHeight - SH(20))];
    _contentBgView.backgroundColor = [UIColor whiteColor];
    
    _titleTextLabel = [MGUITool labelWithText:@"团队成员 : " textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _titleTextLabel.frame = CGRectMake(SW(30), 0, SW(250), _titleTextLabel.fontLineHeight);
    _titleTextLabel.centerY = _contentBgView.height * 0.5;
    
    
    _subTitleTextLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28) textAlignment:NSTextAlignmentRight];
    _subTitleTextLabel.frame = CGRectMake(kScreenWidth - SW(150) - SW(30), 0, SW(150), _subTitleTextLabel.fontLineHeight);
    _subTitleTextLabel.centerY = _contentBgView.height * 0.5;
    
    
    _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), kMGWorkTeamSectionHeaderHeight - MGSepLineHeight, kScreenWidth - SW(48), MGSepLineHeight)];
    _bottomLineView.backgroundColor = MGSepColor;
 

    [_contentBgView sd_addSubviews:@[_titleTextLabel, _subTitleTextLabel]];
    [self.contentView sd_addSubviews:@[_bgView, _contentBgView, _bottomLineView]];
    
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
- (void)setNumber:(NSInteger)number {
    _number = number;
    _subTitleTextLabel.text = [NSString stringWithFormat:@"%zd人", _number];
    
}


@end
