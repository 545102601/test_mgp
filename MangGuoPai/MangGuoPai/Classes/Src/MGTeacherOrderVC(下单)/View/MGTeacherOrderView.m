//
//  MGTeacherOrderView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/26.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherOrderView.h"

@interface MGTeacherOrderView ()
/// 订单信息
@property (nonatomic, strong) UIView *orederInfoBgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *teacherNameLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIView *orderInfoLineView;

/// 优惠码
@property (nonatomic, strong) UIView *discountBgView;
@property (nonatomic, strong) UILabel *discountTipLabel;
@property (nonatomic, strong) UITextField *discountTextField;
@property (nonatomic, strong) UIButton *discountButton;
@property (nonatomic, strong) UILabel *discountResultLabel;
@property (nonatomic, strong) UIView *discountLineView;

/// 总计
@property (nonatomic, strong) UILabel *countLabel;

/// 订单支付
@property (nonatomic, strong) UIButton *orderPayButton;

@end

@implementation MGTeacherOrderView


- (void)prepareFrameViewUI:(CGRect)frame {

    self.backgroundColor = [UIColor whiteColor];
    
    _orederInfoBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(152))];
    /// 标题
    _titleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _titleLabel.frame = CGRectMake(SW(30), SH(30), kScreenWidth *0.5, _titleLabel.fontLineHeight);
    
    /// 数量
    _numberLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24) textAlignment:NSTextAlignmentRight];
    _numberLabel.frame = CGRectMake(kScreenWidth *0.5 - SW(30), 0, kScreenWidth *0.5, _numberLabel.fontLineHeight);
    _numberLabel.centerY = _titleLabel.centerY;
    
    /// 导师昵称
    _teacherNameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _teacherNameLabel.frame = CGRectMake(SW(30), _titleLabel.bottom + SH(36), kScreenWidth *0.5, _teacherNameLabel.fontLineHeight);
    
    /// 价格
    _priceLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Black font:PFSC(36) textAlignment:NSTextAlignmentRight];
    _priceLabel.frame = CGRectMake(kScreenWidth *0.5 - SW(30), 0, kScreenWidth *0.5, _priceLabel.fontLineHeight);
    _priceLabel.centerY = _teacherNameLabel.centerY;
    
    
    _orderInfoLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(30), _orederInfoBgView.height - MGSepLineHeight, frame.size.width - SW(60), MGSepLineHeight)];
    _orderInfoLineView.backgroundColor = MGSepColor;
    
    [_orederInfoBgView sd_addSubviews:@[_titleLabel, _numberLabel, _teacherNameLabel, _priceLabel, _orderInfoLineView]];
    
    _discountBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _orederInfoBgView.bottom, kScreenWidth, SH(230))];
    
    
    /// 使用按钮
    _discountButton = [MGUITool buttonWithBGColor:nil title:@"使用" titleColor:MGThemeBackgroundColor font:PFSC(30) target:self selector:@selector(discountButtonOnClick)];
    _discountButton.frame = CGRectMake(kScreenWidth - SW(100) - SW(30), SH(40), SW(100), SH(60));
    _discountButton.layer.borderColor = MGThemeBackgroundColor.CGColor;
    _discountButton.layer.borderWidth = MGSepLineHeight;
    _discountButton.layer.cornerRadius = MGButtonLayerCorner;
    
    
    /// 优惠码输入框
    _discountTextField = [MGUITool textFieldWithTextColor:MGThemeColor_Common_Black font:PFSC(30) placeText:@"请输入派号" placeColor:colorHex(@"#cccccc") placeFont:PFSC(30)];
    _discountTextField.frame = CGRectMake(_discountButton.left - SW(320) - SW(20), SH(40), SW(320), SH(60));
    
    _discountTextField.layer.borderColor = MGSepColor.CGColor;
    _discountTextField.layer.borderWidth = MGSepLineHeight;
    _discountTextField.layer.cornerRadius = MGButtonLayerCorner;
    
    [_discountTextField addLeftBlankViewWithWidth:SW(20)];
    
    /// 优惠码tip
    _discountTipLabel = [MGUITool labelWithText:@"优惠码 : " textColor:MGThemeColor_Common_Black font:PFSC(30) textAlignment:NSTextAlignmentRight];
    _discountTipLabel.frame = CGRectMake(_discountTextField.left - kScreenWidth * 0.5 - SW(10), 0, kScreenWidth * 0.5, _discountTipLabel.fontLineHeight);
    _discountTipLabel.centerY = _discountButton.centerY;
    
    
    /// 结果
    _discountResultLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(30) textAlignment:NSTextAlignmentRight];
    _discountResultLabel.frame = CGRectMake(SW(30), _discountTextField.bottom + SH(50), kScreenWidth - SW(60), _discountResultLabel.fontLineHeight);
    
    
    _discountLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(30), _discountBgView.height - MGSepLineHeight, kScreenWidth - SW(60), MGSepLineHeight)];
    _discountLineView.backgroundColor = MGSepColor;
    
    
    [_discountBgView sd_addSubviews:@[_discountTipLabel, _discountTextField, _discountButton, _discountResultLabel, _discountLineView]];
    
    /// 用 attr
    _countLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30) textAlignment:NSTextAlignmentRight];
    _countLabel.frame = CGRectMake(SW(30), _discountBgView.bottom + SH(38), kScreenWidth - SW(60), _countLabel.fontLineHeight);
    
    
    
    _orderPayButton = [MGUITool buttonWithBGColor:nil title:@"下单支付" titleColor:MGThemeColor_Black font:MGThemeFont_36 target:self selector:@selector(orderPayButtonOnClick)];
    [_orderPayButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_orderPayButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    
    _orderPayButton.frame = CGRectMake(0, frame.size.height - SH(90) - SH(84), SW(600), SH(84));
    _orderPayButton.centerX = frame.size.width * 0.5;
    _orderPayButton.layer.cornerRadius = MGButtonLayerCorner;
    _orderPayButton.layer.masksToBounds = YES;
    
    
    [self sd_addSubviews:@[_orederInfoBgView, _discountBgView, _countLabel, _orderPayButton]];
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

/// 打折按钮
- (void)discountButtonOnClick {
    
    if (_discountBlock) {
        _discountBlock();
    }
    
}
/// 下单
- (void)orderPayButtonOnClick {
    
    id model = self.dataModel ?: self.detailDataModel;
    
    if (_orderBlock) {
        _orderBlock(model);
    }
    
}
#pragma mark - Private Function

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSString *code = @"";
    if (self.dataModel) {
        code = self.dataModel.servicesCode;
    } else if (self.detailDataModel) {
        code = self.detailDataModel.servicesCode;
    }
    if (code.length > 0) {
        _discountBgView.height = SH(230);
    } else {
        _discountBgView.height = SH(230) - SH(50) - _discountResultLabel.fontLineHeight;
    }
    _discountLineView.y = _discountBgView.height - MGSepLineHeight;
    _countLabel.y = _discountBgView.bottom + SH(38);
}


