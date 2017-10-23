//
//  MGHomeSimpleGraphCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGHomeSimpleGraphCell.h"

@interface SimpleGraphImageView : UIImageView

@end

@implementation SimpleGraphImageView

@end

@interface MGHomeSimpleGraphCell ()

/// 名企
@property (nonatomic, strong) UIView *famousBgView;
@property (nonatomic, strong) UIImageView *famousLineImageView;
@property (nonatomic, strong) UILabel *famousTitleLabel;
@property (nonatomic, strong) UILabel *famousSubTitleLabel;
//@property (nonatomic, strong) UIImageView *famousContentImageView;


@end

@implementation MGHomeSimpleGraphCell

- (void)preapreCellUI {

    /// 名企
    _famousBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(273))];
    _famousLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(16), SH(36), SW(14), SH(42))];
    _famousLineImageView.image = [UIImage imageNamed:@"home_dianzhui"];
    
    _famousTitleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:MGThemeFont_28];
    _famousTitleLabel.frame = CGRectMake(_famousLineImageView.right + SW(5), SH(42), SW(300), _famousTitleLabel.fontLineHeight);
    _famousTitleLabel.centerY = _famousLineImageView.centerY;
    
    _famousSubTitleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_subTitle_Black font:MGThemeFont_24 textAlignment:NSTextAlignmentRight];
    _famousSubTitleLabel.frame = CGRectMake(kScreenWidth - SW(20) - SH(300), 0, SW(300), _famousSubTitleLabel.fontLineHeight);
    _famousSubTitleLabel.centerY = _famousTitleLabel.centerY;
    
//    _famousContentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(20), _famousLineImageView.bottom + SH(15), SW(710), SH(140))];
//    _famousContentImageView.userInteractionEnabled = YES;
//    [_famousContentImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(famousContentImageViewTap)]];
    
    [_famousBgView sd_addSubviews:@[_famousLineImageView, _famousTitleLabel,
                                    _famousSubTitleLabel, _famousSubTitleLabel]];
    
    
    [self.contentView sd_addSubviews:@[_famousBgView]];
    
}


- (void)callBackBlockWithDetailModel:(MGResSettingDataDetailModel *) detailModel{
    if (_didCellItem) {
        _didCellItem(detailModel);
    }
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

- (void)famousContentImageViewTap:(UITapGestureRecognizer *)tag {
    
    MGResSettingDataModel *famousDataModel = self.dataModel;
    
    [self callBackBlockWithDetailModel:famousDataModel.details[tag.view.tag - 1]];
    
    
}
#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

- (void)setDataModel:(MGResSettingDataModel *)dataModel {
    _dataModel = dataModel;
    
    MGResSettingDataModel *famousDataModel = dataModel;
    
    self.famousTitleLabel.text = famousDataModel.title;
    self.famousSubTitleLabel.text = famousDataModel.intro;
    
    CGFloat marginTop = _famousLineImageView.bottom + SH(15);
    
    for (UIView *view in self.contentView.subviews) {
        if ([view isKindOfClass:[SimpleGraphImageView class]]) {
            [view removeFromSuperview];
        }
    }
    
    for (int i = 0; i < dataModel.details.count; i++) {
        MGResSettingDataDetailModel *famousDataDetailModel = dataModel.details[i];
        
        SimpleGraphImageView * _famousContentImageView = [[SimpleGraphImageView alloc] initWithFrame:CGRectMake(SW(20), marginTop, SW(710), SH(140))];
        _famousContentImageView.contentMode = UIViewContentModeScaleAspectFill;
        _famousContentImageView.layer.masksToBounds = YES;
        _famousContentImageView.userInteractionEnabled = YES;
        _famousContentImageView.tag = i + 1;
        [_famousContentImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(famousContentImageViewTap:)]];
        marginTop = _famousContentImageView.bottom;
        [self.contentView addSubview:_famousContentImageView];
        
        [_famousContentImageView sd_setImageWithURL:[NSURL URLWithString:famousDataDetailModel.file_path] placeholderImage:SDWEB_PLACEHODER_IMAGE(_famousContentImageView)];
        
    }
    
    _famousBgView.height = SH(140) * dataModel.details.count + SH(133);
    
}

@end
