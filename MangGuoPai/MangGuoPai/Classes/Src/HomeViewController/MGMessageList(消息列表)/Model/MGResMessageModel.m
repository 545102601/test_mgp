//
//  MGResMessageModel.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGResMessageModel.h"

@implementation MGResMessageDataModel

- (BOOL)isRead {
    
    if (_state == 50) {
        return NO;
    }
    return YES;
}

@end

@implementation MGResMessageModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : MGResMessageDataModel.class};
}

@end