#pragma mark - Getter and Setter
- (void)setDataModel:(MGResCourseListDataModel *)dataModel {
    _dataModel = dataModel;
    
    
    if (!dataModel) {
        return;
    }
    
    _titleLabel.text = dataModel.course_title;
    
    _teacherNameLabel.text = dataModel.member_name;
    
    _numberLabel.text = @"x1";
    
    _priceLabel.text = [TDCommonTool formatPriceWithDoublePrice:dataModel.sale_price];
    
    _countLabel.text = [NSString stringWithFormat:@"总计 : %@",_priceLabel.text];
    
    _discountResultLabel.text = dataModel.servicesCode;
}

- (void)setDetailDataModel:(MGResCourseListDetailDataModel *)detailDataModel {
    _detailDataModel = detailDataModel;
    
    if (!detailDataModel) {
        return;
    }
    
    _titleLabel.text = detailDataModel.course_title;
    
    _teacherNameLabel.text = detailDataModel.member_name;
    
    _numberLabel.text = @"x1";
    
    _priceLabel.text = [TDCommonTool formatPriceWithDoublePrice:detailDataModel.sale_price];
    
    _countLabel.text = [NSString stringWithFormat:@"总计 : %@",_priceLabel.text];
    
    _discountResultLabel.text = detailDataModel.servicesCode;
    
}


@end
