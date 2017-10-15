//
//  MGBussinessRequest+ClassExtend.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussinessRequest.h"

@interface MGBussinessRequest (ClassExtend)

/// 导师课程列表接口
+ (void)getCourse_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

///课程分类列表接口
+ (void)getClassify_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 课程类型列表接口
+ (void)getCoursetype_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 导师详情接口
+ (void)getCourse_Tutor:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 课程详情接口
+ (void)getCourse_Get:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 删除课程接口
+ (void)postCourse_Del:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 上架课程接口
+ (void)postCourse_On:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 下架课程接口
+ (void)postCourse_Off:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

/// 新增课程接口
+ (void)postCourse_Add:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;


@end
