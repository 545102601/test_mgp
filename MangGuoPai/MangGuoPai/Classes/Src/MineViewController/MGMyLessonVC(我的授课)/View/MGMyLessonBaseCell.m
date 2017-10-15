//
//  MGMyLessonBaseCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/1.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMyLessonBaseCell.h"

@interface MGMyLessonBaseCell ()

/// 课程标题
@property (nonatomic, strong) UILabel *classTitleLabel;
/// 课程状态
@property (nonatomic, strong) UILabel *classSubTitleLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UIView *centerLineView;

@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation MGMyLessonBaseCell

- (void)preapreCellUI {

    _classTitleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _classTitleLabel.frame = CGRectMake(SW(30), SH(40), kScreenWidth - SW(60), _classTitleLabel.fontLineHeight);
    
    _classSubTitleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _classSubTitleLabel.frame = CGRectMake(_classTitleLabel.left, _classTitleLabel.bottom + SH(30), SW(500), _classSubTitleLabel.fontLineHeight);
    
    
    _priceLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Black font:PFSC(36) textAlignment:NSTextAlignmentRight];
    _priceLabel.frame = CGRectMake(kScreenWidth - SW(180) - SW(30), 0, SW(180), _priceLabel.fontLineHeight);
    _priceLabel.centerY = _classSubTitleLabel.centerY;
    
    _centerLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _classSubTitleLabel.bottom + SH(20), kScreenWidth - SW(48), MGSepLineHeight)];
    _centerLineView.backgroundColor = MGSepColor;
    
    
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeButton.titleLabel.font = PFSC(28);
    [_closeButton setTitle:@"下架" forState:UIControlStateNormal];
    [_closeButton setTitleColor:MGThemeYellowColor forState:UIControlStateNormal];
    _closeButton.layer.cornerRadius = MGButtonLayerCorner;
    _closeButton.layer.borderWidth = MGSepLineHeight;
    _closeButton.layer.borderColor = MGThemeYellowColor.CGColor;
    _closeButton.frame = CGRectMake(kScreenWidth - SW(140) - SW(30), _centerLineView.bottom + SH(20), SW(140), SH(60));
    _closeButton.tag = 1003;
    [_closeButton addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteButton.titleLabel.font = PFSC(28);
    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteButton setTitleColor:MGThemeYellowColor forState:UIControlStateNormal];
    _deleteButton.layer.cornerRadius = MGButtonLayerCorner;
    _deleteButton.layer.borderWidth = MGSepLineHeight;
    _deleteButton.layer.borderColor = MGThemeYellowColor.CGColor;
    _deleteButton.frame = CGRectMake(_closeButton.left - SW(140) - SW(30), _centerLineView.bottom + SH(20), SW(140), SH(60));
    _deleteButton.tag = 1004;
    [_deleteButton addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView sd_addSubviews:@[_classTitleLabel, _classSubTitleLabel, _priceLabel, _centerLineView, _closeButton, _deleteButton]];
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
///
- (void)buttonOnClick:(UIButton *)button {
    
    if (_buttonEventBlock) {
        _buttonEventBlock(self.dataModel, button.tag);
    }
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter
- (void)setDataModel:(MGResCourseListDataModel *)dataModel {
    _dataModel = dataModel;
    
    _classTitleLabel.text = dataModel.course_title;
    
    _classSubTitleLabel.text = [NSString stringWithFormat:@"%@ (%@) | %@ | %@", dataModel.type_name, dataModel.type_method, dataModel.approve_state_label, dataModel.state_label];
    
    _priceLabel.text = [TDCommonTool formatPriceWithDoublePrice:dataModel.sale_price];
    
    
    if (dataModel.state == MGGlobaStateNormal) {/// 已经上架
        _closeButton.hidden = NO;
        _closeButton.tag = 1003;
           [_closeButton setTitle:@"下架" forState:UIControlStateNormal];
        _deleteButton.right = _closeButton.left - SW(20);
        
    } else if (dataModel.state == MGGlobaStateNone){
        _closeButton.hidden = NO;
        _closeButton.tag = 1002;
        [_closeButton setTitle:@"上架" forState:UIControlStateNormal];
        
        _deleteButton.right = _closeButton.left - SW(20);
        
    } else {
        _closeButton.hidden = YES;
        _deleteButton.right = kScreenWidth - SW(30);
    }
    
    
    
    
}
@end
