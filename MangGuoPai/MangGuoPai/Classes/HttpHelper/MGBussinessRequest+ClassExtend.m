//
//  MGBussinessRequest+ClassExtend.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussinessRequest+ClassExtend.h"

@implementation MGBussinessRequest (ClassExtend)

/// 导师课程列表接口
+ (void)getCourse_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestGetUrl:HTTP_COURSE_LIST
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:NO
           successBlock:successBlock
             errorBlock:errorBlock];

}

/// 课程分类列表接口
+ (void)getClassify_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {

    [self requestGetUrl:HTTP_CLASSIFY_LIST
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:NO
            successBlock:successBlock
              errorBlock:errorBlock];

}
/// 课程类型列表接口
+ (void)getCoursetype_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestGetUrl:HTTP_COURSETYPE_LIST
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:NO
           successBlock:successBlock
             errorBlock:errorBlock];
    
}
/// 导师详情接口
+ (void)getCourse_Tutor:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestGetUrl:HTTP_COURSE_TUTOR
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:YES
           successBlock:successBlock
             errorBlock:errorBlock];
    
}

/// 课程详情接口
+ (void)getCourse_Get:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestGetUrl:HTTP_COURSE_GET
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:YES
           successBlock:successBlock
             errorBlock:errorBlock];
}

/// 删除课程接口
+ (void)postCourse_Del:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_COURSE_DEL
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:YES
           successBlock:successBlock
             errorBlock:errorBlock];
}

/// 上架课程接口
+ (void)postCourse_On:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_COURSE_ON
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}
/// 下架课程接口
+ (void)postCourse_Off:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_COURSE_OFF
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 新增课程接口
+ (void)postCourse_Add:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTP_COURSE_ADD,dict[@"urls"]];
    NSMutableDictionary *mutableDict = dict.mutableCopy;
    [mutableDict removeObjectForKey:@"urls"];
    
    [self requestPostUrl:url
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:mutableDict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}


/// 课程点评
+ (void)postCourse_Comment_Add:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_COURSE_COMMENT_ADD
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 导师课程回复
+ (void)postCourse_Comment_Reply:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_COURSE_COMMENT_REPLY
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}


@end
