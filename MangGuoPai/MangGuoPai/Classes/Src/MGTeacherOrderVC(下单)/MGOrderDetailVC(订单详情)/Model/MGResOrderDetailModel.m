//
//  MGResOrderDetailModel.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/7.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGResOrderDetailModel.h"

@implementation MGResOrderDetailCommentModel


@end

@implementation MGResOrderDetailDataModel
/// 转模型时 格式化时间 成 NSDate
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if ([dic unsignedLongLongValueForKey:@"order_time" default:0]) {
        self.order_time = [NSDate dateWithTimeIntervalSince1970: [dic unsignedLongLongValueForKey:@"order_time" default:0] / 1000.0];
    }
    
    return YES;
}

- (void)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    dic[@"order_time"] = @([self.order_time timeIntervalSince1970] * 1000).description;

}


- (NSString *)order_time_string {
    if (_order_time_string.length == 0) {
        _order_time_string = [self.order_time dateToStringYYMMDDHHMM];
    }
    return _order_time_string;
}


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"comments" : MGResOrderDetailCommentModel.class};
}

@end

@implementation MGResOrderDetailModel



@end
