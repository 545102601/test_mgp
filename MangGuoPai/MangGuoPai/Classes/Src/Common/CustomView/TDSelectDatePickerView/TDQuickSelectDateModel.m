//
//  TDQuickSelectDateModel.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/20.
//  Copyright © 2017年 梦创. All rights reserved.
//

#import "TDQuickSelectDateModel.h"



@implementation TDQuickSelectDateMonthModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _dayArray = @[].mutableCopy;
        
    }
    return self;
}

@end

@implementation TDQuickSelectDateYearModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _monthArray = @[].mutableCopy;
        
    }
    return self;
}


@end

@implementation TDQuickSelectDateModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _yearArray = @[].mutableCopy;
        
        
        static NSDateFormatter *format = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            format = [[NSDateFormatter alloc] init];
            format.dateFormat = @"yyyy-MM-dd";
        });
        
        /// 年
        for (int i = 1970; i < 2051; i++) {
            @autoreleasepool {
                TDQuickSelectDateYearModel *yModel = [[TDQuickSelectDateYearModel alloc] init];
                yModel.year = [NSString stringWithFormat:@"%zd",i];
                
                for (int j = 1; j < 13; j++) {
                    TDQuickSelectDateMonthModel *model= [[TDQuickSelectDateMonthModel alloc] init];
                    
                    if (j < 10) {
                        model.month = [NSString stringWithFormat:@"0%zd",j];
                    } else {
                        model.month = [NSString stringWithFormat:@"%zd",j];
                    }
                    
                    
                    NSDate *date = [format dateFromString:[NSString stringWithFormat:@"%zd-%zd-1",i,j]];
                    
                    NSInteger day = [date getNumberOfDaysInMonth];
                    for (int m = 1; m <= day; m++) {
                        if (m < 10) {
                            [model.dayArray addObject:[NSString stringWithFormat:@"0%zd",m]];
                        } else {
                            [model.dayArray addObject:[NSString stringWithFormat:@"%zd",m]];
                        }
                    }
                    
                    [yModel.monthArray addObject:model];
                }
                [_yearArray addObject:yModel];
            }
        }
    }
    return self;
}

@end
