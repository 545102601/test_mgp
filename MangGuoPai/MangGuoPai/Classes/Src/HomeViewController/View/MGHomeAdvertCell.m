//
//  MGHomeTableAdvertCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGHomeAdvertCell.h"
#import "SDCycleScrollView.h"
#import "MGResSettingModel.h"

@interface MGHomeAdvertCell () <SDCycleScrollViewDelegate>
/// 轮播图
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;


@end

@implementation MGHomeAdvertCell

- (void)preapreCellUI {
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, SH(400)) delegate:self placeholderImage:nil];
    _cycleScrollView.backgroundColor = [UIColor whiteColor];
    _cycleScrollView.autoScrollTimeInterval = 3;
    _cycleScrollView.currentPageDotColor = MGThemeBackgroundColor;
    _cycleScrollView.pageDotColor = MGTextPlaceholderColor;
    _cycleScrollView.placeholderImage = SDWEB_PLACEHODER_IMAGE(_cycleScrollView);
    
    [self.contentView addSubview:_cycleScrollView];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    if (_advertCellDidSelectedBlock) {
        _advertCellDidSelectedBlock(index);
    }
    
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (MGResSettingDataDetailModel *detailModel in dataArray) {
        [arrayM addObject:detailModel.file_path];
    }
    _cycleScrollView.imageURLStringsGroup = [arrayM copy];
}

@end
