//
//  MGResEntityModel.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGResEntityModel.h"

@implementation MGResEntityDataModel



@end

@implementation MGResEntityModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : MGResEntityDataModel.class};
}


@end
