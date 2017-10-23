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
    
    
    _rightOneButton = [MGUITool buttonWithBGColor:nil title:nil titleColor: MGThemeColor_Title_Black font:MGThemeFont_28 target:self selector:@selector(rightOneButtonOnClick)];
    
    _rightOneButton.frame = CGRectMake(kScreenWidth - SW(140) - SW(30), _topLineView.bottom + SH(40), SW(140), SH(60));
    
    _rightOneButton.layer.cornerRadius = MGButtonLayerCorner;
    _rightOneButton.layer.masksToBounds = YES;
    _rightOneButton.layer.borderWidth = MGSepLineHeight;
    _rightOneButton.layer.borderColor = MGButtonImportDefaultColor.CGColor;
    
    _rightTwoButton = [MGUITool buttonWithBGColor:nil title:nil titleColor:MGThemeColor_Title_Black font:MGThemeFont_28 target:self selector:@selector(rightTwoButtonOnClick)];
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
        _rightOneButtonBlock(self.detailDataModel, self.rightOneButton.tag);
    }
    
}
- (void)rightTwoButtonOnClick {
    if (_rightTwoButtonBlock) {
        _rightTwoButtonBlock(self.detailDataModel, self.rightTwoButton.tag);
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
    
    
    _rightOneButton.hidden = YES;
    _rightTwoButton.hidden = YES;
    
    _rightOneButton.layer.borderColor = MGButtonImportDefaultColor.CGColor;
    _rightTwoButton.layer.borderColor = MGThemeColor_Title_Black.CGColor;
    
    if (self.menuTag == MGGlobaMenuTagLeft) {   /// 下的订单
        [self configOrderWithModel:detailDataModel];
    } else if (self.menuTag == MGGlobaMenuTagRight) { /// 收到的订单
        [self configReceiveOrderWithModel:detailDataModel];
    }
    
}

- (void)configOrderWithModel:(MGResOrderDetailDataModel *)detailDataModel {
    
    switch (detailDataModel.state) {
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
        case MGGlobalOrderStateAlreadyPayWaitingArrangement: /// 订单已付款，待安排 /// 待安排
            break;
        case MGGlobalOrderStateAlreadyPayAlreadyArrangement: /// 订单已付款，已安排 /// 已安排
        {
            
            _rightOneButton.hidden = NO;
            _rightOneButton.tag = MGGlobaOrderButtonTagComment;
            [MGUITool setButtonTheme:_rightOneButton
                               title:@"点评"
                          titleColor: MGThemeColor_Title_Black
                       bgImageNColor:MGButtonImportDefaultColor
                       bgImageHColor:MGButtonImportDefaultColor];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)configReceiveOrderWithModel:(MGResOrderDetailDataModel *)detailDataModel {

    switch (detailDataModel.state) {
        case MGGlobalOrderStateWaitingPay: /// 订单待付款
        {
            _rightOneButton.hidden = NO;
            
            _rightOneButton.tag = MGGlobaOrderButtonTagCancel;
            _rightOneButton.layer.borderColor = MGThemeColor_subTitle_Black.CGColor;
            [MGUITool setButtonTheme:_rightOneButton
                               title:@"取消订单"
                          titleColor: MGThemeColor_Title_Black
                       bgImageNColor:[UIColor whiteColor]
                       bgImageHColor:[UIColor whiteColor]];
            
        }
            break;
        case MGGlobalOrderStateAlreadyPayWaitingArrangement: /// 订单已付款，待安排 /// 待安排
        {
            _rightOneButton.hidden = NO;
            _rightOneButton.tag = MGGlobaOrderButtonTagSchedule;
            [MGUITool setButtonTheme:_rightOneButton
                               title:@"安排日程"
                          titleColor: MGThemeColor_Title_Black
                       bgImageNColor:MGButtonImportDefaultColor
                       bgImageHColor:MGButtonImportDefaultColor];
        
        }
            break;
            
        case MGGlobalOrderStateAlreadyPayAlreadyArrangement: /// 订单已付款，已安排 /// 已安排
        {
            _rightOneButton.hidden = NO;
            _rightOneButton.tag = MGGlobaOrderButtonTagCancelSchedule;
            [MGUITool setButtonTheme:_rightOneButton
                               title:@"取消安排"
                          titleColor: MGThemeColor_Title_Black
                       bgImageNColor:MGButtonImportDefaultColor
                       bgImageHColor:MGButtonImportDefaultColor];
            
        }
            break;
        case MGGlobalOrderStateBussinessFinish: /// 交易完成
        {
            _rightOneButton.hidden = YES;
            if (detailDataModel.comments.count > 0) {
                MGResOrderDetailCommentModel *dataModel = detailDataModel.comments[0];
                if (dataModel.reply.length == 0) {
                    
                    _rightOneButton.hidden = NO;
                    _rightOneButton.tag = MGGlobaOrderButtonTagReplyComment;
                    [MGUITool setButtonTheme:_rightOneButton
                                       title:@"回复点评"
                                  titleColor: MGThemeColor_Title_Black
                               bgImageNColor:MGButtonImportDefaultColor
                               bgImageHColor:MGButtonImportDefaultColor];
                }
            }
        }
            break;
            
        default:
            break;
    }
    
    
}

@end
