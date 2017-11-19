//
//  MGOrderInfoView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/7.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGOrderInfoView.h"
#import "MGTeacherClassDetailVC.h"

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

    _orderNoLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(20)];
    _orderNoLabel.frame = CGRectMake(SW(30), SH(30), SW(220), _orderNoLabel.fontLineHeight);
//    _orderNoLabel.adjustsFontSizeToFitWidth = YES;
    
    
    _orderTimeLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(20) textAlignment:NSTextAlignmentCenter];
    _orderTimeLabel.frame = CGRectMake(0, SH(30), SW(254), _orderTimeLabel.fontLineHeight);
    _orderTimeLabel.centerX = kScreenWidth * 0.5;
//    _orderTimeLabel.adjustsFontSizeToFitWidth = YES;
    
    
    _orderStateLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24) textAlignment:NSTextAlignmentRight];
    _orderStateLabel.frame = CGRectMake(kScreenWidth - SW(230) - SW(30), 0, SW(230), _orderStateLabel.fontLineHeight);
    _orderStateLabel.centerY = _orderTimeLabel.centerY;
//    _orderStateLabel.adjustsFontSizeToFitWidth = YES;
    
    _topLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _orderNoLabel.bottom + SH(30),kScreenWidth - SW(48), MGSepLineHeight)];
    _topLineView.backgroundColor = MGSepColor;
    
    
    _orderNameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30) ];
    _orderNameLabel.frame = CGRectMake(SW(30), _topLineView.bottom + SH(28), SW(540), _orderNameLabel.fontLineHeight);
    _orderNameLabel.adjustsFontSizeToFitWidth = YES;
    

    [_orderNameLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderNameLableTap)]];
    
    _orderNumberLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24) textAlignment:NSTextAlignmentRight];
    _orderNumberLabel.frame = CGRectMake(kScreenWidth - SW(160) - SW(30), 0, SW(160), _orderNumberLabel.fontLineHeight);
    _orderNumberLabel.centerY = _orderNameLabel.centerY;
    _orderNumberLabel.adjustsFontSizeToFitWidth = YES;
    
    _nameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _nameLabel.frame = CGRectMake(SW(30), _orderNameLabel.bottom + SH(40), SW(540), _nameLabel.fontLineHeight);
    
    
    _moneyLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Black font:PFSC(36) textAlignment:NSTextAlignmentRight];
    _moneyLabel.frame = CGRectMake(kScreenWidth - SW(30) - SW(400), 0, SW(400), _moneyLabel.fontLineHeight);
    _moneyLabel.centerY = _nameLabel.centerY;
    [_moneyLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneLabelTap)]];
    
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

- (void)orderNameLableTap {
    if (_orderNameTapBlock) {
        _orderNameTapBlock(self.dataModel.course_id > 0 ?
                           self.dataModel.course_id : self.detailDataModel.course_id);
    }
}

- (void)phoneLabelTap {
    
    if (_phoneTapBlock) {
        _phoneTapBlock(self.moneyLabel.text);
    }
    
}

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
    
    if (self.menuTag == MGGlobaMenuTagLeft) {
        _nameLabel.text = dataModel.tutor_name;
    } else {
        _nameLabel.text = dataModel.member_name;
    }
    /// 导师 + 详情
    if (self.sourceType == MGOrderInfoViewSourceTypeOrderDetail && self.menuTag == MGGlobaMenuTagRight) { /// 显示手机
        [self setPhoneAttrWithStr:dataModel.member_mobile];
    } else {
        if (self.sourceType == MGOrderInfoViewSourceTypeOrderDetail) {
            _moneyLabel.text = dataModel.sale_price == 0 ? @"" : [TDCommonTool formatPriceWithDoublePrice:dataModel.sale_price];
        } else {
            _moneyLabel.text = [TDCommonTool formatPriceWithDoublePrice:dataModel.pay_price];
        }
    }

    _centerLineView.hidden = self.hiddenBottomLine;
    
}
- (void)setDetailDataModel:(MGResOrderDetailDataModel *)detailDataModel {
    _detailDataModel = detailDataModel;
    
    _orderNoLabel.text = [NSString stringWithFormat:@"单号: %@",detailDataModel.order_no];
    
    _orderTimeLabel.text = detailDataModel.order_time_string;
    
    _orderStateLabel.text = detailDataModel.state_label;
    
    _orderNameLabel.text = detailDataModel.order_name;
    
    _orderNumberLabel.text = [NSString stringWithFormat:@"x %zd",detailDataModel.order_count];
    
    if (self.menuTag == MGGlobaMenuTagLeft) {
        _nameLabel.text = detailDataModel.tutor_name;
    } else {
        _nameLabel.text = detailDataModel.member_name;
    }
    
    /// 导师 + 详情
    if (self.sourceType == MGOrderInfoViewSourceTypeOrderDetail && self.menuTag == MGGlobaMenuTagRight) { /// 显示手机
        [self setPhoneAttrWithStr:detailDataModel.member_mobile];
        
    } else {
        
        if (self.sourceType == MGOrderInfoViewSourceTypeOrderDetail) {
            _moneyLabel.text = detailDataModel.sale_price == 0 ? @"" : [TDCommonTool formatPriceWithDoublePrice:detailDataModel.sale_price];
        } else {
            _moneyLabel.text = [TDCommonTool formatPriceWithDoublePrice:detailDataModel.pay_price];
        }
        
    }
    
    _centerLineView.hidden = self.hiddenBottomLine;
}

- (void)setOrderNameTapBlock:(MGCommomEventBlock)orderNameTapBlock {
    _orderNameTapBlock = orderNameTapBlock;
    
    _orderNameLabel.userInteractionEnabled = YES;
    
}
- (void)setPhoneTapBlock:(MGCommomEventBlock)phoneTapBlock {
    _phoneTapBlock = phoneTapBlock;
    
    _moneyLabel.userInteractionEnabled = YES;
}

- (void)setPhoneAttrWithStr:(NSString *)str {
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = PFSC(28);
    attr[NSForegroundColorAttributeName] = MGThemeColor_Common_Black;
    attr[NSUnderlineStyleAttributeName] = [NSNumber numberWithInteger:NSUnderlineStyleSingle];
    attr[NSUnderlineColorAttributeName] = MGThemeColor_Common_Black;
    NSAttributedString *attributedStr = [[NSAttributedString alloc] initWithString:str attributes:attr];
    self.moneyLabel.attributedText = attributedStr;
    

}

@end
