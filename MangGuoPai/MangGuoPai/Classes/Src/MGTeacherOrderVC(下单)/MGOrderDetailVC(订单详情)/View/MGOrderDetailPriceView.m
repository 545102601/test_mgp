//
//  MGOrderDetailPriceView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGOrderDetailPriceView.h"

@interface MGOrderDetailPriceView ()

@property (nonatomic, strong) UILabel *originPriceLabel;

@property (nonatomic, strong) UIView *calBottomLineView;

@end

@implementation MGOrderDetailPriceView

- (void)prepareFrameViewUI:(CGRect)frame {
    
    
    _originPriceLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(36) textAlignment:NSTextAlignmentRight];
    _originPriceLabel.frame = CGRectMake(SW(30), SH(30), kScreenWidth - SW(60), _originPriceLabel.fontLineHeight);
    
    
    _calBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _originPriceLabel.bottom + SH(30), kScreenWidth - SW(48), MGSepLineHeight)];
    _calBottomLineView.backgroundColor = MGSepColor;
    
    [self sd_addSubviews:@[_originPriceLabel, _calBottomLineView]];
    
    self.height = _calBottomLineView.bottom;
    
}

- (void)setDetailDataModel:(MGResOrderDetailDataModel *)detailDataModel {
    _detailDataModel = detailDataModel;
    
    _originPriceLabel.text = [TDCommonTool formatPriceWithDoublePrice:detailDataModel.pay_price];
    
}

@end
