//
//  MGBussiness+WorkExtend.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/30.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussiness.h"

@interface MGBussiness (WorkExtend)

/// 工作包列表 - 分页
+ (void)loadWorkListWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 工作包报名
+ (void)loadProject_Join:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 工作包参加团队列表接口
+ (void)loadProject_Teams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 工作包详情
+ (void)loadProject_Get:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 工作包参与者详情接口
+ (void)loadProject_Actor_Get:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 工作包参与者团队详情接口
+ (void)loadActor_Team_Get:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 参与者企业评论接口
+ (void)loadActor_Comment:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 工作包想参与接口
+ (void)loadProject_Want:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 给参与者投票接口
+ (void)loadActor_Vote:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 报名参加某团队，给队长发送消息
+ (void)loadProject_Team_Apply:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 队长回复消息
+ (void)loadProject_Team_Apply_Reply:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

@end
