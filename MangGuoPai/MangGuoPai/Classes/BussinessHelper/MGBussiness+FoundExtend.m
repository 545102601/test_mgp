//
//  MGBussiness+FoundExtend.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussiness+FoundExtend.h"
#import "MGResTrendListModel.h"

@implementation MGBussiness (FoundExtend)

/// 动态列表 - 分页
+ (void)loadTrendListWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest getTrend_List:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if (isSuccess) {
            MGResTrendListModel *listModel = [MGResTrendListModel yy_modelWithDictionary:dic];
            if (completion) {
                completion(listModel);
            }
            
        } else {
            [self showMBText:message];
        }
        
    } errorBlock:error];
    
}


/// 添加动态
+ (void)loadTrend_AddWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest postTrend_Add:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        [self showMBText:message];
        if (isSuccess) {
            if (completion) {
                completion(@(isSuccess));
            }
        }
    } errorBlock:error];
    
}

/// 检测动态
+ (void)loadTrend_UpdateWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest getTrend_Update:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (completion) {
            completion(@(isSuccess));
        }
        
    } errorBlock:error];

}
/// 点赞 接口
+ (void)loadPraiseWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest postPraise_Count:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            if (completion) {
                completion(@(isSuccess));
            }
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
    
}

/// 想听 接口
+ (void)loadWantCountWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest postWant_Count:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if (completion) {
            completion(@(isSuccess));
        }
    } errorBlock:error];

}


/// 动态详情
+ (void)loadTrend_GetWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest getTrend_Get:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            MGResTrendDetailModel *model = [MGResTrendDetailModel yy_modelWithDictionary:dic];
            if (completion) {
                completion(model.data);
            }
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
    
}

/// 回复动态评论
+ (void)loadTrend_ReplyWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest postTrend_Reply:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        [self showMBText:message];
        if (completion) {
            completion(@(isSuccess));
        }
    } errorBlock:error];
}

@end
