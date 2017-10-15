//
//  MGMyCouponBaseCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/12.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMyCouponBaseCell.h"


@interface MGMyCouponBaseCell ()

/// 背景图片
@property (nonatomic, strong) UIImageView *bgImageView;
/// 图片
@property (nonatomic, strong) UIImageView *iconImageView;
/// 标题
@property (nonatomic, strong) UILabel *titleTextLabel;
/// 描述
@property (nonatomic, strong) UILabel *desLabel;
/// 时间
@property (nonatomic, strong) UILabel *timeLabel;
/// 状态
@property (nonatomic, strong) UILabel *stateLabel;

@end

@implementation MGMyCouponBaseCell

- (void)preapreCellUI {

    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(30), 0, kScreenWidth - SW(60), kMGMyCouponBaseCellHeight)];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_bgImageView.left + SW(36), SH(28), SW(118), SW(118))];
    _iconImageView.image = [UIImage imageNamed:@"mine_youhuijuan"];
    
    
    _titleTextLabel = [MGUITool labelWithText:nil textColor:[UIColor whiteColor] font:PFSC(30)];
    _titleTextLabel.frame = CGRectMake(_iconImageView.right + SW(24), _iconImageView.top, SW(320), _titleTextLabel.fontLineHeight);
    
    _desLabel = [MGUITool labelWithText:nil textColor:[UIColor whiteColor] font:PFSC(28)];
    _desLabel.frame = CGRectMake(_iconImageView.right + SW(24), 0, SW(320), _desLabel.fontLineHeight);
    _desLabel.centerY = _iconImageView.centerY;
    
    
    _timeLabel = [MGUITool labelWithText:nil textColor:[UIColor whiteColor] font:PFSC(22)];
    _timeLabel.frame = CGRectMake(_iconImageView.right + SW(24), _desLabel.bottom + SH(10), SW(340), _timeLabel.fontLineHeight);
    
    _stateLabel = [MGUITool labelWithText:nil textColor:[UIColor whiteColor] font:PFSC(30) textAlignment:NSTextAlignmentRight];
    _stateLabel.frame = CGRectMake(kScreenWidth - SW(80) - SW(100), 0, SW(100), _stateLabel.fontLineHeight);
    _stateLabel.centerY = _bgImageView.height * 0.5;
    
    [self.contentView sd_addSubviews:@[_bgImageView, _iconImageView, _titleTextLabel, _desLabel, _timeLabel, _stateLabel]];
    
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
- (void)setDataModel:(MGCouponOwnsDataModel *)dataModel {
    _dataModel = dataModel;
    
    _titleTextLabel.text = dataModel.coupon_name;
    _desLabel.text = dataModel.coupon_desc;
    _timeLabel.text = [NSString stringWithFormat:@"%@—%@使用", dataModel.start_time_str, dataModel.end_time_str];
    
    _stateLabel.text = dataModel.state_label;
    
    switch (dataModel.state) {
        case 0:
            _bgImageView.image = [UIImage imageNamed:@"mine_coupon_02"];
            break;
        case -1:
            _bgImageView.image = [UIImage imageNamed:@"mine_coupon_02"];
            break;
        case 50:
            _bgImageView.image = [UIImage imageNamed:@"mine_coupon_01"];
            break;
    }
    
}

@end
