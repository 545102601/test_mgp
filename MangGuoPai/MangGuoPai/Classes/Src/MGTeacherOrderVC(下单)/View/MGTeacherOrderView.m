//
//  MGTeacherOrderView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/26.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherOrderView.h"
#import "MGResCouponPromotionModel.h"

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
/// 优惠金额
@property (nonatomic, strong) UILabel *discountMoneyLabel;
@property (nonatomic, strong) UIView *discountLineView;

/// 优惠卷
@property (nonatomic, strong) UIView *couponBgView;
@property (nonatomic, strong) UILabel *couponTipLabel;



/// 总计
@property (nonatomic, strong) UILabel *countLabel;

/// 订单支付
@property (nonatomic, strong) UIButton *orderPayButton;

@end

@implementation MGTeacherOrderView


- (void)prepareFrameViewUI:(CGRect)frame {

    self.backgroundColor = [UIColor whiteColor];
    
    [self setupOrderInfoView];
    
    [self setupDiscountAndCouponView];
    
    [self setupOrderView];
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

/// 打折按钮
- (void)discountButtonOnClick {
    [self endEditing:YES];
    
    NSString *discount = [_discountTextField.text removeBlank];
    if (discount.length == 0) {
        [self showMBText:@"请输入派号"];
        return;
    }
    
    if (_discountBlock) {
        _discountBlock(discount);
    }
    
}
/// 下单
- (void)orderPayButtonOnClick {
    
    id model = self.dataModel ?: self.detailDataModel;
    
    if (_orderBlock) {
        _orderBlock(model);
    }
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

- (void)setupOrderInfoView {
    
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
    
    
    _orderInfoLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(30), _orederInfoBgView.height - MGSepLineHeight, kScreenWidth - SW(60), MGSepLineHeight)];
    _orderInfoLineView.backgroundColor = MGSepColor;
    
    [_orederInfoBgView sd_addSubviews:@[_titleLabel, _numberLabel, _teacherNameLabel, _priceLabel, _orderInfoLineView]];
}

- (void)setupDiscountAndCouponView {
    WEAK
    _discountBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _orederInfoBgView.bottom, kScreenWidth, SH(290))];
    
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
    
    _couponBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _discountTextField.bottom + SH(20), kScreenWidth, SH(60))];
    
    _couponDataView = [[TDSelectListDataView alloc] initWithFrame:CGRectMake(_discountTextField.left, 0, _discountButton.right - _discountTextField.left, SH(60))];
    _couponDataView.didSelectListDataViewContentViewRow = ^(NSInteger row) {
      STRONG
        TDSelectListDataViewContentModel *contentModel = self.couponDataView.dataArray[row];
        [self.couponDataView setTitleLabelWithTitle:contentModel.name];
        
        if (self.couponDataSelectedBlock) {
            self.couponDataSelectedBlock();
        }
        
    };
    
    /// coupon tip
    _couponTipLabel = [MGUITool labelWithText:@"优惠卷 : " textColor:MGThemeColor_Common_Black font:PFSC(30) textAlignment:NSTextAlignmentRight];
    _couponTipLabel.frame = CGRectMake(_couponDataView.left - kScreenWidth * 0.5 - SW(10), 0, kScreenWidth * 0.5, _discountTipLabel.fontLineHeight);
    _couponTipLabel.centerY = _couponDataView.centerY;
    
    [_couponBgView sd_addSubviews:@[_couponTipLabel, _couponDataView]];
    
    /// 结果
    _discountResultLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(30) textAlignment:NSTextAlignmentRight];
    _discountResultLabel.frame = CGRectMake(SW(30), _couponBgView.bottom + SH(20), kScreenWidth - SW(60), _discountResultLabel.fontLineHeight);
    
    
    
    /// 结果
    _discountMoneyLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(30) textAlignment:NSTextAlignmentRight];
    _discountMoneyLabel.frame = CGRectMake(SW(30), _discountResultLabel.bottom + SH(20), kScreenWidth - SW(60), _discountMoneyLabel.fontLineHeight);
    
    
    
    
    _discountLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(30), _discountMoneyLabel.bottom + SH(20), kScreenWidth - SW(60), MGSepLineHeight)];
    _discountLineView.backgroundColor = MGSepColor;
    
    
    /// 设置背景高度
    _discountBgView.height = _discountLineView.bottom;
    
    [_discountBgView sd_addSubviews:@[_discountTipLabel, _discountTextField, _discountButton, _discountResultLabel, _discountMoneyLabel, _discountLineView, _couponBgView]];
    
}

