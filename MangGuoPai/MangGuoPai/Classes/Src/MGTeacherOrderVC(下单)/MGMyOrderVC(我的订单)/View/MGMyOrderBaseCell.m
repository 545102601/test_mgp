//
//  MGMyOrderBaseCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/3.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMyOrderBaseCell.h"
#import "MGOrderInfoView.h"

@interface MGMyOrderBaseCell ()
/// 订单info
@property (nonatomic, strong) MGOrderInfoView *orderInfoView;

/// 安排上课时间
@property (nonatomic, strong) UILabel *sct_timeLabel;

///
@property (nonatomic, strong) UIButton *rightOneButton;

///
@property (nonatomic, strong) UIButton *rightTwoButton;


@end

@implementation MGMyOrderBaseCell

- (void)preapreCellUI {
    
    _orderInfoView = [[MGOrderInfoView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    
    _sct_timeLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _sct_timeLabel.frame = CGRectMake(SW(30), 0, SW(400), _sct_timeLabel.fontLineHeight);
    
    _rightOneButton = [MGUITool buttonWithBGColor:nil title:nil titleColor: MGThemeColor_Title_Black font:MGThemeFont_28 target:self selector:@selector(rightOneButtonOnClick)];
    
    _rightOneButton.frame = CGRectMake(kScreenWidth - SW(140) - SW(30), _orderInfoView.bottom + SH(20), SW(140), SH(60));

    _rightOneButton.layer.cornerRadius = MGButtonLayerCorner;
    _rightOneButton.layer.masksToBounds = YES;
    _rightOneButton.layer.borderWidth = MGSepLineHeight;
    _rightOneButton.layer.borderColor = MGButtonImportDefaultColor.CGColor;
    
    _sct_timeLabel.centerY = _rightOneButton.centerY;
    
    _rightTwoButton = [MGUITool buttonWithBGColor:nil title:nil titleColor:MGThemeColor_Common_Black font:MGThemeFont_28 target:self selector:@selector(rightTwoButtonOnClick)];
    _rightTwoButton.frame = CGRectMake(_rightOneButton.left - SW(140) - SW(20), 0, SW(140), SH(60));
    _rightTwoButton.centerY = _rightOneButton.centerY;
    _rightTwoButton.layer.cornerRadius = MGButtonLayerCorner;
    _rightTwoButton.layer.masksToBounds = YES;
    _rightTwoButton.layer.borderWidth = MGSepLineHeight;
    _rightTwoButton.layer.borderColor = MGThemeColor_subTitle_Black.CGColor;
    
    [self.contentView sd_addSubviews:@[_orderInfoView, _sct_timeLabel, _rightOneButton, _rightTwoButton]];
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

- (void)rightOneButtonOnClick {
    if (_rightOneButtonBlock) {
        _rightOneButtonBlock(self.dataModel, self.indexPath, self.rightOneButton.tag);
    }
    
}
- (void)rightTwoButtonOnClick {
    if (_rightTwoButtonBlock) {
        _rightTwoButtonBlock(self.dataModel, self.indexPath, self.rightTwoButton.tag);
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
    
    
    
    _rightOneButton.hidden = YES;
    _rightTwoButton.hidden = YES;
    _sct_timeLabel.hidden = YES;
    
    _rightOneButton.layer.borderColor = MGButtonImportDefaultColor.CGColor;
    _rightTwoButton.layer.borderColor = MGThemeColor_subTitle_Black.CGColor;
    
    _orderInfoView.hiddenBottomLine = NO;
    _orderInfoView.menuTag = self.menuTag;
    
    
    if (self.menuTag == MGGlobaMenuTagLeft) { /// 下的订单
        [self configOrderWithModel:dataModel];
    } else { /// 收到的订单
        [self configReceiveOrderWithModel:dataModel];
    }
    
    
    _orderInfoView.dataModel = dataModel;
    
}

- (void)configOrderWithModel:(MGResOrderListDataModel *)dataModel {
    
    switch (dataModel.state) {
        case MGGlobalOrderStateWaitingPay: /// 订单待付款
        {
            _rightOneButton.hidden = NO;
            _rightTwoButton.hidden = NO;
            
            _rightTwoButton.tag = MGGlobaOrderButtonTagCancel;
            [MGUITool setButtonTheme:_rightTwoButton
                               title:@"取消订单"
                          titleColor:MGThemeColor_subTitle_Black
                       bgImageNColor:[UIColor whiteColor]
                       bgImageHColor:[UIColor whiteColor]];
            
            
            
            _rightOneButton.tag = MGGlobaOrderButtonTagPay;
            [MGUITool setButtonTheme:_rightOneButton
                               title:@"立即付款"
                          titleColor: MGThemeColor_Title_Black
                       bgImageNColor:MGButtonImportDefaultColor
                       bgImageHColor:MGButtonImportDefaultColor];
            
            
        }
            break;
            
        case MGGlobalOrderStateAlreadyPayWaitingArrangement: /// 订单已付款，待安排
        case MGGlobalOrderStateAlreadyPayAlreadyArrangement: /// 订单已付款，已安排
        {
            
            _orderInfoView.hiddenBottomLine = YES;

            _rightOneButton.hidden = YES;
            _rightTwoButton.hidden = YES;
        }
            break;
        default:
        {
            _orderInfoView.hiddenBottomLine = YES;
        }
            break;
    }

}

- (void)configReceiveOrderWithModel:(MGResOrderListDataModel *)dataModel {
    switch (dataModel.state) {
        case MGGlobalOrderStateWaitingPay: /// 订单待付款
        {
            _rightTwoButton.hidden = YES;
            
            
            _rightOneButton.hidden = NO;
            _rightOneButton.layer.borderColor = MGThemeColor_subTitle_Black.CGColor;
            _rightOneButton.tag = MGGlobaOrderButtonTagCancel;
            [MGUITool setButtonTheme:_rightOneButton
                               title:@"取消订单"
                          titleColor:MGThemeColor_subTitle_Black
                       bgImageNColor:[UIColor whiteColor]
                       bgImageHColor:[UIColor whiteColor]];
            
        }
            break;
        case MGGlobalOrderStateAlreadyPayWaitingArrangement: /// 订单已付款，待安排
        {
            _sct_timeLabel.hidden = NO;
            _sct_timeLabel.text = @"未安排日程";
            
            _rightOneButton.hidden = NO;
            _rightOneButton.tag = MGGlobaOrderButtonTagSchedule;
            [MGUITool setButtonTheme:_rightOneButton
                               title:@"安排日程"
                          titleColor: MGThemeColor_Title_Black
                       bgImageNColor:MGButtonImportDefaultColor
                       bgImageHColor:MGButtonImportDefaultColor];
            
        }
            break;
        case MGGlobalOrderStateAlreadyPayAlreadyArrangement: /// 订单已付款，已安排
        {
            _sct_timeLabel.hidden = NO;
            _sct_timeLabel.text = [NSString stringWithFormat:@"%@上课",dataModel.sct_date_string];
            
            _rightOneButton.hidden = NO;
            
            _rightOneButton.tag = MGGlobaOrderButtonTagCancelSchedule;
            _rightOneButton.layer.borderColor = MGThemeShenYellowColor.CGColor;
            
            [MGUITool setButtonTheme:_rightOneButton
                               title:@"取消安排"
                          titleColor:MGThemeShenYellowColor
                       bgImageNColor:[UIColor whiteColor]
                       bgImageHColor:[UIColor whiteColor]];
            
            
        }
            break;
        default:
        {
            _orderInfoView.hiddenBottomLine = YES;
        }
            break;
    }
    
}


@end
