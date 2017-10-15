//
//  MGResProjectTeamModel.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/2.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGResProjectTeamModel.h"

@implementation MGResProjectTeamMemberDataModel


@end

@implementation MGResProjectTeamDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"members" : MGResProjectTeamMemberDataModel.class};
}
@end


@implementation MGResProjectTeamModel

@end
