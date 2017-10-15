//
//  MGOrderInfoView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/7.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGOrderInfoView.h"

@interface MGOrderInfoView ()

/// 订单号
@property (nonatomic, strong) UILabel *orderNoLabel;
/// 订单时间
@property (nonatomic, strong) UILabel *orderTimeLabel;
/// 订单状态
@property (nonatomic, strong) UILabel *orderStateLabel;
@property (nonatomic, strong) UIView *topLineView;
/// 订单昵称
@property (nonatomic, strong) UILabel *orderNameLabel;
/// 订单数量
@property (nonatomic, strong) UILabel *orderNumberLabel;

/// 订购者或者导师昵称
@property (nonatomic, strong) UILabel *nameLabel;

/// 支付金额
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UIView *centerLineView;


@end

@implementation MGOrderInfoView

- (void)prepareFrameViewUI:(CGRect)frame {

    _orderNoLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24)];
    _orderNoLabel.frame = CGRectMake(SW(30), SH(30), SW(220), _orderNoLabel.fontLineHeight);
    _orderNoLabel.adjustsFontSizeToFitWidth = YES;
    
    
    _orderTimeLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24) textAlignment:NSTextAlignmentCenter];
    _orderTimeLabel.frame = CGRectMake(0, SH(30), SW(254), _orderTimeLabel.fontLineHeight);
    _orderTimeLabel.centerX = kScreenWidth * 0.5;
    _orderTimeLabel.adjustsFontSizeToFitWidth = YES;
    
    
    _orderStateLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28) textAlignment:NSTextAlignmentRight];
    _orderStateLabel.frame = CGRectMake(kScreenWidth - SW(160) - SW(30), 0, SW(160), _orderStateLabel.fontLineHeight);
    _orderStateLabel.centerY = _orderTimeLabel.centerY;
    _orderStateLabel.adjustsFontSizeToFitWidth = YES;
    
    _topLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _orderNoLabel.bottom + SH(30),kScreenWidth - SW(48), MGSepLineHeight)];
    _topLineView.backgroundColor = MGSepColor;
    
    
    _orderNameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30) ];
    _orderNameLabel.frame = CGRectMake(SW(30), _topLineView.bottom + SH(28), SW(540), _orderNameLabel.fontLineHeight);
    _orderNameLabel.adjustsFontSizeToFitWidth = YES;
    
    
    _orderNumberLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24) textAlignment:NSTextAlignmentRight];
    _orderNumberLabel.frame = CGRectMake(kScreenWidth - SW(160) - SW(30), 0, SW(160), _orderNumberLabel.fontLineHeight);
    _orderNumberLabel.centerY = _orderNameLabel.centerY;
    _orderNumberLabel.adjustsFontSizeToFitWidth = YES;
    
    _nameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _nameLabel.frame = CGRectMake(SW(30), _orderNameLabel.bottom + SH(40), SW(540), _nameLabel.fontLineHeight);
    
    
    _moneyLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Black font:PFSC(30) textAlignment:NSTextAlignmentRight];
    _moneyLabel.frame = CGRectMake(kScreenWidth - SW(30) - SW(400), 0, SW(400), _moneyLabel.fontLineHeight);
    _moneyLabel.centerY = _nameLabel.centerY;
    
    
    _centerLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24),  _nameLabel.bottom + SH(30), kScreenWidth - SW(48), MGSepLineHeight)];
    _centerLineView.backgroundColor = MGSepColor;
    
    
    [self sd_addSubviews:@[_orderNoLabel, _orderTimeLabel, _orderStateLabel,
                           _orderNameLabel, _orderNumberLabel, _nameLabel,
                           _moneyLabel, _topLineView, _centerLineView]];

    self.height = _centerLineView.bottom;
    
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
- (void)setDataModel:(MGResOrderListDataModel *)dataModel {
    _dataModel = dataModel;
    
    _orderNoLabel.text = [NSString stringWithFormat:@"单号: %@",dataModel.order_no];
    
    _orderTimeLabel.text = dataModel.order_time_string;
    
    _orderStateLabel.text = dataModel.state_label;
    
    _orderNameLabel.text = dataModel.order_name;
    
    _orderNumberLabel.text = [NSString stringWithFormat:@"x %zd",dataModel.order_count];
    
    if (self.type == 1) {
        _nameLabel.text = dataModel.tutor_name;
    } else {
        _nameLabel.text = dataModel.member_name;
    }
    
    _moneyLabel.text = [TDCommonTool formatPriceWithDoublePrice:dataModel.pay_price];
    

}
- (void)setDetailDataModel:(MGResOrderDetailDataModel *)detailDataModel {
    _detailDataModel = detailDataModel;
    
    _orderNoLabel.text = [NSString stringWithFormat:@"单号: %@",detailDataModel.order_no];
    
    _orderTimeLabel.text = detailDataModel.order_time_string;
    
    _orderStateLabel.text = detailDataModel.state_label;
    
    _orderNameLabel.text = detailDataModel.order_name;
    
    _orderNumberLabel.text = [NSString stringWithFormat:@"x %zd",detailDataModel.order_count];
    
    if (self.type == 1) {
        _nameLabel.text = detailDataModel.tutor_name;
    } else {
        _nameLabel.text = detailDataModel.member_name;
    }
    
    _moneyLabel.text = [TDCommonTool formatPriceWithDoublePrice:detailDataModel.pay_price];
    
    
}

@end
