//
//  MGResCouponPromotionModel.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/17.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGResCouponPromotionModel.h"

@implementation MGResCouponPromotionDataModel

@end

@implementation MGResCouponPromotionModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : MGResCouponPromotionDataModel.class};
}

@end
