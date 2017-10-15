//
//  MGHomePosterCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGHomePosterCell.h"

@interface MGHomePosterCell ()
/// 推荐活动
@property (nonatomic, strong) UIView *recommendBgView;
@property (nonatomic, strong) UIImageView *recommendLineImageView;
@property (nonatomic, strong) UILabel *recommendTitleLabel;
@property (nonatomic, strong) UILabel *recommendSubTitleLabel;
@property (nonatomic, strong) UIImageView *recommendContentImageView;

@end

@implementation MGHomePosterCell

- (void)preapreCellUI {
    /// 名企
    _recommendBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(140) + SH(480))];
    _recommendLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(16), SH(36), SW(14), SH(42))];
    _recommendLineImageView.image = [UIImage imageNamed:@"home_dianzhui"];
    
    _recommendTitleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:MGThemeFont_28];
    _recommendTitleLabel.frame = CGRectMake(_recommendLineImageView.right + SW(5), SH(42), SW(300), _recommendTitleLabel.fontLineHeight);
    _recommendTitleLabel.centerY = _recommendLineImageView.centerY;
    
    _recommendSubTitleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_subTitle_Black font:MGThemeFont_24 textAlignment:NSTextAlignmentRight];
    _recommendSubTitleLabel.frame = CGRectMake(kScreenWidth - SW(20) - SH(300), 0, SW(300), _recommendSubTitleLabel.fontLineHeight);
    _recommendSubTitleLabel.centerY = _recommendTitleLabel.centerY;
    _recommendSubTitleLabel.hidden = YES;
    
    _recommendContentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(20), _recommendLineImageView.bottom + SH(15), SW(710), SH(480))];
    _recommendContentImageView.userInteractionEnabled = YES;
    [_recommendContentImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recommendContentImageViewTap)]];
    
    [_recommendBgView sd_addSubviews:@[_recommendLineImageView, _recommendTitleLabel,
                                    _recommendSubTitleLabel, _recommendSubTitleLabel,
                                    _recommendContentImageView]];
    
    [self.contentView addSubview:_recommendBgView];
}
- (void)callBackBlockWithdetailModel:(MGResSettingDataDetailModel *) detailModel{
    if (_didCellItem) {
        _didCellItem(detailModel);
    }
    
    
}
- (void)recommendContentImageViewTap {
    
        MGResSettingDataModel *famousDataModel = self.dataModel;
        if (famousDataModel.details.count > 0) {
            [self callBackBlockWithdetailModel:famousDataModel.details[0]];
        }
    
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

- (void)setDataModel:(MGResSettingDataModel *)dataModel {
    _dataModel = dataModel;
    
    MGResSettingDataModel *recommendDataModel = dataModel;
    self.recommendTitleLabel.text = recommendDataModel.title;
    self.recommendSubTitleLabel.text = recommendDataModel.intro;
    if (recommendDataModel.details.count > 0) {
        MGResSettingDataDetailModel *recommendDataDetailModel = recommendDataModel.details[0];
        [self.recommendContentImageView sd_setImageWithURL:[NSURL URLWithString:recommendDataDetailModel.file_path] placeholderImage:SDWEB_PLACEHODER_IMAGE(_recommendContentImageView)];
    }
}

@end
