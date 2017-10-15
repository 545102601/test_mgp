//
//  TDQucikSelectDateView.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/20.
//  Copyright © 2017年 梦创. All rights reserved.
//

#import "TDQucikSelectDateView.h"
#import "TDQucikDateTitleView.h"

@interface TDQucikSelectDateView () <UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UILabel *yearLabel;
@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UILabel *dayLabel;

@end
@implementation TDQucikSelectDateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    
    _topLabel = [MGUITool labelWithText:@"开始时间" textColor:MGThemeColor_Black font:PFSC(32) textAlignment:NSTextAlignmentCenter];
    
    
    _yearLabel = [MGUITool labelWithText:@"年" textColor:MGThemeBackgroundColor font:PFSC(24)];
    
    _monthLabel = [MGUITool labelWithText:@"月" textColor:MGThemeBackgroundColor font:PFSC(24)];
    
    _dayLabel = [MGUITool labelWithText:@"日" textColor:MGThemeBackgroundColor font:PFSC(24)];
    
    
    _pickerView = [[UIPickerView alloc] init];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    
    [self sd_addSubviews:@[_topLabel, _pickerView, _yearLabel, _monthLabel, _dayLabel]];
    
    _topLabel.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topSpaceToView(self, 0)
    .heightIs(_topLabel.fontLineHeight);
    
    _pickerView.sd_layout
    .topSpaceToView(_topLabel,getScaleHeight(48))
    .leftSpaceToView(self, getScaleWidth(40))
    .rightSpaceToView(self, getScaleWidth(40))
    .heightIs(getScaleHeight(280));
    
    _yearLabel.sd_layout
    .centerYEqualToView(_pickerView)
    .leftSpaceToView(self, SW(204))
    .widthIs(SW(44))
    .heightIs(_yearLabel.fontLineHeight);
    
    
    _monthLabel.sd_layout
    .centerYEqualToView(_pickerView)
    .leftSpaceToView(self, SW(410))
    .widthIs(SW(44))
    .heightIs(_yearLabel.fontLineHeight);
    
    
    _dayLabel.sd_layout
    .centerYEqualToView(_pickerView)
    .leftSpaceToView(self, SW(636))
    .widthIs(SW(44))
    .heightIs(_yearLabel.fontLineHeight);
    
    
    
}


#pragma mark - UIPickView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)componen {
    if (componen == 0) {
        return self.model.yearArray.count;
    } else if (componen == 1) {
        
        NSInteger row = [pickerView selectedRowInComponent:0];
        TDQuickSelectDateYearModel *yModel = self.model.yearArray[row];
        return yModel.monthArray.count;
        
    } else if (componen == 2) {
        NSInteger y_row = [pickerView selectedRowInComponent:0];
        TDQuickSelectDateYearModel *yModel = self.model.yearArray[y_row];
        
        NSInteger m_row = [pickerView selectedRowInComponent:1];
        TDQuickSelectDateMonthModel *mModel = yModel.monthArray[m_row];
        return mModel.dayArray.count;
        
    }
    
    return 0;
    
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.height = MGSepLineHeight;
            singleLine.backgroundColor = MGSepColor;
        }
    }
    
    TDQucikDateTitleView * titleView = (TDQucikDateTitleView*)view;
    if(titleView == nil){
        titleView = [[TDQucikDateTitleView alloc] initWithFrame:CGRectMake(0, 0, SW(154), SH(28))];
    }
