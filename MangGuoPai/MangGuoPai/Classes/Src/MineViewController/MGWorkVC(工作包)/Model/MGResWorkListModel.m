//
//  MGResWorkListModel.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/30.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGResWorkListModel.h"


@implementation MGResWorkListDataModel



/// 转模型时 格式化时间 成 NSDate
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if ([dic unsignedLongLongValueForKey:@"publish_time" default:0]) {
        self.publish_time = [NSDate dateWithTimeIntervalSince1970: [dic unsignedLongLongValueForKey:@"publish_time" default:0] / 1000.0];
    }
    
    if ([dic unsignedLongLongValueForKey:@"apply_abort_time" default:0]) {
        self.apply_abort_time = [NSDate dateWithTimeIntervalSince1970: [dic unsignedLongLongValueForKey:@"apply_abort_time" default:0] / 1000.0];
    }
    
    if ([dic unsignedLongLongValueForKey:@"works_abort_time" default:0]) {
        self.works_abort_time = [NSDate dateWithTimeIntervalSince1970: [dic unsignedLongLongValueForKey:@"works_abort_time" default:0] / 1000.0];
    }
    
    if ([dic unsignedLongLongValueForKey:@"appraise_abort_time" default:0]) {
        self.appraise_abort_time = [NSDate dateWithTimeIntervalSince1970: [dic unsignedLongLongValueForKey:@"appraise_abort_time" default:0] / 1000.0];
    }
    
    if ([dic unsignedLongLongValueForKey:@"member_join_time" default:0]) {
        self.member_join_time = [NSDate dateWithTimeIntervalSince1970: [dic unsignedLongLongValueForKey:@"member_join_time" default:0] / 1000.0];
    }
    return YES;
}

- (void)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    dic[@"publish_time"] = @([self.publish_time timeIntervalSince1970] * 1000).description;
    dic[@"apply_abort_time"] = @([self.apply_abort_time timeIntervalSince1970] * 1000).description;
    
    dic[@"works_abort_time"] = @([self.works_abort_time timeIntervalSince1970] * 1000).description;
    dic[@"appraise_abort_time"] = @([self.appraise_abort_time timeIntervalSince1970] * 1000).description;
    
    dic[@"member_join_time"] = @([self.member_join_time timeIntervalSince1970] * 1000).description;
    
}


- (NSString *)publish_time_str {
    if (_publish_time_str.length == 0) {
        _publish_time_str = [self.publish_time stringWithFormat:@"yyyy-MM-dd"];
    }
    return _publish_time_str;
}

- (NSString *)apply_abort_time_str {
    if (_apply_abort_time_str.length == 0) {
        _apply_abort_time_str = [self.apply_abort_time stringWithFormat:@"yyyy-MM-dd"];
    }
    return _apply_abort_time_str;
}

- (NSString *)appraise_abort_time_str {
    if (_appraise_abort_time_str.length == 0) {
        _appraise_abort_time_str = [self.appraise_abort_time stringWithFormat:@"yyyy-MM-dd"];
    }
    return _appraise_abort_time_str;
}


- (NSString *)works_abort_time_str {
    if (_works_abort_time_str.length == 0) {
        _works_abort_time_str = [self.works_abort_time stringWithFormat:@"yyyy-MM-dd"];
    }
    return _works_abort_time_str;
}

- (NSString *)member_join_time_str {
    if (_member_join_time_str.length == 0) {
        _member_join_time_str = [self.member_join_time stringWithFormat:@"yyyy-MM-dd"];
    }
    return _member_join_time_str;
}


@end

@implementation MGResWorkListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : MGResWorkListDataModel.class};
}

@end
