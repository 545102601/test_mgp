//
//  MGResMemberModel.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGResMemberModel.h"

@implementation MGResMemberDataModel


/// 转模型时 格式化时间 成 NSDate
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if ([dic unsignedLongLongValueForKey:@"birthday" default:0] > 0) {
        self.birthday = [NSDate dateWithTimeIntervalSince1970: [dic unsignedLongLongValueForKey:@"birthday" default:0] / 1000.0];
    }
    return YES;
}

- (void)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    dic[@"birthday"] = @([self.birthday timeIntervalSince1970] * 1000).description;
    
}
///// 附加 -
///// 是否已经有了身份
- (BOOL)hasID {
    return memberDataModelInstance.user_identitys.count > 1;
}
/// 是否是学生身份
- (BOOL)isStudentID {
    return [memberDataModelInstance.user_identitys containsObject:@"student"];
}
/// 是否是老师身份
- (BOOL)isTutorID {
    return [memberDataModelInstance.user_identitys containsObject:@"tutor"];
}
/// 是否是社团身份
- (BOOL)isCommunityID {
    return [memberDataModelInstance.user_identitys containsObject:@"community"];
}
/// 是否是企业身份
- (BOOL)isCompanyID {
    return [memberDataModelInstance.user_identitys containsObject:@"company"];
}

@end

@implementation MGResMemberModel

DEF_SINGLETON(MGResMemberModel)

@end
