//
//  MGResCalcPriceModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/17.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"

@interface MGResCalcPriceDataModel : BaseModel

@property (nonatomic, assign) long id;
/// 总计
@property (nonatomic, assign) double total_price;
/// 支付价格
@property (nonatomic, assign) double pay_price;
/// 优惠价格
@property (nonatomic, assign) double discount_price;
/// 优惠描述
@property (nonatomic, copy) NSString *discount_price_label;
/// 市场价格
@property (nonatomic, assign) double marketPrice;
/// 销售价格
@property (nonatomic, assign) double salePrice;

/// 附加 error message
@property (nonatomic, copy) NSString *error_discount_price_label;

@end

@interface MGResCalcPriceModel : BaseResModel

@property (nonatomic, strong) MGResCalcPriceDataModel *data;

@end
