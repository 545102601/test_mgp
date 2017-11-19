//
//  MGTeacherDetailHeaderView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherDetailHeaderView.h"

@interface MGTeacherDetailHeaderView ()
/// 头像
@property (nonatomic, strong) UIImageView *iconImageView;
/// 昵称 和 工作
@property (nonatomic, strong) UILabel *nameAndJobLabel;
/// 简介
@property (nonatomic, strong) UILabel *introTipLabel;
@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) UIView *introLineView;

/// 底部View
@property (nonatomic, strong) UIView *bomttomView;

@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *wantLabel;
@property (nonatomic, strong) UILabel *wantedLabel;
@property (nonatomic, strong) UIView *bomttomLineView;


@end

@implementation MGTeacherDetailHeaderView

- (void)prepareFrameViewUI:(CGRect)frame {
    
    self.hidden = YES;
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(750))];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    _iconImageView.layer.masksToBounds = YES;
    
    _nameAndJobLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(32) textAlignment:NSTextAlignmentCenter];
    _nameAndJobLabel.frame = CGRectMake(0, _iconImageView.bottom, kScreenWidth, SH(80));
    _nameAndJobLabel.backgroundColor = RGB(239, 239, 243);

    
    
    _introTipLabel = [MGUITool labelWithText:@"【导师简介】" textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _introTipLabel.frame = CGRectMake(SW(10), _nameAndJobLabel.bottom + SH(20), SW(300), _introTipLabel.fontLineHeight);
    
    _introLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:MGThemeFont_24];
    _introLabel.frame = CGRectMake(SW(30), _introTipLabel.bottom, kScreenWidth - SW(60), 0);
    
    _introLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _introLabel.bottom, kScreenWidth - 2 * SW(24), MGSepLineHeight)];
    _introLineView.backgroundColor = MGSepColor;
    
    
    
    _bomttomView = [[UIView alloc] initWithFrame:CGRectMake(0, _nameAndJobLabel.bottom, kScreenWidth, SH(98))];
    _bomttomView.backgroundColor = [UIColor whiteColor];
    
    
    _cityLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(30)];
    _cityLabel.frame = CGRectMake(SW(30), 0, SW(180), _cityLabel.fontLineHeight);
    _cityLabel.centerY = _bomttomView.height * 0.5;
    
    
    _wantLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(30) textAlignment:NSTextAlignmentCenter];
    _wantLabel.frame = CGRectMake(0, 0, SW(300), _wantLabel.fontLineHeight);
    _wantLabel.centerY = _bomttomView.height * 0.5;
    _wantLabel.centerX = kScreenWidth * 0.5;
    
    
    _wantedLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(30) textAlignment:NSTextAlignmentRight];
    _wantedLabel.frame = CGRectMake(kScreenWidth - SW(180) - SW(30), 0, SW(180), _wantedLabel.fontLineHeight);
    _wantedLabel.centerY = _bomttomView.height * 0.5;
    
    _bomttomLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _bomttomView.height - MGSepLineHeight, kScreenWidth - 2 * SW(24), MGSepLineHeight)];
    _bomttomLineView.backgroundColor = MGSepColor;
    
    
    [_bomttomView sd_addSubviews:@[_cityLabel, _wantedLabel, _wantLabel, _bomttomLineView]];
    
    [self sd_addSubviews:@[_iconImageView, _nameAndJobLabel,
                           _introLabel, _introTipLabel, _introLineView, _bomttomView]];
    
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

- (void)setDataModel:(MGResCourseTutorDataModel *)dataModel {
    _dataModel = dataModel;
    
    self.hidden = NO;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.logo_rsurl scaleWidth:_iconImageView.width] placeholderImage:SDWEB_PLACEHODER_IMAGE(_iconImageView) completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        CGSize iamgeSize = image.size;
        if (iamgeSize.width > 0 && iamgeSize.height > 0) {
            self.iconImageView.height = kScreenWidth * iamgeSize.height / iamgeSize.width;
            if (self.iconImageViewLoadCompletion) {
                self.iconImageViewLoadCompletion();
            }
        }
    }];
    
    NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc] initWithString:dataModel.name attributes:@{NSFontAttributeName : PFSC(30), NSForegroundColorAttributeName : MGThemeColor_Title_Black}];
    
    NSMutableAttributedString *attrM2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",dataModel.tutor_jobs] attributes:@{NSFontAttributeName : PFSC(30), NSForegroundColorAttributeName : colorHex(@"#fe5f5f")}];
    
    [attrM appendAttributedString:attrM2];
    
    _nameAndJobLabel.attributedText = attrM;
    
    _introLabel.attributedText = dataModel.introAttributeString;
    _introLabel.height = dataModel.introHeight + SH(40);
    
    _introLineView.top = _introLabel.bottom;
    
    _bomttomView.top = _introLineView.bottom;
    
    _cityLabel.text = dataModel.city;
    
    _wantLabel.text = [NSString stringWithFormat:@"%ld人想听", dataModel.want_count];
    
    _wantedLabel.text = [NSString stringWithFormat:@"%ld听过", dataModel.wanted_count];
    
    self.height = _bomttomView.bottom;
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _nameAndJobLabel.top = _iconImageView.bottom;
    
    _introTipLabel.top = _nameAndJobLabel.bottom + SH(20);
    
    _introLabel.top = _introTipLabel.bottom;
    
    _introLabel.height = self.dataModel.introHeight + SH(40);
    
    _introLineView.top = _introLabel.bottom;
    
    _bomttomView.top = _introLineView.bottom;
    
    self.height = _bomttomView.bottom;
}

- (void)setWantCount:(NSInteger)wantCount {
    _wantLabel.text = [NSString stringWithFormat:@"%ld人想听", wantCount];

}

- (CGFloat)headerHeight {
    return _bomttomView.bottom;
}

@end
