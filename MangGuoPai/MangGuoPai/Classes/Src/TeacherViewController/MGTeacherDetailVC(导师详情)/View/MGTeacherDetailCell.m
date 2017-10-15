//
//  MGTeacherDetailCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherDetailCell.h"

@interface MGTeacherDetailCell ()

@property (nonatomic, strong) UILabel *topTitleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *timesLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation MGTeacherDetailCell

- (void)preapreCellUI {

    _topTitleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:MGThemeFont_30];
    _topTitleLabel.frame = CGRectMake(SW(30), SH(30), kScreenWidth - SW(60), _topTitleLabel.fontLineHeight);
    
    _subTitleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_subTitle_Black font:MGThemeFont_24];
    _subTitleLabel.frame = CGRectMake(_topTitleLabel.left, _topTitleLabel.bottom + SH(42), SW(300), _subTitleLabel.fontLineHeight);
    
    _priceLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Black font:MGThemeFont_24];
    _priceLabel.frame = CGRectMake(0, 0, 0, _priceLabel.fontLineHeight);
    _priceLabel.centerY = _subTitleLabel.centerY;
    
    
    _timesLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_subTitle_Black font:MGThemeFont_24 textAlignment:NSTextAlignmentRight];
    _timesLabel.frame = CGRectMake(0, 0, SW(260), _timesLabel.fontLineHeight);
    _timesLabel.centerY = _subTitleLabel.centerY;
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), 0, kScreenWidth - SW(48), MGSepLineHeight)];
    _lineView.backgroundColor = MGSepColor;
    
    [self.contentView sd_addSubviews:@[_topTitleLabel, _subTitleLabel, _priceLabel, _timesLabel, _lineView]];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _lineView.y = self.contentView.height - MGSepLineHeight;
    
}

- (void)setDataModel:(MGResCourseListDataModel *)dataModel {
    _dataModel = dataModel;
    
    _topTitleLabel.text = dataModel.course_title;
    _subTitleLabel.text = [NSString stringWithFormat:@"%@ (%@) ",dataModel.type_name, dataModel.type_method];
    
    _timesLabel.text = [NSString stringWithFormat:@"%@/%@", dataModel.each_time, dataModel.service_time];
    
    _priceLabel.text = [TDCommonTool formatPriceWithDoublePrice:dataModel.sale_price];
    /// 计算距离
    CGFloat priceWidth = [_priceLabel.text widthForFont:MGThemeFont_24];
    _priceLabel.width = priceWidth;
    _priceLabel.right = kScreenWidth - SW(40);
    
    _timesLabel.right = kScreenWidth - priceWidth - SW(24) - SW(40);
    
    
    
}

@end
