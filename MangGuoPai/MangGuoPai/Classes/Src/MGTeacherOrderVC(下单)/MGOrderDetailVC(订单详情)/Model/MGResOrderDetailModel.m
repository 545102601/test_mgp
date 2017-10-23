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

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"comments" : MGResOrderDetailCommentModel.class};
}

@end

@implementation MGResOrderDetailModel



@end
