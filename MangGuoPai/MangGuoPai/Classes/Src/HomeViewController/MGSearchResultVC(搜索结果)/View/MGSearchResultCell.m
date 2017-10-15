//
//  MGSearchResultCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/28.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGSearchResultCell.h"

@interface MGSearchResultCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleNameLabel;


@end

@implementation MGSearchResultCell

- (void)preapreCellUI {

    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(30), SH(40), SW(80), SW(80))];
    _iconImageView.layer.cornerRadius = SW(80) * 0.5;
    _iconImageView.layer.masksToBounds = YES;

    _titleNameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:MGThemeFont_28];
    _titleNameLabel.frame = CGRectMake(_iconImageView.right + SW(30), 0, kScreenWidth - SW(46) - _iconImageView.right + SW(30), 0);
    
    [self.contentView addSubview:_iconImageView];
    [self.contentView addSubview:_titleNameLabel];
    
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

- (void)setDataModel:(MGResEntityDataModel *)dataModel {
    _dataModel = dataModel;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.logo_rsurl] placeholderImage:SDWEB_PLACEHODER_IMAGE_ICON];
    
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:SH(3)];
    UIColor *color = MGThemeColor_Common_Black;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:dataModel.title attributes:@{NSFontAttributeName : PFSC(28),NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle}];
    
    
    NSString *string2 = self.searchText;
    
    NSArray *array=[dataModel.title componentsSeparatedByString:string2];
    NSMutableArray *arrayOfLocation=[NSMutableArray new];
    int d=0;
    for (int i = 0;  i < array.count - 1; i++) {
        NSString *string = array[i];
        NSNumber *number = [NSNumber numberWithInt:d += string.length];
        d += string2.length;
        [arrayOfLocation addObject:number];
        
    }
    for (NSNumber *number in arrayOfLocation) {
          [string addAttribute:NSForegroundColorAttributeName value:MGThemeShenYellowColor range:NSMakeRange([number integerValue], string2.length)];
    }
  
    
    _titleNameLabel.attributedText = string;
    
    CGFloat height = [string boundingRectWithSize:CGSizeMake(_titleNameLabel.width, HUGE) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    
    
    if (height > SH(90)) {
        height = SH(90);
    }
    _titleNameLabel.height = height;
    
    _titleNameLabel.centerY = _iconImageView.centerY;
    
    
}

@end
