//
//  MGTeacherClassDetailView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/26.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherClassDetailView.h"

@interface MGTeacherClassDetailView ()
/// 内容scrollView
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
/// 课程标签View
@property (nonatomic, strong) UIView *classTagBgView;
/// 低点
@property (nonatomic, strong) UILabel *addressTipLabel;
@property (nonatomic, strong) UILabel *addressLabel;
/// 方式
@property (nonatomic, strong) UIView *classTagLeftLineView;
@property (nonatomic, strong) UILabel *wayTipLabel;
@property (nonatomic, strong) UILabel *wayLabel;
/// 价格
@property (nonatomic, strong) UIView *classTagRightLineView;
@property (nonatomic, strong) UILabel *priceTipLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIView *classTagBottomLineView;


/// 课程内容背景 View
@property (nonatomic, strong) UIView *classContentBgView;
@property (nonatomic, strong) UILabel *classContentTitleLabel;
@property (nonatomic, strong) UILabel *classContentSubTitleLabel;
@property (nonatomic, strong) UIView *classContentBottomLineView;


/// 授课方式背景 View
@property (nonatomic, strong) UIView *classWayBgView;
@property (nonatomic, strong) UILabel *classWayTitleLabel;
@property (nonatomic, strong) UILabel *classWaySubTitleLabel;
@property (nonatomic, strong) UIView *classWayBottomLineView;

/// 特别说明背景 View
@property (nonatomic, strong) UIView *instrutionBgView;
@property (nonatomic, strong) UILabel *instrutionTitleLabel;
@property (nonatomic, strong) UILabel *instrutionSubTitleLabel;
@property (nonatomic, strong) UIView *instrutionBottomLineView;


/// 底部
@property (nonatomic, strong) UIView *bomttomBgView;
@property (nonatomic, strong) TDExpendClickButtonNotHightLight *wantButton;
@property (nonatomic, strong) UILabel *wantLabel;
@property (nonatomic, strong) UIButton *orderButton;

@end

@implementation MGTeacherClassDetailView

