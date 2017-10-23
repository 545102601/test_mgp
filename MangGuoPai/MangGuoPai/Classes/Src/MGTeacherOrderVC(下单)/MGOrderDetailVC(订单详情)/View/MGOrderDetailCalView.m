//
//  MGOrderDetailCalView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/7.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGOrderDetailCalView.h"

@interface MGOrderDetailCalView ()

@property (nonatomic, strong) UILabel *originPriceLabel;
@property (nonatomic, strong) UILabel *discountPriceLabel;
@property (nonatomic, strong) UIView *calCenterLineView;
@property (nonatomic, strong) UILabel *allPriceLabel;
@property (nonatomic, strong) UIView *calBottomLineView;

@end

@implementation MGOrderDetailCalView

- (void)prepareFrameViewUI:(CGRect)frame {

    _originPriceLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(36) textAlignment:NSTextAlignmentRight];
    _originPriceLabel.frame = CGRectMake(SW(30), SH(30), kScreenWidth - SW(60), _originPriceLabel.fontLineHeight);
    
    _discountPriceLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(36) textAlignment:NSTextAlignmentRight];
    _discountPriceLabel.frame = CGRectMake(SW(30), _originPriceLabel.bottom + SH(20), kScreenWidth - SW(60), _discountPriceLabel.fontLineHeight);
    
    _calCenterLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _discountPriceLabel.bottom + SH(30), kScreenWidth - SW(48), MGSepLineHeight)];
    _calCenterLineView.backgroundColor = MGSepColor;
    
    _allPriceLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(36) textAlignment:NSTextAlignmentRight];
    _allPriceLabel.frame = CGRectMake(SW(30), _calCenterLineView.bottom + SH(30), kScreenWidth - SW(60), _allPriceLabel.fontLineHeight);
    
    
    _calBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _allPriceLabel.bottom + SH(30), kScreenWidth - SW(48), MGSepLineHeight)];
    _calBottomLineView.backgroundColor = MGSepColor;
    
    
    [self sd_addSubviews:@[_originPriceLabel, _discountPriceLabel, _calCenterLineView, _allPriceLabel, _calBottomLineView]];

    
    self.height = _calBottomLineView.bottom;
    
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
    
    NSString *orginStr = [NSString stringWithFormat:@"小计 :    %@",[TDCommonTool formatPriceWithDoublePrice:detailDataModel.total_price]];
    NSMutableAttributedString *originText = [[NSMutableAttributedString alloc] initWithString:orginStr];
    [originText addAttributes:@{NSFontAttributeName : PFSC(30), NSForegroundColorAttributeName : MGThemeColor_Common_Black} range:NSMakeRange(0, 5)];
    [originText addAttributes:@{NSFontAttributeName : PFSC(36), NSForegroundColorAttributeName : MGThemeColor_Title_Black} range:NSMakeRange(5, orginStr.length - 5)];
    self.originPriceLabel.attributedText = originText;
    
    
    
    NSString *discountStr = [NSString stringWithFormat:@"优惠金额 :  -%@",[TDCommonTool formatPriceWithDoublePrice:detailDataModel.discount_price]];
    NSMutableAttributedString *discountText = [[NSMutableAttributedString alloc] initWithString:discountStr];
    [discountText addAttributes:@{NSFontAttributeName : PFSC(30), NSForegroundColorAttributeName : MGThemeColor_Common_Black} range:NSMakeRange(0, 7)];
    [discountText addAttributes:@{NSFontAttributeName : PFSC(36), NSForegroundColorAttributeName : MGThemeColor_Title_Black} range:NSMakeRange(7, discountStr.length - 7)];
    self.discountPriceLabel.attributedText = discountText;
    
    
    
    NSString *allStr = [NSString stringWithFormat:@"总计 : %@",[TDCommonTool formatPriceWithDoublePrice:detailDataModel.pay_price]];
    NSMutableAttributedString *allText = [[NSMutableAttributedString alloc] initWithString:allStr];
    [allText addAttributes:@{NSFontAttributeName : PFSC(30), NSForegroundColorAttributeName : MGThemeColor_Common_Black} range:NSMakeRange(0, 5)];
    [allText addAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:getScaleWidth(36)], NSForegroundColorAttributeName : MGThemeColor_Black, NSBaselineOffsetAttributeName : @(2)} range:NSMakeRange(5, allStr.length - 5)];
    self.allPriceLabel.attributedText = allText;
    
    
    
}

@end
