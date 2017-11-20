//
//  MGBussiness+WorkExtend.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/30.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussiness+WorkExtend.h"
#import "MGResWorkListModel.h"
#import "MGResProjectDetailModel.h"
#import "MGResProjectListTeamModel.h"
#import "MGResProjectTeamModel.h"


@implementation MGBussiness (WorkExtend)


/// 工作包列表 - 分页
+ (void)loadWorkListWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {

    [MGBussinessRequest getWork_List:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if (isSuccess) {
            MGResWorkListModel *listModel = [MGResWorkListModel yy_modelWithDictionary:dic];
            if (completion) {
                completion(listModel);
            }
            
        } else {
            [self showMBText:message];
        }
        
    } errorBlock:error];
}

/// 工作包报名
+ (void)loadProject_Join:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest postProject_Join:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if (isSuccess) {
            if (completion) {
                completion(@(isSuccess));
            }
        } else {
            [self showMBText:message];
        }
        
    } errorBlock:error];
    
    
}

/// 工作包参加团队列表接口
+ (void)loadProject_Teams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {

    
    [MGBussinessRequest getProject_Teams:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            MGResProjectListTeamModel *model = [MGResProjectListTeamModel yy_modelWithDictionary:dic];
            if (completion) {
                completion(model.data);
            }
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
    
}

/// 工作包详情
+ (void)loadProject_Get:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {

    
    [MGBussinessRequest getProject_Get:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            MGResProjectDetailModel *model = [MGResProjectDetailModel yy_modelWithDictionary:dic];
            
            if (completion) {
                completion(model.data);
            }
            
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
}

/// 工作包参与者详情接口
+ (void)loadProject_Actor_Get:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest getProject_Actor_Get:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            MGResProjectActorModel *model = [MGResProjectActorModel yy_modelWithDictionary:dic];
            if (completion) {
                completion(model.data);
            }
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
    
}

/// 工作包参与者团队详情接口
+ (void)loadActor_Team_Get:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {

    [MGBussinessRequest getActor_Team_Get:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            MGResProjectTeamModel *model = [MGResProjectTeamModel yy_modelWithDictionary:dic];
            if (completion) {
                completion(model.data);
            }
            
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
}

/// 参与者企业评论接口
+ (void)loadActor_Comment:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest postActor_Comment:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            [self showMBText:@"评价成功"];
            if (completion) {
                completion(@(isSuccess));
            }
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
}

/// 工作包想参与接口
+ (void)loadProject_Want:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest postProject_Want:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        [self showMBText:message];
        if (completion) {
            completion(@(isSuccess));
        }
    } errorBlock:error];
}

/// 给参与者投票接口
+ (void)loadActor_Vote:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest postActor_Vote:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
}

/// 报名参加某团队，给队长发送消息
+ (void)loadProject_Team_Apply:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest postProject_Team_Apply:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            if (completion) {
                completion(@(isSuccess));
            }
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
}

/// 队长回复消息
+ (void)loadProject_Team_Apply_Reply:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest postProject_Team_Apply_Reply:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
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
