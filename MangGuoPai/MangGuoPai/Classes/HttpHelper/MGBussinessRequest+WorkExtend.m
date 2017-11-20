//
//  MGBussinessRequest+WorkExtend.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/30.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussinessRequest+WorkExtend.h"

@implementation MGBussinessRequest (WorkExtend)

/// 工作包列表
+ (void)getWork_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestGetUrl:HTTP_WORK_LIST
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:NO
           successBlock:successBlock
             errorBlock:errorBlock];
}


/// 工作包报名
+ (void)postProject_Join:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_PROJECT_JOIN
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:YES
           successBlock:successBlock
             errorBlock:errorBlock];
}



/// 工作包参加团队列表接口
+ (void)getProject_Teams:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestGetUrl:HTTP_PROJECT_TEAMS
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:YES
           successBlock:successBlock
             errorBlock:errorBlock];
}

/// 工作包详情
+ (void)getProject_Get:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestGetUrl:HTTP_PROJECT_GET
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:NO
           successBlock:successBlock
             errorBlock:errorBlock];
}

/// 工作包参与者详情接口
+ (void)getProject_Actor_Get:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestGetUrl:HTTP_PROJECT_ACTOR_GET
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:NO
           successBlock:successBlock
             errorBlock:errorBlock];
}

/// 工作包参与者团队详情接口
+ (void)getActor_Team_Get:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestGetUrl:HTTP_ACTOR_TEAM_GET
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:YES
           successBlock:successBlock
             errorBlock:errorBlock];
}

/// 参与者企业评论接口
+ (void)postActor_Comment:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_ACTOR_COMMENT
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}
/// 报名参加某团队，给队长发送消息
+ (void)postProject_Team_Apply:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_PROJECT_TEAM_APPLY
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 队长回复消息
+ (void)postProject_Team_Apply_Reply:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_PROJECT_TEAM_APPLY_REPLY
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}


/// 工作包想参与接口
+ (void)postProject_Want:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_PROJECT_WANT
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 给参与者投票接口
+ (void)postActor_Vote:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_ACTOR_VOTE
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}





@end
