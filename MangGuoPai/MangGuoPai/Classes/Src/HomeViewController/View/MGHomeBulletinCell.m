//
//  MGHomeBulletinCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGHomeBulletinCell.h"
#import "SDCycleScrollView.h"
#import "MGResContentModel.h"

@interface MGHomeBulletinCell () <SDCycleScrollViewDelegate>

/// 公告图
@property (nonatomic, strong) UIImageView *leftImageView;
/// 线条
@property (nonatomic, strong) UIView *lineView;
/// 文字滚动
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation MGHomeBulletinCell


- (void)preapreCellUI {
    
    self.contentView.backgroundColor = MGThemeColor_White;
    
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(28), SH(12), SW(64), SW(64))];
    _leftImageView.image = [UIImage imageNamed:@"home_gonggao"];
    _leftImageView.userInteractionEnabled = YES;
    [_leftImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftImageTapOnClick)]];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(_leftImageView.right + SW(20), 0, MGSepLineHeight, PFSC(22).lineHeight)];
    _lineView.centerY = _leftImageView.centerY;
    _lineView.backgroundColor = MGSepColor;
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(_lineView.right + SW(20), 0, kScreenWidth, SH(60)) delegate:self placeholderImage:nil];
    _cycleScrollView.backgroundColor = [UIColor whiteColor];
    _cycleScrollView.onlyDisplayText = YES;
    _cycleScrollView.autoScrollTimeInterval = 3;
    _cycleScrollView.centerY = _leftImageView.centerY;
    _cycleScrollView.titleLabelTextFont = PFSC(28);
    _cycleScrollView.titleLabelBackgroundColor = [UIColor whiteColor];
    _cycleScrollView.titleLabelTextColor = MGThemeColor_Title_Black;
    _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
    [self.contentView sd_addSubviews:@[_leftImageView, _lineView, _cycleScrollView]];
    
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
- (void)leftImageTapOnClick {
    if (_leftImageTapBlock) {
        _leftImageTapBlock();
    }
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    if (_bulletinCellDidSelectedBlock) {
        _bulletinCellDidSelectedBlock(index);
    }
    
}
#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter
- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (MGResContentDataModel *model in dataArray) {
        [arrayM addObject:model.title];
    }
    
    _cycleScrollView.titlesGroup = arrayM;
}
@end
