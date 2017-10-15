//
//  TDQuickSelectDateModel.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/20.
//  Copyright © 2017年 梦创. All rights reserved.
//

#import <Foundation/Foundation.h>
/// 月
@interface TDQuickSelectDateMonthModel : NSObject

@property (nonatomic, copy) NSString *month;

@property (nonatomic, strong) NSMutableArray *dayArray;

@end

/// 年
@interface TDQuickSelectDateYearModel : NSObject

@property (nonatomic, copy) NSString *year;

@property (nonatomic, strong) NSMutableArray *monthArray;

@end


@interface TDQuickSelectDateModel : NSObject

@property (nonatomic, strong) NSMutableArray *yearArray;


@end
