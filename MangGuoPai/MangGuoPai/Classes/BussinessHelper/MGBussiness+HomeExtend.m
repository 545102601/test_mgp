//
//  MGBussiness+HomeExtend.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/13.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussiness+HomeExtend.h"
#import "MGResSettingModel.h"
#import "MGResContentModel.h"
#import "MGResClassifyModel.h"
#import "MGResMessageModel.h"
#import "MGResEntityModel.h"
#import "MGResContentModel.h"
#import "MGResMessageDetailModel.h"

@implementation MGBussiness (HomeExtend)

+ (void)loadHomeDataWithCompletion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest getSetting_List:@{} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
           
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                MGResSettingModel *settingmModel = [MGResSettingModel yy_modelWithDictionary:dic];
                NSMutableArray *oneArray = @[].mutableCopy;
                NSMutableArray *twoArray = @[].mutableCopy;
                NSMutableArray *threeArray = @[].mutableCopy;
                
                for (MGResSettingDataModel *dataModel in settingmModel.data) {
                    if ([dataModel.position isEqualToString:@"index_banner"]) {
                        [oneArray addObject:dataModel];
                    } else if ([dataModel.position isEqualToString:@"index_two_banner"]) {
                        [twoArray addObject:dataModel];
                    } else if ([dataModel.position isEqualToString:@"index_three_advert"]) {
                        [threeArray addObject:dataModel];
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(@{@"index_banner" : oneArray, @"index_two_banner" : twoArray, @"index_three_advert" : threeArray});
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

/// 加载公告数据
+ (void)loadHomeBulletinDataWithCompletion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest getBulletin_List:@{@"page_no" : @"1", @"page_size" : @"10"} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                 MGResContentModel *contentModel = [MGResContentModel yy_modelWithDictionary:dic];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(contentModel.data);
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

/// 加载公告详情
+ (void)loadHomeBulletinDetailDataWithId:(NSInteger)id completion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest getBulletin_Get:@{@"id" : @(id)} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                MGResContentDetailModel *detailModel = [MGResContentDetailModel yy_modelWithDictionary:dic];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(detailModel.data);
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
+ (void)loadHomeFucntionDataWithCompletion:(BussinessCompletion)completion error:(BussinessError)error {
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
/// 加载首页推广数据
+ (void)loadHomeRecommendDataWithCompletion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest getSetting_List:@{@"position" : @"index_three_advert"} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                MGResSettingModel *settingmModel = [MGResSettingModel yy_modelWithDictionary:dic];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(settingmModel.data);
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


/// 检测消息
+ (void)loadHomeMessageCheckdDataWithCompletion:(BussinessCompletion)completion {
    [MGBussinessRequest getMessage_Check:@{@"current" : [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss"]} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (completion) {
            completion(@(isSuccess));
        }
        
    } errorBlock:nil];
    
}


/// 阅读消息接口
+ (void)loadReadMessageData:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest postMessage_Read:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (completion) {
            completion(@(isSuccess));
        }
        
    } errorBlock:nil];
}

/// 删除消息接口
+ (void)loadDeletedMessage:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {

}

/// 消息详情接口
+ (void)loadMessageDetail:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest getMessage_Get:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            MGResMessageDetailModel *model = [MGResMessageDetailModel yy_modelWithDictionary:dic];
            if (completion) {
                completion(model.data);
            }
        } else {
            [self showMBText:message];
        }
        
    } errorBlock:nil];
}

/// 加载收藏列表 - 分页
+ (void)loadMessage_ListDataWithPageNo:(NSInteger)pageNo Completion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest getMessage_List:@{@"page_no" : @(pageNo)} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if (isSuccess) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                MGResMessageModel *model = [MGResMessageModel yy_modelWithDictionary:dic];
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
/// 加载搜索全文 - 分页
+ (void)loadFullSearchDataWithPageNo:(NSInteger)pageNo
                              params:(NSDictionary *)params
                          Completion:(BussinessCompletion)completion
                               error:(BussinessError)error {
    [MGBussinessRequest getFull_Search:@{@"page_no" : @(pageNo), @"search_text" : params[@"search_text"]} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if (isSuccess) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                MGResEntityModel *model = [MGResEntityModel yy_modelWithDictionary:dic];
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

/// 内容详情接口
+ (void)loadContentDetailData:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest getContent_Get:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if (isSuccess) {
            MGResContentDetailModel *detailModel = [MGResContentDetailModel yy_modelWithDictionary:dic];
            if (completion) {
                completion(detailModel.data);
            }
        } else {
            [self showMBText:message];
        }
        
    } errorBlock:error];
    
}
@end
