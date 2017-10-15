//
//  MGResClassifyModel.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGResClassifyModel.h"

@implementation MGResClassifyDataModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"details" : MGResClassifyDataModel.class};
}

@end

@implementation MGResClassifyModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : MGResClassifyDataModel.class};
}


@end
