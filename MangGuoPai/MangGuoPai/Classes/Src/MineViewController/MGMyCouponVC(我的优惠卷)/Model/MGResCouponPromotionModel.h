//
//  MGResCouponPromotionModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/17.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"


@interface MGResCouponPromotionDataModel : BaseResModel

@property (nonatomic, assign) long id;

@property (nonatomic, copy) NSString *couponName;

@end

@interface MGResCouponPromotionModel : BaseResModel

@property (nonatomic, copy) NSArray *data;

@end
