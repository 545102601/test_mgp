//
//  MGCouponOwnsModel.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/12.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGCouponOwnsModel.h"

@implementation MGCouponOwnsDataModel

/// 转模型时 格式化时间 成 NSDate
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if ([dic unsignedLongLongValueForKey:@"end_time" default:0]) {
        self.end_time = [NSDate dateWithTimeIntervalSince1970: [dic unsignedLongLongValueForKey:@"end_time" default:0] / 1000.0];
    }
    
    if ([dic unsignedLongLongValueForKey:@"start_time" default:0]) {
        self.start_time = [NSDate dateWithTimeIntervalSince1970: [dic unsignedLongLongValueForKey:@"start_time" default:0] / 1000.0];
    }
    
    return YES;
}

- (void)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    dic[@"end_time"] = @([self.end_time timeIntervalSince1970] * 1000).description;
    dic[@"start_time"] = @([self.start_time timeIntervalSince1970] * 1000).description;
    
}


- (NSString *)end_time_str {
    if (_end_time_str.length == 0) {
        _end_time_str = [self.end_time stringWithFormat:@"yyyy-MM-dd"];
    }
    return _end_time_str;
}

- (NSString *)start_time_str {
    if (_start_time_str.length == 0) {
        _start_time_str = [self.start_time stringWithFormat:@"yyyy-MM-dd"];
    }
    return _start_time_str;
}


@end


@implementation MGCouponOwnsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : MGCouponOwnsDataModel.class};
}

@end
