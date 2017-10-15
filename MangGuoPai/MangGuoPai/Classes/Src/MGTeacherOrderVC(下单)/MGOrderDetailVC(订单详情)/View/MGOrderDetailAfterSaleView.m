//
//  MGOrderDetailAfterSaleView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/7.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGOrderDetailAfterSaleView.h"

@interface MGOrderDetailAfterSaleView ()

@property (nonatomic, strong) UILabel *afterSaleTipLabel;
@property (nonatomic, strong) UILabel *afterSaleLabel;
@property (nonatomic, strong) UIView *afterSaleLineView;

@end

@implementation MGOrderDetailAfterSaleView

- (void)prepareFrameViewUI:(CGRect)frame {

    _afterSaleTipLabel = [MGUITool labelWithText:@"售后信息 : " textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _afterSaleTipLabel.frame = CGRectMake(SW(30), SH(30), kScreenWidth - SH(60), _afterSaleTipLabel.fontLineHeight);
    
    _afterSaleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _afterSaleLabel.frame = CGRectMake(SW(30), _afterSaleTipLabel.bottom + SH(30), kScreenWidth - SH(60), 0);
    
    _afterSaleLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), 0, kScreenWidth - SW(48), MGSepLineHeight)];
    _afterSaleLineView.backgroundColor = MGSepColor;
    
    
    [self sd_addSubviews:@[_afterSaleTipLabel, _afterSaleLabel, _afterSaleLabel, _afterSaleLineView]];
    
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
- (void)setDetailDataModel:(MGResOrderDetailDataModel *)detailDataModel {
    _detailDataModel = detailDataModel;
    
    _afterSaleLabel.text = detailDataModel.after_sale_info;
    
    if (_afterSaleLabel.text.length > 0) {
        
        _afterSaleLabel.height = [_afterSaleLabel.text heightForFont:PFSC(30) width:kScreenWidth - SW(60)];
        
        _afterSaleLineView.top = _afterSaleLabel.bottom + SH(30);
        
        self.height = _afterSaleLineView.bottom;
        
        self.hidden = NO;
    } else {
        self.hidden = YES;
    }
    
    
}


@end
