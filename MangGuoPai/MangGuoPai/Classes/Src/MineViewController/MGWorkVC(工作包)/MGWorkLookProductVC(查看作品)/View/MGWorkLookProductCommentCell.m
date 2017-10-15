//
//  MGWorkLookProductCommentCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/15.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkLookProductCommentCell.h"

@interface MGWorkLookProductCommentCell ()

@property (nonatomic, strong) UIButton *looOtherFileButton;

@property (nonatomic, strong) UIView *looOtherFileLineView;

@property (nonatomic, strong) UILabel *tutorTipLabel;

@property (nonatomic, strong) UILabel *tutorLabel;

@property (nonatomic, strong) UIView *centerLineView;

@property (nonatomic, strong) UILabel *companyTipLabel;

@property (nonatomic, strong) UILabel *companyLabel;

@end

@implementation MGWorkLookProductCommentCell

- (void)preapreCellUI {
    
    _looOtherFileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _looOtherFileButton.frame = CGRectMake(0, 0, kScreenWidth, SH(130));
    _looOtherFileButton.titleLabel.font = MGThemeFont_28;
    [_looOtherFileButton setTitle:@"查看其它方案文档" forState:UIControlStateNormal];
    [_looOtherFileButton setTitleColor:MGThemeColor_Common_Black forState:UIControlStateNormal];
    [_looOtherFileButton addTarget:self action:@selector(looOtherFileButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _looOtherFileLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _looOtherFileButton.bottom, kScreenWidth - SW(48), MGSepLineHeight)];
    _looOtherFileLineView.backgroundColor = MGSepColor;
    
    
    _tutorTipLabel = [MGUITool labelWithText:@"导师点评 : " textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _tutorTipLabel.hidden = YES;
    _tutorTipLabel.frame = CGRectMake(SW(45), _looOtherFileLineView.bottom + SH(30), SW(200), _tutorTipLabel.fontLineHeight);
    _tutorLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _tutorLabel.hidden = YES;
    _tutorLabel.frame = CGRectMake(SW(45), _tutorTipLabel.bottom + SH(20), kScreenWidth - SW(90), _tutorTipLabel.fontLineHeight);
    
    _centerLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _tutorLabel.bottom, kScreenWidth - SW(48), MGSepLineHeight)];
    _centerLineView.backgroundColor = MGSepColor;
    _centerLineView.hidden = YES;
    
    _companyTipLabel = [MGUITool labelWithText:@"企业点评 : " textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _companyTipLabel.hidden = YES;
    _companyTipLabel.frame = CGRectMake(SW(45), _centerLineView.bottom + SH(30), SW(200), _companyTipLabel.fontLineHeight);
    
    _companyLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _companyLabel.hidden = YES;
    _companyLabel.frame = CGRectMake(SW(45), _companyTipLabel.bottom + SH(20), kScreenWidth - SW(90), _companyTipLabel.fontLineHeight);

    [self.contentView sd_addSubviews:@[_looOtherFileButton,
                                       _looOtherFileLineView,
                                       _tutorTipLabel,
                                       _tutorLabel,
                                       _centerLineView,
                                       _companyTipLabel,
                                       _companyLabel]];
    
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

- (void)looOtherFileButtonOnClick {
    
    if (_looOtherFileButtonBlock) {
        _looOtherFileButtonBlock();
    }
    
}


#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter
- (void)setActorDataModel:(MGResProjectActorDataModel *)actorDataModel {
    _actorDataModel = actorDataModel;
    
    CGFloat marginTop = _looOtherFileLineView.bottom;
    
    if (actorDataModel.tutor_comments.length > 0) {
        _tutorTipLabel.hidden = NO;
        _tutorLabel.hidden = NO;
        
        _tutorTipLabel.top = _looOtherFileLineView.bottom + SH(30);
        _tutorLabel.top = _tutorTipLabel.bottom + SH(20);
        _tutorLabel.attributedText = actorDataModel.tutor_comments_attr;
        _tutorLabel.height = actorDataModel.tutor_comments_height;
        marginTop = _tutorLabel.bottom;
        
    }
    
    if (actorDataModel.company_comments.length > 0) {
        
        if (actorDataModel.tutor_comments.length > 0) {
            _centerLineView.hidden = NO;
            _centerLineView.top = marginTop + SH(30);
            marginTop = _centerLineView.bottom;
        }
        _companyTipLabel.hidden = NO;
        _companyLabel.hidden = NO;
        
        _companyTipLabel.top = marginTop + SH(30);
        _companyLabel.top = _companyTipLabel.bottom + SH(20);
        _companyLabel.attributedText = actorDataModel.company_comments_attr;
        _companyLabel.height = actorDataModel.company_comments_height;
        marginTop = _companyLabel.bottom;
        
    }
    self.height = marginTop + SH(30);
    
}

@end
