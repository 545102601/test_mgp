//
//  MGResOrderListModel.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/3.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGResOrderListModel.h"

@implementation MGResOrderListDataModel

/// 转模型时 格式化时间 成 NSDate
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if ([dic unsignedLongLongValueForKey:@"order_time" default:0]) {
        self.order_time = [NSDate dateWithTimeIntervalSince1970: [dic unsignedLongLongValueForKey:@"order_time" default:0] / 1000.0];
    }
    
    if ([dic unsignedLongLongValueForKey:@"sct_date" default:0]) {
        self.sct_date = [NSDate dateWithTimeIntervalSince1970: [dic unsignedLongLongValueForKey:@"sct_date" default:0] / 1000.0];
    }
    
    
    return YES;
}

- (void)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    dic[@"order_time"] = @([self.order_time timeIntervalSince1970] * 1000).description;
    dic[@"sct_date"] = @([self.sct_date timeIntervalSince1970] * 1000).description;
}


- (NSString *)order_time_string {
    if (_order_time_string.length == 0) {
        _order_time_string = [self.order_time dateToStringYYMMDDHHMM];
    }
    return _order_time_string;
}

- (NSString *)sct_date_string {
    if (_sct_date_string.length == 0) {
        _sct_date_string = [self.sct_date dateToStringYYMMDDHHMM];
    }
    return _sct_date_string;
}

@end

@implementation MGResOrderListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : MGResOrderListDataModel.class};
}
@end