- (void)setupOrderView {
    
    /// 用 attr
    _countLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30) textAlignment:NSTextAlignmentRight];
    _countLabel.frame = CGRectMake(SW(30), _discountBgView.bottom + SH(38), kScreenWidth - SW(60), _countLabel.fontLineHeight);
    
    
    _orderPayButton = [MGUITool buttonWithBGColor:nil title:@"下单支付" titleColor: MGThemeColor_Title_Black font:MGThemeFont_36 target:self selector:@selector(orderPayButtonOnClick)];
    [_orderPayButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_orderPayButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    
    _orderPayButton.frame = CGRectMake(0, self.height - SH(90) - SH(84), SW(600), SH(84));
    _orderPayButton.centerX = kScreenWidth * 0.5;
    _orderPayButton.layer.cornerRadius = MGButtonLayerCorner;
    _orderPayButton.layer.masksToBounds = YES;
    
    
    [self sd_addSubviews:@[_orederInfoBgView, _discountBgView, _countLabel, _orderPayButton]];
    
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
}



/// 设置价格模型
- (void)setPriceDataModel:(MGResCalcPriceDataModel *)priceDataModel {
    _priceDataModel = priceDataModel;
    
    _discountResultLabel.text = @"";
    _discountMoneyLabel.text = @"";
    
    [self setCountLabelAttrWithText:_priceLabel.text];
    
    if (priceDataModel.error_discount_price_label.length > 0) {
        if (priceDataModel.error_discount_price_label) {
            _discountResultLabel.text = priceDataModel.error_discount_price_label;
        }
    } else {
        _priceLabel.text = [TDCommonTool formatPriceWithDoublePrice:priceDataModel.total_price];

        [self setCountLabelAttrWithText:[TDCommonTool formatPriceWithDoublePrice:priceDataModel.pay_price]];
        
        if (priceDataModel.discount_price_label.length > 0) {
            _discountResultLabel.text = priceDataModel.discount_price_label;
        }
        
        if (priceDataModel.discount_price > 0) {
            _discountMoneyLabel.text = [NSString stringWithFormat:@"优惠金额 : -%@",[TDCommonTool formatPriceWithDoublePrice:priceDataModel.discount_price]];
        }
    }
    
    CGFloat marginTop = _couponBgView.bottom;
    
    if (_discountResultLabel.text.length > 0) {
        _discountResultLabel.hidden = NO;
        marginTop = _discountResultLabel.bottom;
    } else {
        _discountResultLabel.hidden = YES;
    }
    
    if (_discountMoneyLabel.text.length > 0) {
        _discountMoneyLabel.hidden = NO;
        _discountMoneyLabel.top = marginTop + SH(20);
        marginTop = _discountMoneyLabel.bottom;
        
    } else {
        _discountMoneyLabel.hidden = YES;
    }
    
    _discountLineView.top = marginTop + SH(40);
    
    _discountBgView.height = _discountLineView.bottom;
    
    _countLabel.top = _discountBgView.bottom + SH(38);
    
}

- (void)setCountLabelAttrWithText:(NSString *)text {
    
    NSString *countText = [NSString stringWithFormat:@"总计 : %@", text];
    NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc] initWithString:countText attributes:@{NSFontAttributeName : PFSC(40), NSForegroundColorAttributeName : MGThemeColor_Black}];
    [attrM addAttributes:@{NSFontAttributeName : PFSC(34), NSForegroundColorAttributeName : MGThemeColor_Common_Black, NSBaselineOffsetAttributeName : @(2)} range:NSMakeRange(0, 5)];
    _countLabel.attributedText = attrM;
    
}


/// 设置优惠卷数据
- (void)setCouponArray:(NSArray *)couponArray {
    
    _couponArray = couponArray;
    
    NSMutableArray *arrayM = @[].mutableCopy;
    
    for (int i = 0; i < couponArray.count; i++) {
        MGResCouponPromotionDataModel *dataModel = couponArray[i];
        TDSelectListDataViewContentModel *contentModel = [TDSelectListDataViewContentModel new];
        contentModel.name = dataModel.couponName;
        contentModel.id = dataModel.id;
        
        [arrayM addObject:contentModel];
    }
    NSString *couponText;
    
    if (arrayM.count == 0) {
        couponText = @"暂时没有可使用的优惠卷";
    } else {
        couponText = @"请选择优惠卷";
    }
    TDSelectListDataViewContentModel *contentModel = [TDSelectListDataViewContentModel new];
    contentModel.name = couponText;
    contentModel.id = 0;
    contentModel.isSelected = YES;
    [_couponDataView setTitleLabelWithTitle:contentModel.name];
    
    [arrayM insertObject:contentModel atIndex:0];
    
    _couponDataView.dataArray = arrayM;
}


- (NSString *)discountText {
    return [_discountTextField.text removeBlank];
}

@end
