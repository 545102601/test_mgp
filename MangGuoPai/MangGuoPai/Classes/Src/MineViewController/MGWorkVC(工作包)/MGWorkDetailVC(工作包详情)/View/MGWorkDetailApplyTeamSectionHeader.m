//
//  MGWorkDetailApplyTeamSectionHeader.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/14.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkDetailApplyTeamSectionHeader.h"

@interface MGWorkDetailApplyTeamSectionHeader ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *applyTeamLabel;

@end

@implementation MGWorkDetailApplyTeamSectionHeader


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    self.contentView.backgroundColor = [UIColor clearColor];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, SH(4), kScreenWidth, kMGWorkDetailApplyTeamSectionHeaderHeight - SH(4))];
    _bgView.backgroundColor = [UIColor whiteColor];
    
    _applyTeamLabel = [MGUITool labelWithText:@"报名团队" textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _applyTeamLabel.frame = CGRectMake(SW(30), SH(20), kScreenWidth * 0.5, _applyTeamLabel.fontLineHeight);
    
    [self.contentView sd_addSubviews:@[_bgView, _applyTeamLabel]];
    
}

@end
