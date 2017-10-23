//
//  MGResScheduleCalendarModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"

@interface MGResScheduleCalendarTimeDataModel : BaseModel

/// 时间点
@property (nonatomic, assign) long sct_time;

/// 是否有课程
@property (nonatomic, assign) BOOL salable;
/// 当前订单是否有安排
@property (nonatomic, assign) BOOL cur_join;
/// 原因
@property (nonatomic, copy) NSString *cause;
/// 已经安排数量
@property (nonatomic, assign) NSInteger count;

@end

@interface MGResScheduleCalendarDataModel : BaseModel

/// 日期
@property (nonatomic, strong) NSDate *sct_date;
@property (nonatomic, copy) NSString *sct_date_str;

/// 是否有课程
@property (nonatomic, assign) BOOL salable;
/// 当前订单是否有安排
@property (nonatomic, assign) BOOL cur_join;
/// 原因
@property (nonatomic, copy) NSString *cause;
/// 安排时间
@property (nonatomic, copy) NSArray *details;



@end

@interface MGResScheduleCalendarModel : BaseResModel

@property (nonatomic, copy) NSArray *data;

@end
