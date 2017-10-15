//
//  MGAccountTableHeader.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGAccountTableHeader.h"

@interface MGAccountTableHeader ()

@property (nonatomic, strong) UILabel *allAccountLabel;

@property (nonatomic, strong) UILabel *availableTipLabel;
@property (nonatomic, strong) UILabel *availableLabel;

@property (nonatomic, strong) UILabel *freezingTipLabel;
@property (nonatomic, strong) UILabel *freezingLabel;

@end

@implementation MGAccountTableHeader

- (void)prepareFrameViewUI:(CGRect)frame {

    self.backgroundColor = MGThemeColor_Red;
    
    _allAccountLabel = [MGUITool labelWithText:nil textColor:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:getScaleWidth(72)] textAlignment:NSTextAlignmentCenter];
    _allAccountLabel.frame = CGRectMake(0, SH(100), kScreenWidth, _allAccountLabel.fontLineHeight);
    
    _availableTipLabel = [MGUITool labelWithText:@"可用资金(元)" textColor:[UIColor whiteColor] font:PFSC(30) textAlignment:NSTextAlignmentCenter];
    _availableTipLabel.frame = CGRectMake(0, _allAccountLabel.bottom + SH(60), kScreenWidth * 0.5, _availableTipLabel.fontLineHeight);
    
    
    _availableLabel = [MGUITool labelWithText:nil textColor:[UIColor whiteColor] font:PFSC(30) textAlignment:NSTextAlignmentCenter];
    _availableLabel.frame = CGRectMake(0, _availableTipLabel.bottom + SH(10), kScreenWidth * 0.5, _availableLabel.fontLineHeight);
    
    _freezingTipLabel = [MGUITool labelWithText:@"锁定资金(元)" textColor:[UIColor whiteColor] font:PFSC(30) textAlignment:NSTextAlignmentCenter];
    _freezingTipLabel.frame = CGRectMake(kScreenWidth * 0.5, _allAccountLabel.bottom + SH(60), kScreenWidth * 0.5, _freezingTipLabel.fontLineHeight);
    
    
    _freezingLabel = [MGUITool labelWithText:nil textColor:[UIColor whiteColor] font:PFSC(30) textAlignment:NSTextAlignmentCenter];
    _freezingLabel.frame = CGRectMake(kScreenWidth * 0.5, _freezingTipLabel.bottom + SH(10), kScreenWidth * 0.5, _freezingLabel.fontLineHeight);
    
    [self sd_addSubviews:@[_allAccountLabel, _availableLabel, _availableTipLabel, _freezingLabel, _freezingTipLabel]];
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

- (void)setDataModel:(MGAccountDataModel *)dataModel {
    _dataModel = dataModel;
    
    _allAccountLabel.text = [NSString stringWithFormat:@"%0.2f",dataModel.total_amount];
    
    _availableLabel.text = [NSString stringWithFormat:@"%0.2f",dataModel.available_amount];
    
    _freezingLabel.text = [NSString stringWithFormat:@"%0.2f",dataModel.freezing_amount];
    
    
}

@end
