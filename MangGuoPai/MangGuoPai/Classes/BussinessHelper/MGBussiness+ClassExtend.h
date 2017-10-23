//
//  MGBussiness+ClassExtend.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/17.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussiness.h"

@interface MGBussiness (ClassExtend)

/// 加载导师数据广告
+ (void)loadTeacherAdverDataWithCompletion:(BussinessCompletion)completion error:(BussinessError)error;

/// 加载小功能数据
+ (void)loadTeacherFucntionDataWithCompletion:(BussinessCompletion)completion error:(BussinessError)error;

/// 加载课程列表 - 分页 -
+ (void)loadTeacherCourseListDataWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 加载导师详情
+ (void)loadTeacherDetailDataWithParam:(long)id completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 加载课程详情
+ (void)loadClassDetailDataWithParam:(long)id completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 加载课程分类列表
+ (void)loadCourseCategoryDataWithCompletion:(BussinessCompletion)completion error:(BussinessError)error;

/// 加载课程类型列表
+ (void)loadCourseTypeListDataWithCompletion:(BussinessCompletion)completion error:(BussinessError)error;

/// 删除课程接口
+ (void)loadCourseDelWithId:(long)id completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 上架课程接口
+ (void)loadCourseOnWithId:(long)id completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 下架课程接口
+ (void)loadCourseOffWithId:(long)id completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 新增课程接口
+ (void)loadCourseAddWithParams:(NSDictionary *)params completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 课程点评
+ (void)loadCourse_Comment_Add:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 导师课程回复
+ (void)loadCourse_Comment_Reply:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;


@end
