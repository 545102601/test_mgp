//
//  MGWorkTeamHeaderView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/13.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkTeamHeaderView.h"

@interface MGWorkTeamHeaderView ()

/// 团队昵称
@property (nonatomic, strong) UILabel *teamNameLabel;
@property (nonatomic, strong) UIView *teamNameLineView;

@property (nonatomic, strong) UILabel *ciperTipLabel;
@property (nonatomic, strong) UILabel *ciperLabel;
@property (nonatomic, strong) UIView *ciperLineView;

@property (nonatomic, strong) UILabel *bulletinLabel;

@end

@implementation MGWorkTeamHeaderView

- (void)prepareViewUI {

    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    
    CGFloat itemHeight = SH(98);
    
    _teamNameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _teamNameLabel.frame = CGRectMake(SW(30), 0, kScreenWidth - SW(60), _teamNameLabel.fontLineHeight);
    _teamNameLabel.centerY = itemHeight * 0.5;
    
    _teamNameLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), itemHeight, kScreenWidth - SW(48), MGSepLineHeight)];
    _teamNameLineView.backgroundColor = MGSepColor;
    
    _ciperTipLabel = [MGUITool labelWithText:@"集结暗号 : " textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _ciperTipLabel.frame = CGRectMake(SW(30), 0, SW(300), _ciperTipLabel.fontLineHeight);
    _ciperTipLabel.centerY = itemHeight + itemHeight * 0.5;
    
    
    _ciperLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30) textAlignment:NSTextAlignmentRight];
    _ciperLabel.frame = CGRectMake(kScreenWidth - SW(150) - SW(30), 0, SW(150), _ciperLabel.fontLineHeight);
    _ciperLabel.centerY = _ciperTipLabel.centerY;
    
    _ciperLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), itemHeight * 2, kScreenWidth - SW(48), MGSepLineHeight)];
    _ciperLineView.backgroundColor = MGSepColor;
    
    
    _bulletinLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _bulletinLabel.frame = CGRectMake(SW(30), _ciperLineView.bottom + SH(30), kScreenWidth - SW(60), 0);
    
    
    [self sd_addSubviews:@[_teamNameLabel,
                           _teamNameLineView,
                           _ciperTipLabel,
                           _ciperLabel,
                           _ciperLineView,
                           _bulletinLabel]];
    
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
- (void)setDataModel:(MGResProjectTeamDataModel *)dataModel {
    _dataModel = dataModel;
    
    _teamNameLabel.text = dataModel.team_name;
    
    _ciperLabel.text = dataModel.cipher;
    
    if (dataModel.bulletin.length > 0) {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:SH(10)];
        UIColor *color = MGThemeColor_Title_Black;
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:dataModel.bulletin attributes:@{NSFontAttributeName : MGThemeFont_30,NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle}];
        
        _bulletinLabel.attributedText = string;
        
        _bulletinLabel.height = [string boundingRectWithSize:CGSizeMake(kScreenWidth - SW(60), HUGE) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        
        self.height = _bulletinLabel.bottom + SH(30);
    } else {
        self.height = _ciperLineView.bottom - MGSepLineHeight;
    }
    
    
}



@end
