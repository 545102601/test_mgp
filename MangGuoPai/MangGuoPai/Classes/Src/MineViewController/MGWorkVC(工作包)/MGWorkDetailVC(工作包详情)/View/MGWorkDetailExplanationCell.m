//
//  MGWorkDetailExplanationCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/30.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkDetailExplanationCell.h"

@interface MGWorkDetailExplanationCell ()

@property (nonatomic, strong) UILabel *explanationLabel;
@property (nonatomic, strong) UILabel *explanationContentLabel;

@end

@implementation MGWorkDetailExplanationCell


- (void)preapreCellUI {
    
    _explanationLabel = [MGUITool labelWithText:@"活动简介" textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _explanationLabel.frame = CGRectMake(SW(30), SH(20), kScreenWidth * 0.5, _explanationLabel.fontLineHeight);
    
    _explanationContentLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _explanationContentLabel.frame = CGRectMake(SW(40), _explanationLabel.bottom + SH(20), kScreenWidth - SW(80), 0);
    
    [self.contentView sd_addSubviews:@[_explanationLabel, _explanationContentLabel]];
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
- (void)setDataModel:(MGResProjectDetailDataModel *)dataModel {
    
    _dataModel = dataModel;
    
    _explanationContentLabel.attributedText = dataModel.introductionAttr;
    
    _explanationContentLabel.height = dataModel.introductionHeight;
    
    
}
@end
