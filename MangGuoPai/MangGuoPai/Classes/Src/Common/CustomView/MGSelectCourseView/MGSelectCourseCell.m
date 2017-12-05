//
//  MGSelectCourseCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/6.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGSelectCourseCell.h"

@interface MGSelectCourseCell ()
/// 标题
@property (nonatomic, strong) UILabel *titleNameLabel;
/// 价格
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation MGSelectCourseCell

- (void)preapreCellUI {

    _titleNameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _titleNameLabel.frame = CGRectMake(SW(28), 0, SW(460), _titleNameLabel.fontLineHeight);
    
    
    _priceLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Black font:PFSC(36) textAlignment:NSTextAlignmentRight];
    
    _priceLabel.frame = CGRectMake(kScreenWidth - SW(180) - SW(36), 0, SW(180), _priceLabel.fontLineHeight);
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), 0, kScreenWidth - SW(48), MGSepLineHeight)];
    _lineView.backgroundColor = MGSepColor;
    
    [self.contentView sd_addSubviews:@[_titleNameLabel, _priceLabel, _lineView]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleNameLabel.centerY = self.contentView.height * 0.5;
    
    _priceLabel.centerY = self.contentView.height * 0.5;
    
    _lineView.bottom = self.contentView.height;
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
- (void)setDataModel:(MGResCourseListDataModel *)dataModel {
    _dataModel = dataModel;
    
    _titleNameLabel.text = dataModel.course_title;
    
    _priceLabel.text = [TDCommonTool formatPriceWithDoublePrice:dataModel.sale_price];
    
    
    
    self.contentView.backgroundColor = dataModel.isSelected ? MGThemeColor_QianYellowColor : [UIColor whiteColor];
    
}


@end
