//
//  TDSelectDatePickerView.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/7/8.
//  Copyright © 2017年 梦创. All rights reserved.
//

#import "BaseView.h"
#import "TDQucikSelectDateView.h"
@class TDSelectDatePickerView;

@protocol TDSelectDatePickerViewDelegate <NSObject>
@optional;
/// 点击确定按钮
- (void)selectDatePickerView:(TDSelectDatePickerView *)pickerView
        didSureButtonOnClick:(NSDate *)date;

@end

@interface TDSelectDatePickerView : BaseView

/// 最小时间
@property (nonatomic, strong) NSDate *minDate;

/// 最大时间
@property (nonatomic, strong) NSDate *maxDate;

@property (nonatomic, weak) id <TDSelectDatePickerViewDelegate> delegate;

@property (nonatomic, strong) TDQucikSelectDateView *dateView;


- (void)showSelectDatePickViewWithAnimated:(BOOL)animated inView:(UIView *)view;

- (void)hideSelectDatePickViewWithAnimated:(BOOL)animated inView:(UIView *)view;



@end
