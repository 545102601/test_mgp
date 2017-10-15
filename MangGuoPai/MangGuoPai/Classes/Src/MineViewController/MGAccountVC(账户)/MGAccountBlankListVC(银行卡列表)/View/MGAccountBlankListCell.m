//
//  MGAccountBlankListCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/28.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGAccountBlankListCell.h"
#import "WLCardNoFormatter.h"

@interface MGAccountBlankListCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleNameLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) WLCardNoFormatter *formatter;

@end

@implementation MGAccountBlankListCell

- (void)preapreCellUI {
    
    CGFloat cellHeight = SH(150);
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(SW(20), 0, kScreenWidth - SW(40), cellHeight)];
    _bgView.backgroundColor = [UIColor whiteColor];
    
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(40) , 0, SW(78), SW(78))];
    _iconImageView.centerY = cellHeight * 0.5;
    
    
    _titleNameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _titleNameLabel.frame = CGRectMake(_iconImageView.right + SW(30), SH(42), kScreenWidth * 0.5, _titleNameLabel.fontLineHeight);
    
    _subTitleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Placeholder_Black font:PFSC(30)];
    _subTitleLabel.frame = CGRectMake(_titleNameLabel.left, _titleNameLabel.bottom + SH(20), kScreenWidth * 0.5, _subTitleLabel.fontLineHeight);

    
    [self.bgView sd_addSubviews:@[_iconImageView, _titleNameLabel, _subTitleLabel]];
    
    [self.contentView addSubview:self.bgView];

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
- (void)setDataModel:(MGAccountBlankListDataModel *)dataModel {
    _dataModel = dataModel;
    
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.bank_icon] placeholderImage:SDWEB_PLACEHODER_IMAGE(_iconImageView)];
    
    
    _titleNameLabel.text = dataModel.bank_name;
    
    
    NSString *result_cardno = @"";
    if (dataModel.card_no.length > 0) {
        
        NSString *cardno = [_formatter groupedString:dataModel.card_no];
        if (cardno.length > 15) {
            cardno = [cardno stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@"****"];
            cardno = [cardno stringByReplacingCharactersInRange:NSMakeRange(5, 4) withString:@"****"];
            cardno = [cardno stringByReplacingCharactersInRange:NSMakeRange(10, 4) withString:@"****"];
         if (cardno.length > 19) {
            cardno = [cardno stringByReplacingCharactersInRange:NSMakeRange(15, 4) withString:@"****"];
         }
        }
        result_cardno = cardno;
    }
    _subTitleLabel.text = result_cardno;
    
}

@end
