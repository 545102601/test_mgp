//
//  YNPageControl.h
//  test
//
//  Created by ZYN on 16/6/25.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
//样式
typedef NS_ENUM(NSInteger, YNPageControlType) {

    YNPageControlTypeOnFullOffFull   = 0,
    YNPageControlTypeOnFullOffEmpty  = 1,
    YNPageControlTypeOnEmptyOffFull  = 2,
    YNPageControlTypeOnEmptyOffEmpty = 3,
    
};

@interface YNPageControl : UIControl
//系统属性
@property (nonatomic, assign) NSInteger numberOfPages;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, assign) BOOL hidesForSinglePage;//default is YES

@property (nonatomic, assign) BOOL defersCurrentPageDisplay;
//大小
@property (nonatomic, assign) CGFloat indicatorDiameter;
//间距
@property (nonatomic, assign) CGFloat indicatorSpace;
//当前颜色
@property (nonatomic, strong) UIColor *onColor;
//
@property (nonatomic, strong) UIColor *offColor;
//内嵌颜色
@property (nonatomic, strong) UIColor *insetColor;
//样式
@property (nonatomic, assign) YNPageControlType pageType;
//刷新
- (void)updateCurrentPageDisplay ;
//大小
- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;
//初始化
- (instancetype)initWithType:(YNPageControlType)pageType ;

@end
