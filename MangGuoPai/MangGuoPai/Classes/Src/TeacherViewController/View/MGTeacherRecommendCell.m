//
//  MGTeacherRecommendCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherRecommendCell.h"

@interface MGTeacherRecommendCell ()
/// 头像
@property (nonatomic, strong) UIImageView *iconImageView;
/// 课程标题
@property (nonatomic, strong) UILabel *classTitleLabel;
/// 昵称
@property (nonatomic, strong) UILabel *nameLabel;
/// 职业
@property (nonatomic, strong) UILabel *professionLabel;
/// 线上 线下
@property (nonatomic, strong) UILabel *classStateLabel;
/// 想听
@property (nonatomic, strong) UILabel *wantLabel;
/// 线条
@property (nonatomic, strong) UIView *lineView;

@end

@implementation MGTeacherRecommendCell


- (void)preapreCellUI {

    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(34), SH(33), SW(96), SW(96))];
    _iconImageView.layer.cornerRadius = SW(96) / 2;
    _iconImageView.clipsToBounds = YES;
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    _iconImageView.userInteractionEnabled = YES;
    [_iconImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewTap)]];
    
    _classTitleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(33)];
    _classTitleLabel.frame = CGRectMake(_iconImageView.right + SW(20), SH(26), SW(540), _classTitleLabel.fontLineHeight);
    
    /// 未设置宽度
    _nameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Red font:PFSC(28)];
    _nameLabel.frame = CGRectMake(_classTitleLabel.left, _classTitleLabel.bottom + SH(5), 0, _nameLabel.fontLineHeight);
    
    /// 未设置左边距离
    _professionLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _professionLabel.frame = CGRectMake(0, _nameLabel.top, SW(340), _professionLabel.fontLineHeight);
    
    /// 未设置宽度
    _classStateLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_subTitle_Black font:PFSC(24)];
    _classStateLabel.frame = CGRectMake(_classTitleLabel.left, _nameLabel.bottom + SH(5), 0, _classStateLabel.fontLineHeight);;
    
    /// 未设置左边距离
    _wantLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_subTitle_Black font:PFSC(24)];
    _wantLabel.frame = CGRectMake(0, _classStateLabel.top, SW(140), _wantLabel.fontLineHeight);
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, MGSepLineHeight)];
    _lineView.backgroundColor = MGSepColor;
    
    [self.contentView sd_addSubviews:@[_iconImageView, _classTitleLabel, _nameLabel, _professionLabel, _classStateLabel, _wantLabel, _lineView]];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _lineView.bottom = self.contentView.bottom;
}


#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

- (void)iconImageViewTap {
    
    if (_iconImageTapBlock) {
        _iconImageTapBlock(self.model);
    }
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

- (void)setModel:(MGResCourseListDataModel *)model {
    _model = model;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar_rsurl] placeholderImage:SDWEB_PLACEHODER_IMAGE_ICON];
    
    _classTitleLabel.text = model.course_title;
    
    _nameLabel.text = model.member_name;
    
    _professionLabel.text = model.tutor_jobs;
    
    _classStateLabel.text = [NSString stringWithFormat:@"%@ (%@) ",model.type_name, model.type_method];
    
    _wantLabel.text = [NSString stringWithFormat:@"%zd人想听",model.want_count];
    
    
    /// 调整 距离
    _nameLabel.width = [_nameLabel.text widthForFont:PFSC(28)];
    _professionLabel.left = _nameLabel.right + SW(10);
    
    _classStateLabel.width = [_classStateLabel.text widthForFont:PFSC(24)];
    _wantLabel.left = _classStateLabel.right + SW(10);
    
    
}

@end
