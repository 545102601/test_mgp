//
//  MGWorkDetailProgressCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/30.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkDetailProgressCell.h"

@interface MGWorkDetailProgressCell ()

/// 开始时间
@property (nonatomic, strong) UILabel *starTimeLabel;
@property (nonatomic, strong) UILabel *starTimeTipLabel;

/// 报名截止时间
@property (nonatomic, strong) UILabel *endApplyTimeLabel;
@property (nonatomic, strong) UILabel *endApplyTimeTipLabel;

/// 作品截止时间
@property (nonatomic, strong) UILabel *endProductionTimeLabel;
@property (nonatomic, strong) UILabel *endProductionTimeTipLabel;

/// 评审时间
@property (nonatomic, strong) UILabel *endCommentTimeLabel;
@property (nonatomic, strong) UILabel *endCommentTimeTipLabel;

/// 进度
@property (nonatomic, strong) NSMutableArray *docViewArrayM;
@property (nonatomic, strong) UIView *progressLineBgView;
@property (nonatomic, strong) UIView *progressLineView;

/// 地点
@property (nonatomic, strong) UILabel *locationLabel;
/// 进度label
@property (nonatomic, strong) UILabel *progressLabel;

/// 人数
@property (nonatomic, strong) UILabel *numberLabel;


@end

@implementation MGWorkDetailProgressCell

