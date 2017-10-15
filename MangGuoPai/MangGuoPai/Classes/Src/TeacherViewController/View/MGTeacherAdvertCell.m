//
//  MGTeacherAdvertCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherAdvertCell.h"
#import "SDCycleScrollView.h"
#import "MGResCourseListModel.h"

@interface MGTeacherAdvertCell ()<SDCycleScrollViewDelegate>

/// 轮播图
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;


@end

@implementation MGTeacherAdvertCell

- (void)preapreCellUI {
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, SH(750)) delegate:self placeholderImage:nil];
    _cycleScrollView.backgroundColor = [UIColor whiteColor];
    _cycleScrollView.autoScrollTimeInterval = 3;
    _cycleScrollView.currentPageDotColor = MGThemeBackgroundColor;
    _cycleScrollView.pageDotColor = MGTextPlaceholderColor;
    _cycleScrollView.titleLabelTextFont = PFSC(30);
    _cycleScrollView.titleLabelBackgroundColor = RGBA(0, 0, 0, 0.5);
    _cycleScrollView.titleLabelTextColor = [UIColor whiteColor];
    _cycleScrollView.titleLabelTextAlignment = NSTextAlignmentCenter;
    _cycleScrollView.titleLabelHeight = SH(60);
    _cycleScrollView.placeholderImage = SDWEB_PLACEHODER_IMAGE(_cycleScrollView);
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
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
    NSMutableArray *titleArrayM = @[].mutableCopy;
    for (MGResCourseListDataModel *dataModel in dataArray) {
        if (dataModel.tutor_logo_rsurl.length > 0) {
            [arrayM addObject:dataModel.tutor_logo_rsurl];
        }
        if (dataModel.course_title.length > 0) {
            [titleArrayM addObject:dataModel.course_title];
        }
    }
    
    _cycleScrollView.imageURLStringsGroup = [arrayM copy];
    _cycleScrollView.titlesGroup = [titleArrayM copy];
}

@end
