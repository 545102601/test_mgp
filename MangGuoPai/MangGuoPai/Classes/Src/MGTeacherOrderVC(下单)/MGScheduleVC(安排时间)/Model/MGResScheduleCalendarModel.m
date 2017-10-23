//
//  MGResScheduleCalendarModel.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGResScheduleCalendarModel.h"

@implementation MGResScheduleCalendarTimeDataModel



@end

@implementation MGResScheduleCalendarDataModel

/// 转模型时 格式化时间 成 NSDate
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if ([dic unsignedLongLongValueForKey:@"sct_date" default:0]) {
        self.sct_date = [NSDate dateWithTimeIntervalSince1970: [dic unsignedLongLongValueForKey:@"sct_date" default:0] / 1000.0];
    }
    
    return YES;
}

- (void)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    dic[@"sct_date"] = @([self.sct_date timeIntervalSince1970] * 1000).description;
    
}
- (NSString *)sct_date_str {
    if (_sct_date_str.length == 0) {
        _sct_date_str = [self.sct_date stringWithFormat:@"yyyy-MM-dd"];
    }
    return _sct_date_str;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"details" : MGResScheduleCalendarTimeDataModel.class};
}

@end

@implementation MGResScheduleCalendarModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : MGResScheduleCalendarDataModel.class};
}

@end
