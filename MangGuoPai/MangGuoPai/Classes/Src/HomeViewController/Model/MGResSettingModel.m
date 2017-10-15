//
//  MGResSettingModel.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGResSettingModel.h"

@implementation MGResSettingDataDetailModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"mg_description":@"description"};
}

@end

@implementation MGResSettingDataModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"details" : MGResSettingDataDetailModel.class};
}

@end

@implementation MGResSettingModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : MGResSettingDataModel.class};
}
@end
