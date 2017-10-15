//
//  MGResTrendListModel.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/4.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGResTrendListModel.h"
#import <YYText.h>

@implementation MGResFoundDetailCommentDataModel

/// 转模型时 格式化时间 成 NSDate
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if ([dic unsignedLongLongValueForKey:@"comment_time" default:0] > 0) {
        self.comment_time = [NSDate dateWithTimeIntervalSince1970: [dic unsignedLongLongValueForKey:@"comment_time" default:0] / 1000.0];
    }
    
    
    return YES;
}

- (void)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    dic[@"comment_time"] = @([self.comment_time timeIntervalSince1970] * 1000).description;
    
}


- (NSString *)comment_time_str {
    
    return [self.comment_time getRefreshNowTime];
    
}

@end


@implementation MGResTrendListDataModel
{
    BOOL isCalcuContent;
    
}
- (NSString *)content {

    if (!isCalcuContent) {
        isCalcuContent = YES;
        if (_content.length > 50) {
            _shouldShowMoreButton = YES;
        } else {
            _shouldShowMoreButton = NO;
        }
    }
    return _content;
}

- (void)setIsOpening:(BOOL)isOpening
{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
    }
}

/// 转模型时 格式化时间 成 NSDate
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if ([dic unsignedLongLongValueForKey:@"publish_time" default:0] > 0) {
        self.publish_time = [NSDate dateWithTimeIntervalSince1970: [dic unsignedLongLongValueForKey:@"publish_time" default:0] / 1000.0];
    }
    
    
    return YES;
}

- (void)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    dic[@"publish_time"] = @([self.publish_time timeIntervalSince1970] * 1000).description;
    
}


- (NSString *)publish_time_str {
    
    return [self.publish_time getRefreshNowTime];

}

- (BOOL)isSelfTrend {
    return memberDataModelInstance.id == self.publisher_id;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"comments" : MGResFoundDetailCommentDataModel.class};
}


@end

@implementation MGResTrendListModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : MGResTrendListDataModel.class};
}

@end

@implementation MGResTrendDetailModel


@end
