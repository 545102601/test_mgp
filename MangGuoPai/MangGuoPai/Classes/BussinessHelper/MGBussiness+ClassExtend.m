//
//  MGBussiness+ClassExtend.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/17.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussiness+ClassExtend.h"
#import "MGResCourseListModel.h"
#import "MGResClassifyModel.h"
#import "MGResCourseTutorModel.h"
#import "MGResCourseListDetailModel.h"
#import "MGResCourseTypeListModel.h"

@implementation MGBussiness (ClassExtend)

/// 加载导师数据广告
+ (void)loadTeacherAdverDataWithCompletion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest getCourse_List:@{@"hot_types" : @"1"} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if (isSuccess) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                MGResCourseListModel *model = [MGResCourseListModel yy_modelWithDictionary:dic];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(model.data);
                    }
                });
            });
        } else {
             [self showMBText:message];
            if (error) {
                error(nil);
            }
        }
    } errorBlock:error];

}
/// 加载小功能数据
+ (void)loadTeacherFucntionDataWithCompletion:(BussinessCompletion)completion error:(BussinessError)error{
    [MGBussinessRequest getClassify_List:@{@"show_top" : @"1"} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                MGResClassifyModel *classifyModel = [MGResClassifyModel yy_modelWithDictionary:dic];
                
                NSMutableArray *funcResultsM = classifyModel.data.mutableCopy;
                
                if (funcResultsM.count > 0) { /// 添加全部
                    
                    for (MGResClassifyDataModel *dataModel in funcResultsM) {
                       NSMutableArray *detailArray = dataModel.details.mutableCopy;
                        if (!detailArray) {
                            detailArray = @[].mutableCopy;
                        }
//                        /// 子类 添加 全部
//                        MGResClassifyDataModel *sub_model = [MGResClassifyDataModel new];
//                        sub_model.id = -1000;
//                        sub_model.classify_name = @"全部";
//                        
//                        [detailArray addObject:sub_model];
                        dataModel.details = [detailArray copy];
                        
                    }
                    
                    
                    MGResClassifyDataModel *dataModel = [MGResClassifyDataModel new];
                    dataModel.id = -1000;
                    [funcResultsM addObject:dataModel];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (completion) {
                        completion([funcResultsM copy]);
                    }
                });
                
            });
        } else {
            [self showMBText:message];
            if (error) {
                error(nil);
            }
        }
    } errorBlock:error];
}

/// 加载课程列表数据
+ (void)loadTeacherCourseListDataWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest getCourse_List:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if (isSuccess) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                MGResCourseListModel *model = [MGResCourseListModel yy_modelWithDictionary:dic];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(model);
                    }
                });
            });
        } else {
            [self showMBText:message];
            if (error) {
                error(nil);
            }
        }
    } errorBlock:error];    
}


/// 加载导师详情
+ (void)loadTeacherDetailDataWithParam:(long)id completion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest getCourse_Tutor:@{@"id" : @(id)} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if(isSuccess) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                MGResCourseTutorModel *model = [MGResCourseTutorModel yy_modelWithDictionary:dic];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(completion) {
                        completion(model.data);
                    }
                });
            });
        } else {
            [self showMBText:message];
        }
    } errorBlock:nil];

}


/// 加载课程详情
+ (void)loadClassDetailDataWithParam:(long)id completion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest getCourse_Get:@{@"id" : @(id)} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if(isSuccess) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                MGResCourseListDetailModel *model = [MGResCourseListDetailModel yy_modelWithDictionary:dic];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(completion) {
                        completion(model.data);
                    }
                });
            });
        } else {
            [self showMBText:message];
        }
    } errorBlock:nil];
}

/// 加载课程分类列表
+ (void)loadCourseCategoryDataWithCompletion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest getClassify_List:@{@"show_top" : @"1"} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                MGResClassifyModel *classifyModel = [MGResClassifyModel yy_modelWithDictionary:dic];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(classifyModel.data);
                    }
                });
            });
        } else {
            [self showMBText:message];
            if (error) {
                error(nil);
            }
        }
    } errorBlock:error];
}
/// 加载课程类型列表
+ (void)loadCourseTypeListDataWithCompletion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest getCoursetype_List:nil successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                MGResCourseTypeListModel *courseTypeListModel = [MGResCourseTypeListModel yy_modelWithDictionary:dic];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(courseTypeListModel.data);
                    }
                });
            });
        } else {
            [self showMBText:message];
            if (error) {
                error(nil);
            }
        }
    } errorBlock:error];
}
/// 删除课程接口
+ (void)loadCourseDelWithId:(long)id completion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest postCourse_Del:@{@"id" : @(id)} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if (isSuccess) {
            [self showMBText:message];
            if (completion) {
                completion(@(isSuccess));
            }
        } else {
            [self showMBText:message];
        }
        
    } errorBlock:error];
    
}
/// 上架课程接口
+ (void)loadCourseOnWithId:(long)id completion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest postCourse_On:@{@"id" : @(id)} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if (isSuccess) {
            if (completion) {
                completion(@(isSuccess));
            }
        } else {
            [self showMBText:message];
        }
        
    } errorBlock:error];
}
/// 下架课程接口
+ (void)loadCourseOffWithId:(long)id completion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest postCourse_Off:@{@"id" : @(id)} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if (isSuccess) {
            if (completion) {
                completion(@(isSuccess));
            }
        } else {
            [self showMBText:message];
        }
        
    } errorBlock:error];
}
/// 新增课程接口
+ (void)loadCourseAddWithParams:(NSDictionary *)params completion:(BussinessCompletion)completion error:(BussinessError)error {

    [MGBussinessRequest postCourse_Add:params successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            if (completion) {
                completion(@(isSuccess));
            }
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
    
    
}




@end