- (void)preapreCellUI {

    _starTimeLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24) ];
    _starTimeLabel.frame = CGRectMake(SW(30), SH(40), SW(160), _starTimeLabel.fontLineHeight);
    
    
    _starTimeTipLabel = [MGUITool labelWithText:@"开始报名" textColor:MGThemeColor_Common_Black font:PFSC(24)];
    _starTimeTipLabel.frame = CGRectMake(SW(30), _starTimeLabel.bottom + SH(50), SW(160), _starTimeTipLabel.fontLineHeight);
    
    
    _endApplyTimeTipLabel = [MGUITool labelWithText:@"报名截止" textColor:MGThemeColor_Common_Black font:PFSC(24) textAlignment:NSTextAlignmentCenter];
    _endApplyTimeTipLabel.frame = CGRectMake(SW(200), _starTimeLabel.top, SW(160), _endApplyTimeTipLabel.fontLineHeight);
    
    
    
    _endApplyTimeLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24) textAlignment:NSTextAlignmentCenter];
    _endApplyTimeLabel.frame = CGRectMake(_endApplyTimeTipLabel.left, _starTimeTipLabel.top, SW(160), _endApplyTimeLabel.fontLineHeight);
    
    
    _endProductionTimeLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24) textAlignment:NSTextAlignmentCenter];
    _endProductionTimeLabel.frame = CGRectMake(SW(398), _starTimeLabel.top, SW(160), _endProductionTimeLabel.fontLineHeight);
    
    
    _endProductionTimeTipLabel = [MGUITool labelWithText:@"作品截止" textColor:MGThemeColor_Common_Black font:PFSC(24) textAlignment:NSTextAlignmentCenter];
    _endProductionTimeTipLabel.frame = CGRectMake(_endProductionTimeLabel.left, _starTimeTipLabel.top, SW(160), _endProductionTimeTipLabel.fontLineHeight);
    
    
    _endCommentTimeTipLabel = [MGUITool labelWithText:@"评审结束" textColor:MGThemeColor_Common_Black font:PFSC(24) textAlignment:NSTextAlignmentRight];
    _endCommentTimeTipLabel.frame = CGRectMake(kScreenWidth - SW(40) - SW(160), _starTimeLabel.top, SW(160), _endCommentTimeTipLabel.fontLineHeight);
    
    _endCommentTimeLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24) textAlignment:NSTextAlignmentRight];
    _endCommentTimeLabel.frame = CGRectMake(_endCommentTimeTipLabel.left, _starTimeTipLabel.top, SW(160), _endCommentTimeLabel.fontLineHeight);
    
    
    _docViewArrayM = @[].mutableCopy;
    CGFloat dotLeftAndRightMargin = SW(65);
    CGFloat dotMargin = (kScreenWidth - 2 * dotLeftAndRightMargin - 4 * SW(25)) / 3;
    
    
    
    _progressLineBgView = [[UIView alloc] initWithFrame:CGRectMake(dotLeftAndRightMargin, 0, kScreenWidth - 2 * dotLeftAndRightMargin, SH(10))];
    _progressLineBgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _progressLineView = [[UIView alloc] initWithFrame:CGRectMake(dotLeftAndRightMargin, 0, 0, SH(10))];
    _progressLineView.backgroundColor = MGThemeShenYellowColor;
    
    
    
    for (int i = 0; i < 4; i++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(dotLeftAndRightMargin + i *dotMargin + i * SW(25), _starTimeLabel.bottom + SH(15), SW(25), SW(25))];
        dotView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        dotView.layer.cornerRadius = SW(25) * 0.5;
        dotView.layer.masksToBounds = YES;
        [_docViewArrayM addObject:dotView];
    }
    _progressLineBgView.centerY = ((UIView *)(_docViewArrayM[0])).centerY;
    
    _progressLineView.centerY = ((UIView *)(_docViewArrayM[0])).centerY;
    
    _locationLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _locationLabel.frame = CGRectMake(_starTimeLabel.left, _starTimeTipLabel.bottom + SH(60), SW(500), _locationLabel.fontLineHeight);
    _locationLabel.adjustsFontSizeToFitWidth = YES;
    
    _progressLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _progressLabel.frame = CGRectMake(kScreenWidth - SW(160) - SW(25), _locationLabel.top, SW(160), _progressLabel.fontLineHeight);
    
    _numberLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28) textAlignment:NSTextAlignmentCenter];
    _numberLabel.layer.borderColor = MGSepColor.CGColor;
    _numberLabel.layer.borderWidth = 1;
    _numberLabel.layer.cornerRadius = 2;
    _numberLabel.layer.masksToBounds = YES;
    _numberLabel.frame = CGRectMake(SW(170), _locationLabel.bottom + SH(35), kScreenWidth - 2 * SW(170), SH(60));
    
    [self.contentView sd_addSubviews:@[_starTimeLabel,
                                       _starTimeTipLabel,
                                       _endApplyTimeLabel,
                                       _endApplyTimeTipLabel,
                                       _endCommentTimeTipLabel,
                                       _endCommentTimeLabel,
                                       _endProductionTimeLabel,
                                       _endProductionTimeTipLabel,
                                       _progressLineBgView,
                                       _progressLineView,
                                       _locationLabel,
                                       _progressLabel,
                                       _numberLabel]];

    for (UIView *view in _docViewArrayM) {
        [self.contentView addSubview:view];
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
- (void)setDataModel:(MGResProjectDetailDataModel *)dataModel {
    
    
    _dataModel = dataModel;
    
    _starTimeLabel.text = dataModel.publish_time_str;
    
    _endApplyTimeLabel.text = dataModel.apply_abort_time_str;
    
    _endProductionTimeLabel.text = dataModel.works_abort_time_str;
    
    _endCommentTimeLabel.text = dataModel.appraise_abort_time_str;
    
    _locationLabel.text = [NSString stringWithFormat:@"活动地点 : %@", dataModel.location];
    
    _progressLabel.text = [NSString stringWithFormat:@"进度: %zd%%", dataModel.progress];
    
    _numberLabel.text = [NSString stringWithFormat:@"%zd人想去  %zd人已报名",dataModel.want_count, dataModel.applied_count];
    
    /// 进度dot
    CGFloat progressIndex = 0;
    if (dataModel.progress > 0 && dataModel.progress < 33.3) {
        progressIndex = 1;
    } else if (dataModel.progress >= 33.3 && dataModel.progress < 66.6) {
        progressIndex = 2;
    }  else if (dataModel.progress >= 66.6 && dataModel.progress < 99.9) {
        progressIndex = 3;
    } else if (dataModel.progress > 99.9){
        progressIndex = 4;
    }
    if (progressIndex > 0) {
        for (int i = 0; i < progressIndex; i++) {
            UIView *view = self.docViewArrayM[i];
            view.backgroundColor = MGThemeShenYellowColor;
        }
    }
    
    CGFloat width = dataModel.progress * _progressLineBgView.width / 100.0 ;
    _progressLineView.width = width;
    
    
    NSLog(@"~~");
    
    
}

@end
