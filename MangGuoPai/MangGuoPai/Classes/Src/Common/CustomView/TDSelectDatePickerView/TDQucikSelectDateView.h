//
//  TDQucikSelectDateView.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/20.
//  Copyright © 2017年 梦创. All rights reserved.
//  自定义时间选择器

#import "BaseView.h"
#import "TDQuickSelectDateModel.h"
@protocol TDQucikSelectDateViewDelegate <NSObject>

- (void)pickerView:(UIPickerView *)pickerView didSelectDate:(NSDate *)date;

@end
@interface TDQucikSelectDateView : BaseView

@property (strong, nonatomic)UIPickerView *pickerView;

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, weak) id <TDQucikSelectDateViewDelegate> delegate;

@property (nonatomic, strong) TDQuickSelectDateModel *model;

/// 获取当前选中的时间
- (NSDate *)getCurrentSelectedDate;

/// 定位到当前设置的时间
- (void)setSelectDate:(NSDate *)selectDate animated:(BOOL)animated;

/// 设置顶部提示是否隐藏 pickerView 的高度
- (void)setTopLabelIsHidden:(BOOL)hidden pickerViewHeight:(CGFloat)height;
- (void)setLabelYearMonthDayIsHidden:(BOOL)hidden;

@end
