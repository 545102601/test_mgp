//
//  MGTeacherRecommendSectionHeader.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherRecommendSectionHeader.h"

@interface MGTeacherRecommendSectionHeader ()


@property (nonatomic, strong) UIView *recommendBgView;
@property (nonatomic, strong) UIImageView *recommendLineImageView;
@property (nonatomic, strong) UILabel *recommendTitleLabel;
@property (nonatomic, strong) UILabel *recommendSubTitleLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation MGTeacherRecommendSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self prepareViewUI];
    }
    return self;
}

- (void)prepareViewUI {
    /// 名企
    _recommendBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(80))];
    _recommendBgView.backgroundColor = [UIColor whiteColor];
    _recommendLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(16), SH(26), SW(14), SH(40))];
    _recommendLineImageView.image = [UIImage imageNamed:@"home_dianzhui"];
    
    _recommendTitleLabel = [MGUITool labelWithText:@"课程推荐" textColor:MGThemeColor_Title_Black font:MGThemeFont_28];
    _recommendTitleLabel.frame = CGRectMake(_recommendLineImageView.right + SW(5), SH(42), SW(300), _recommendTitleLabel.fontLineHeight);
    _recommendTitleLabel.centerY = _recommendLineImageView.centerY;
    
    _recommendSubTitleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_subTitle_Black font:MGThemeFont_24 textAlignment:NSTextAlignmentRight];
    _recommendSubTitleLabel.frame = CGRectMake(kScreenWidth - SW(20) - SH(300), 0, SW(300), _recommendSubTitleLabel.fontLineHeight);
    _recommendSubTitleLabel.centerY = _recommendTitleLabel.centerY;
    _recommendSubTitleLabel.hidden = YES;
    
    
    [_recommendBgView sd_addSubviews:@[_recommendLineImageView, _recommendTitleLabel,
                                    _recommendSubTitleLabel, _recommendSubTitleLabel]];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, MGSepLineHeight)];
    _lineView.backgroundColor = MGSepColor;
    
    
    [self.contentView addSubview:_recommendBgView];
    
    [self.contentView addSubview:_lineView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _recommendBgView.bottom = self.contentView.bottom;
    _lineView.bottom = self.contentView.bottom;
    
}

@end
