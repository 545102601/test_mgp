//
//  MGBussiness+OrderExtend.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/31.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussiness+OrderExtend.h"
#import "MGResOrderListModel.h"
#import "MGResOrderDetailModel.h"
#import "MGResCalcPriceModel.h"
#import "MGResScheduleCalendarModel.h"

@implementation MGBussiness (OrderExtend)

/// 下单接口
+ (void)loadOrderAddWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest postOrder_Add:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            MGResOrderModel *model = [MGResOrderModel yy_modelWithDictionary:dic];
            if (completion) {
                completion(model.data);
            }
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
    
}

/// 支付接口
+ (void)loadOrderPayWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest postOrder_Pay:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            if (completion) {
                completion(dic[@"data"][@"payData"]);
            }
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
    
}


/// 价格计算
+ (void)loadOrderCalc_PriceWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest postOrderCalc_Price:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            MGResCalcPriceModel *model = [MGResCalcPriceModel yy_modelWithJSON:dic];
            if (completion) {
                completion(model.data);
            }
        } else {
            if (completion) {
                MGResCalcPriceDataModel *dataModel = [MGResCalcPriceDataModel new];
                dataModel.error_discount_price_label = message;
                completion(dataModel);
            }
        }
    } errorBlock:error];
}

/// 订单列表接口 - 分页
+ (void)loadOrderListWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {

    [MGBussinessRequest getOrder_List:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if (isSuccess) {
        
            MGResOrderListModel *listModel = [MGResOrderListModel yy_modelWithDictionary:dic];
            
            if (completion) {
                completion(listModel);
            }
            
        } else {
            [self showMBText:message];
            if (error) {
                error(nil);
            }
        }
        
    } errorBlock:error];
    
}

/// 订单详情接口
+ (void)loadOrderDetailWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {

    [MGBussinessRequest getOrder_Get:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            MGResOrderDetailModel *detailModel = [MGResOrderDetailModel yy_modelWithDictionary:dic];
            if (completion) {
                completion(detailModel.data);
            }
            
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
}

/// 取消订单
+ (void)loadOrderCancelWithParams:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest postOrder_Cancel:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            if (completion) {
                completion(@(isSuccess));
            }
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
    

}

/// 完成订单
+ (void)loadOrder_Finish:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest postOrder_Finish:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
}

/// 申请售后
+ (void)loadOrder_Apply:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest postOrder_Apply:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            if (completion) {
                completion(@(isSuccess));
            }
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];

}

/// 课程安排日历接口
+ (void)loadSchedule_Calendar:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest getSchedule_Calendar:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if (isSuccess) {

            MGResScheduleCalendarModel *model = [MGResScheduleCalendarModel yy_modelWithDictionary:dic];
            
            if (completion) {
                completion(model.data);
            }
        } else {
            [self showMBText:message];
        }
        
        
    } errorBlock:error];
    
}

/// 安排课程接口
+ (void)loadOrder_Schedule:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest postOrder_Schedule:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            [self showMBText:@"安排成功"];
            if (completion) {
                completion(@(isSuccess));
            }
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
}

/// 取消安排课程接口
+ (void)loadOrder_Schedule_Cancel:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest postOrder_Schedule_Cancel:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            [self showMBText:@"取消成功"];
            if (completion) {
                completion(@(isSuccess));
            }
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];

}

/// 批量取消安排课程接口
+ (void)loadBatch_Schedule_Cancel:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest postBatch_Schedule_Cancel:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            [self showMBText:@"取消成功"];
            if (completion) {
                completion(@(isSuccess));
            }
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];

}


@end
