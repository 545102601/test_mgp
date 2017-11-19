//
//  MGBussiness+HomeExtend.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/13.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussiness.h"


@interface MGBussiness (HomeExtend)

/// 加载首页数据
+ (void)loadHomeDataWithCompletion:(BussinessCompletion)completion error:(BussinessError)error;

/// 加载公告数据
+ (void)loadHomeBulletinDataWithCompletion:(BussinessCompletion)completion error:(BussinessError)error;
/// 加载公告详情数据
+ (void)loadHomeBulletinDetailDataWithId:(NSInteger)id completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 加载小功能数据
+ (void)loadHomeFucntionDataWithCompletion:(BussinessCompletion)completion error:(BussinessError)error;

/// 加载首页推广数据
+ (void)loadHomeRecommendDataWithCompletion:(BussinessCompletion)completion error:(BussinessError)error;

/// 检测消息
+ (void)loadHomeMessageCheckdDataWithCompletion:(BussinessCompletion)completion;

/// 阅读消息接口
+ (void)loadReadMessageData:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 删除消息接口
+ (void)loadDeletedMessage:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 加载消息列表 - 分页
+ (void)loadMessage_ListDataWithPageNo:(NSInteger)pageNo Completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 加载搜索全文 - 分页
+ (void)loadFullSearchDataWithPageNo:(NSInteger)pageNo params:(NSDictionary *)params Completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 内容详情接口
+ (void)loadContentDetailData:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;



@end
