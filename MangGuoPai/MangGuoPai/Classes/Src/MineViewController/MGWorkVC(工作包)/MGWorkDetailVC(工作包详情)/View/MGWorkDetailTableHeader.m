//
//  MGWorkDetailTableHeader.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/30.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkDetailTableHeader.h"

@interface MGWorkDetailTableHeader ()

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MGWorkDetailTableHeader

- (void)prepareFrameViewUI:(CGRect)frame {

    self.backgroundColor = [UIColor whiteColor];
    
    _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(350))];
    
    _titleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30) textAlignment:NSTextAlignmentCenter];
    
    _titleLabel.frame = CGRectMake(SW(100), _logoImageView.bottom + SH(20), kScreenWidth - SW(200), 0);
    
    [self sd_addSubviews:@[_logoImageView, _titleLabel]];
    
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
- (void)setDataModel:(MGResProjectDetailDataModel *)dataModel {
    _dataModel = dataModel;
    
    [_logoImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.logo_rsurl] placeholderImage:SDWEB_PLACEHODER_IMAGE(_logoImageView)];
    
    _titleLabel.text = dataModel.project_name;
    
    _titleLabel.height = [_titleLabel.text heightForFont:_titleLabel.font width:_titleLabel.width];
    
    self.height = _titleLabel.bottom + SH(20);
    
    
}

@end
