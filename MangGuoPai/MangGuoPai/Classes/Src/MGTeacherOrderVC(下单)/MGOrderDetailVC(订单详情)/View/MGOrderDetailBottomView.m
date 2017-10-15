//
//  MGOrderDetailBottomView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/24.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGOrderDetailBottomView.h"

@interface MGOrderDetailBottomView ()

@property (nonatomic, strong) UIView *topLineView;

/// 从右到左的第一个按钮
@property (nonatomic, strong) UIButton *rightOneButton;

/// 从右到左的第二个按钮
@property (nonatomic, strong) UIButton *rightTwoButton;


@end

@implementation MGOrderDetailBottomView


- (void)prepareFrameViewUI:(CGRect)frame {

    _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, MGSepLineHeight)];
    _topLineView.backgroundColor = MGSepColor;
    
    
    _rightOneButton = [MGUITool buttonWithBGColor:nil title:nil titleColor:MGThemeColor_Black font:MGThemeFont_28 target:self selector:@selector(rightOneButtonOnClick)];
    
    _rightOneButton.frame = CGRectMake(kScreenWidth - SW(140) - SW(30), _topLineView.bottom + SH(40), SW(140), SH(60));
    
    _rightOneButton.layer.cornerRadius = MGButtonLayerCorner;
    _rightOneButton.layer.masksToBounds = YES;
    
    
    _rightTwoButton = [MGUITool buttonWithBGColor:nil title:nil titleColor:MGThemeColor_Black font:MGThemeFont_28 target:self selector:@selector(rightTwoButtonOnClick)];
    _rightTwoButton.frame = CGRectMake(_rightOneButton.left - SW(140) - SW(20), 0, SW(140), SH(60));
    _rightTwoButton.centerY = _rightOneButton.centerY;
    _rightTwoButton.layer.cornerRadius = MGButtonLayerCorner;
    _rightTwoButton.layer.masksToBounds = YES;
    _rightTwoButton.layer.borderWidth = MGSepLineHeight;
    _rightTwoButton.layer.borderColor = MGThemeColor_subTitle_Black.CGColor;
    
    
    [self sd_addSubviews:@[_topLineView, _rightOneButton, _rightTwoButton]];
    
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
- (void)rightOneButtonOnClick {
    if (_rightOneButtonBlock) {
        _rightOneButtonBlock(self.detailDataModel);
    }
    
}
- (void)rightTwoButtonOnClick {
    if (_rightTwoButtonBlock) {
        _rightTwoButtonBlock(self.detailDataModel);
    }
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter
- (void)setDetailDataModel:(MGResOrderDetailDataModel *)detailDataModel {
    _detailDataModel = detailDataModel;
    
    
    switch (detailDataModel.state) {
        case MGGlobalOrderStateWaitingPay: /// 订单待付款
        {
            _rightOneButton.hidden = NO;
            _rightTwoButton.hidden = NO;
            
            [_rightTwoButton setTitle:@"取消订单" forState:UIControlStateNormal];
            [_rightTwoButton setTitleColor:MGThemeColor_subTitle_Black forState:UIControlStateNormal];
            [_rightTwoButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [_rightTwoButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
            
            
            [_rightOneButton setTitle:@"立即付款" forState:UIControlStateNormal];
            [_rightOneButton setTitleColor:MGThemeColor_Black forState:UIControlStateNormal];
            [_rightOneButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
            [_rightOneButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
            
        }
            break;
        case MGGlobalOrderStateAlreadyPayWaitingArrangement: /// 订单已付款，待安排 /// 待安排
        {
        
            
            
        }
            break;
            
            
        default:
        {
            _rightOneButton.hidden = YES;
            _rightTwoButton.hidden = YES;
        }
            break;
    }
    
}
@end