//    NSInteger y_row = [pickerView selectedRowInComponent:0];
//    TDQuickSelectDateYearModel *yModel = self.model.yearArray[y_row];
//    
//    NSInteger m_row = [pickerView selectedRowInComponent:1];
//    TDQuickSelectDateMonthModel *mModel = yModel.monthArray[m_row];
//    return mModel.dayArray.count;
//
    
    switch (component) {
        case 0:
        {
            TDQuickSelectDateYearModel *yModel = self.model.yearArray[row];
            titleView.dateLabel.text = yModel.year;
            
        }
            break;
        case 1:
        {
            NSInteger y_row = [pickerView selectedRowInComponent:0];
            TDQuickSelectDateYearModel *yModel = self.model.yearArray[y_row];
            TDQuickSelectDateMonthModel *mModel = yModel.monthArray[row];
            titleView.dateLabel.text = mModel.month;
        }
            break;
        case 2:
        {
            NSInteger y_row = [pickerView selectedRowInComponent:0];
            TDQuickSelectDateYearModel *yModel = self.model.yearArray[y_row];
        
            NSInteger m_row = [pickerView selectedRowInComponent:1];
            TDQuickSelectDateMonthModel *mModel = yModel.monthArray[m_row];
            if (row < mModel.dayArray.count) {
                titleView.dateLabel.text = mModel.dayArray[row];
            }
        }
            break;
        default:
            break;
    }
    
    return titleView;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 25 * 2;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    switch (component) {
        case 0:
        {
            
            [pickerView reloadAllComponents];
        }
            break;
        case 1:
        {
            
            NSInteger y_row = [pickerView selectedRowInComponent:0];
            TDQuickSelectDateYearModel *yModel = self.model.yearArray[y_row];
            
            TDQuickSelectDateMonthModel *mModel = yModel.monthArray[row];
            
            NSInteger d_row = [pickerView selectedRowInComponent:2];
            
            
            NSInteger targetInt = 0;
            if (d_row > mModel.dayArray.count - 1) {
                targetInt = mModel.dayArray.count - 1;
                
                
            } else {
                targetInt = d_row;
            }
            
            //刷新
            
            [pickerView reloadAllComponents];
            //设置重新选中第一个
            [pickerView selectRow:targetInt inComponent:2 animated:YES];
           
            }
            break;
        case 2:
            
            
            [pickerView reloadAllComponents];
            break;
        default:
            break;
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:didSelectDate:)]) {

        [self.delegate pickerView:pickerView didSelectDate:[self getCurrentSelectedDate]];
    }
}
- (NSDate *)getCurrentSelectedDate {
    
    NSInteger y_row = [_pickerView selectedRowInComponent:0];
    TDQuickSelectDateYearModel *yModel = self.model.yearArray[y_row];
    
    NSInteger m_row = [_pickerView selectedRowInComponent:1];
    TDQuickSelectDateMonthModel *mModel = yModel.monthArray[m_row];
    
    
    NSInteger d_row = [_pickerView selectedRowInComponent:2];
    
    NSString *day = mModel.dayArray[d_row];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [format dateFromString:[NSString stringWithFormat:@"%@-%@-%@",yModel.year, mModel.month, day]];
    date = [date dateFormattedWithFormatString:@"yyyy-MM-dd"];
    return date;
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

- (void)setSelectDate:(NSDate *)selectDate animated:(BOOL)animated {
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        NSString *year = [NSString stringWithFormat:@"%zd",selectDate.year];
        NSString *month = [NSString stringWithFormat:@"%zd",selectDate.month];
        NSString *day = [NSString stringWithFormat:@"%zd",selectDate.day];
        
        /// 找出idnex
        NSInteger y_row = 0;
        NSInteger m_row = 0;
        NSInteger d_row = 0;
        for (int i = 0; i < self.model.yearArray.count; i++) {
            TDQuickSelectDateYearModel *y_model = self.model.yearArray[i];
            if ([y_model.year rangeOfString:year].location != NSNotFound) {
                
                for (int j = 0; j < y_model.monthArray.count; j++) {
                    TDQuickSelectDateMonthModel *m_model = y_model.monthArray[j];
                    if ([m_model.month rangeOfString:month].location != NSNotFound) {
                        
                        for (int m = 0; m < m_model.dayArray.count; m++) {
                            NSString *DAY = m_model.dayArray[m];
                            if ([DAY rangeOfString:day].location != NSNotFound) {
                                y_row = i;
                                m_row = j;
                                d_row = m;
                                break;
                            }
                        }
                        break;
                    }
                    
                }
                break;
            }
            
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.pickerView selectRow:y_row inComponent:0 animated:animated];
            [self.pickerView selectRow:m_row inComponent:1 animated:animated];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:d_row inComponent:2 animated:animated];
            
            
        });
        
    });
    
    
}


#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

/// 设置顶部提示是否隐藏 pickerView 的高度
- (void)setTopLabelIsHidden:(BOOL)hidden pickerViewHeight:(CGFloat)height {
    self.topLabel.hidden = hidden;
    
    
    
    _pickerView.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(self, getScaleWidth(40))
    .rightSpaceToView(self, getScaleWidth(40))
    .heightIs(getScaleHeight(height));
}
- (void)setLabelYearMonthDayIsHidden:(BOOL)hidden {
    
    self.yearLabel.hidden = hidden;
    
    self.monthLabel.hidden = hidden;

    self.dayLabel.hidden = hidden;
}
#pragma mark - Private Function

#pragma mark - Getter and Setter

@end