- (void)prepareFrameViewUI:(CGRect)frame {

    self.backgroundColor = [UIColor whiteColor];
    
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, frame.size.height - SH(162))];
    
    _contentScrollView.showsVerticalScrollIndicator = NO;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(750))];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    _iconImageView.layer.masksToBounds = YES;
    
    _titleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30) textAlignment:NSTextAlignmentCenter];
    _titleLabel.frame = CGRectMake(0, _iconImageView.bottom, kScreenWidth, SH(80));
    _titleLabel.backgroundColor = RGB(239, 239, 243);
    
    /// 标签
    _classTagBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _titleLabel.bottom, kScreenWidth, SH(160))];
    _addressTipLabel = [MGUITool labelWithText:@"授课地点" textColor:MGThemeColor_Common_Black font:PFSC(30) textAlignment:NSTextAlignmentCenter];
    _addressTipLabel.frame = CGRectMake(0, SH(34), SW(226), _addressTipLabel.fontLineHeight);
    
    _addressLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(30) textAlignment:NSTextAlignmentCenter];
    _addressLabel.frame = CGRectMake(0, _addressTipLabel.bottom + SH(24), SW(226), _addressLabel.fontLineHeight);
    
    
    _classTagLeftLineView = [[UIView alloc] initWithFrame:CGRectMake(_addressTipLabel.right, SH(30), MGSepLineHeight, _classTagBgView.height - SH(60))];
    _classTagLeftLineView.backgroundColor = MGSepColor;
    
    _wayTipLabel = [MGUITool labelWithText:@"授课方式" textColor:MGThemeColor_Common_Black font:PFSC(30) textAlignment:NSTextAlignmentCenter];
    _wayTipLabel.frame = CGRectMake(_classTagLeftLineView.right, SH(34), kScreenWidth - 2 * SW(226),     _wayTipLabel.fontLineHeight);
    
    _wayLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(30) textAlignment:NSTextAlignmentCenter];
    _wayLabel.frame = CGRectMake(_classTagLeftLineView.right, _wayTipLabel.bottom + SH(24), kScreenWidth - 2 * SW(226), _wayLabel.fontLineHeight);
    
    
    _classTagRightLineView = [[UIView alloc] initWithFrame:CGRectMake(_wayTipLabel.right, SH(30), MGSepLineHeight, _classTagBgView.height - SH(60))];
    _classTagRightLineView.backgroundColor = MGSepColor;
    
    _priceTipLabel = [MGUITool labelWithText:@"课程价格" textColor:MGThemeColor_Common_Black font:PFSC(30) textAlignment:NSTextAlignmentCenter];
    _priceTipLabel.frame = CGRectMake(_wayTipLabel.right, SH(34), SW(226), _priceTipLabel.fontLineHeight);
    
    _priceLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Black font:PFSC(30) textAlignment:NSTextAlignmentCenter];
    _priceLabel.frame = CGRectMake(_wayTipLabel.right, _priceTipLabel.bottom + SH(24), SW(226), _priceLabel.fontLineHeight);
    
    _classTagBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(30), _classTagBgView.height - MGSepLineHeight, kScreenWidth - SW(60), MGSepLineHeight)];
    _classTagBottomLineView.backgroundColor = MGSepColor;
    
    /// 课程内容  未设置高
    _classContentBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _classTagBgView.bottom, kScreenWidth, 0)];
    
    _classContentTitleLabel = [MGUITool labelWithText:@"【课程内容】" textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _classContentTitleLabel.frame = CGRectMake(SW(10), SH(30), SW(300), _classContentTitleLabel.fontLineHeight);
    
    /// 未设置高
    _classContentSubTitleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24)];
    _classContentSubTitleLabel.frame = CGRectMake(SW(30), _classContentTitleLabel.bottom + SH(24), kScreenWidth - SH(60), 0);
    
    /// 未设置Y
    _classContentBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(30),0, kScreenWidth - SW(60),MGSepLineHeight)];
    
    _classContentBottomLineView.backgroundColor = MGSepColor;
    
    
    /// 授课方式 未设置y + h
    _classWayBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    _classWayTitleLabel = [MGUITool labelWithText:@"【授课方式】" textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _classWayTitleLabel.frame =  CGRectMake(SW(10), SH(30), SW(300), _classWayTitleLabel.fontLineHeight);
    /// 未设置 h
    _classWaySubTitleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24)];
    _classWaySubTitleLabel.frame = CGRectMake(SW(30), _classWayTitleLabel.bottom + SH(24), kScreenWidth - SH(60), 0);
    /// 未设置 Y
    _classWayBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(30),0, kScreenWidth - SW(60),MGSepLineHeight)];
    _classWayBottomLineView.backgroundColor = MGSepColor;
    
    /// 特别说明 未设置y + h
    _instrutionBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    _instrutionTitleLabel = [MGUITool labelWithText:@"【特别说明】" textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _instrutionTitleLabel.frame =  CGRectMake(SW(10), SH(30), SW(300), _instrutionTitleLabel.fontLineHeight);
    /// 未设置 h
    _instrutionSubTitleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24)];
    _instrutionSubTitleLabel.frame = CGRectMake(SW(30), _instrutionTitleLabel.bottom + SH(24), kScreenWidth - SH(60), 0);
    /// 未设置 Y
    _instrutionBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(30),0, kScreenWidth - SW(60),MGSepLineHeight)];
    _instrutionBottomLineView.backgroundColor = MGSepColor;
    
    /// 底部内容
    _bomttomBgView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - SH(162),kScreenWidth, SH(162))];
    _bomttomBgView.backgroundColor = [UIColor whiteColor];
    _wantButton = [TDExpendClickButtonNotHightLight buttonWithType:UIButtonTypeCustom];
    _wantButton.titleLabel.font = PFSC(30);
    [_wantButton setImage:[UIImage imageNamed:@"teacher_xiangting_nor"] forState:UIControlStateNormal];
    [_wantButton setImage:[UIImage imageNamed:@"teacher_xiangting_sel"] forState:UIControlStateSelected];
    
    _wantButton.frame = CGRectMake(SW(30), SH(68), SW(44), SW(44));
    [_wantButton addTarget:self action:@selector(wantButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _wantLabel = [MGUITool labelWithText:@"想听" textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _wantLabel.frame = CGRectMake(_wantButton.right + SW(12), 0, SW(300), _wantLabel.fontLineHeight);
    _wantLabel.centerY = _wantButton.centerY;
    
    
    _orderButton = [TDExpendClickButton buttonWithType:UIButtonTypeCustom];
    _orderButton.titleLabel.font = PFSC(30);
    [_orderButton setTitleColor:MGThemeColor_Title_Black forState:UIControlStateNormal];
    [_orderButton setTitle:@"下单" forState:UIControlStateNormal];
    _orderButton.backgroundColor = MGThemeYellowColor;
    _orderButton.layer.cornerRadius = MGButtonLayerCorner;
    
    _orderButton.frame = CGRectMake(kScreenWidth - SW(140) - SW(30), 0, SW(140), SH(60));
    _orderButton.centerY = _wantButton.centerY;
    [_orderButton addTarget:self action:@selector(orderButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_classTagBgView sd_addSubviews:@[_addressTipLabel, _addressLabel, _classTagLeftLineView, _wayTipLabel, _wayLabel, _classTagRightLineView, _priceTipLabel, _priceLabel, _classTagBottomLineView]];
    
    [_classContentBgView sd_addSubviews:@[_classContentTitleLabel, _classContentSubTitleLabel, _classContentBottomLineView]];
    
    [_classWayBgView sd_addSubviews:@[_classWayTitleLabel, _classWaySubTitleLabel, _classWayBottomLineView]];
    
    [_instrutionBgView sd_addSubviews:@[_instrutionTitleLabel, _instrutionSubTitleLabel, _instrutionBottomLineView]];
    
    
    [_contentScrollView sd_addSubviews:@[_iconImageView, _titleLabel, _classTagBgView, _classContentBgView, _classWayBgView, _instrutionBgView]];
    
    [_bomttomBgView sd_addSubviews:@[_wantButton, _wantLabel, _orderButton]];
    
    [self sd_addSubviews:@[_contentScrollView, _bomttomBgView]];
    
}
/// 想听
- (void)wantButtonOnClick {
    if (_wantButton.isSelected) {
        return;
    }
    if (_wantEventBlock) {
        _wantEventBlock();
    }
    
}
/// 下单
- (void)orderButtonOnClick {
    if (_orderEventBlock) {
        _orderEventBlock();
    }
    
}

- (void)setDataModel:(MGResCourseListDetailDataModel *)dataModel {
    _dataModel = dataModel;

    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.avatar_rsurl scaleWidth:_iconImageView.width] placeholderImage:SDWEB_PLACEHODER_IMAGE(_iconImageView) completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        CGSize iamgeSize = image.size;
        if (iamgeSize.width > 0 && iamgeSize.height > 0) {
            self.iconImageView.height = kScreenWidth * iamgeSize.height / iamgeSize.width;
            if (self.iconImageViewLoadCompletion) {
                self.iconImageViewLoadCompletion();
            }
        }
        
    }];
    
    _titleLabel.text = [NSString stringWithFormat:@"%@  (%@)",dataModel.course_title, dataModel.member_name];
    
    _addressLabel.text = dataModel.city;
    
    _wayLabel.text = [NSString stringWithFormat:@"%@",dataModel.type_method];
    
    _priceLabel.text = [TDCommonTool formatPriceWithDoublePrice:dataModel.sale_price];
    
    
    _classContentSubTitleLabel.attributedText = dataModel.contentAttributeString;
    
    
    
    _classWaySubTitleLabel.text = [NSString stringWithFormat:@"%@ , %@/%@ %@元", dataModel.type_method, dataModel.each_time, dataModel.service_time, _priceLabel.text];
    
    _instrutionSubTitleLabel.attributedText = dataModel.type_explainsAttributeString;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabel.top = _iconImageView.bottom;
    
    _classTagBgView.top = _titleLabel.bottom;
    
    _classContentBgView.top = _classTagBgView.bottom;
    
    /// 设置位置
    _classContentSubTitleLabel.height = self.dataModel.contentHeight;
    
    _classContentBottomLineView.y = _classContentSubTitleLabel.bottom + SH(30);
    
    _classContentBgView.height = _classContentBottomLineView.bottom;
    
    
    _classWaySubTitleLabel.height = [_classWaySubTitleLabel.text heightForFont:PFSC(24) width:_classWaySubTitleLabel.width];
    
    _classWayBottomLineView.y = _classWaySubTitleLabel.bottom + SH(30);
    
    _classWayBgView.height = _classWayBottomLineView.bottom;
    
    _classWayBgView.y = _classContentBgView.bottom;
    
    
    _instrutionSubTitleLabel.height = self.dataModel.type_explainsHeight;
    
    _instrutionBottomLineView.y = _instrutionSubTitleLabel.bottom + SH(30);
    
    _instrutionBgView.height = _instrutionBottomLineView.bottom;
    
    _instrutionBgView.y = _classWayBgView.bottom;
    
    CGFloat bottomHeight = 0;
    
    if (self.dataModel.type_explainsAttributeString.length > 0) {
        _instrutionBgView.hidden = NO;
        bottomHeight = _instrutionBgView.bottom;
    } else {
        _instrutionBgView.hidden = YES;
        bottomHeight = _classWayBgView.bottom;
    }
    
    
    _contentScrollView.contentSize = CGSizeMake(kScreenWidth, bottomHeight);
}

- (void)setWantButton:(BOOL)isFav {
    
    _wantButton.selected = isFav;

}

- (void)test {
    
//    [MGBussiness loadWantCountWithParams:@{@"entity_id" : @(dataModel.id) , @"entity_type_id" : @(MGGlobalEntityTypeFriend)} completion:^(id results) {
//        
//        if ([results boolValue]) {
//            [self showMBText:@"收藏成功"];
//            [cell.cellInfoView setFavIsCollection:YES];
//        }
//        
//    } error:nil];
}

- (void)setOrderButtonHidden {
    
    _orderButton.hidden = YES;
}

@end
