//
//  MGAccountModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"

@interface MGAccountDataModel : BaseModel

/// 会员id
@property (nonatomic, assign) long member_id;
/// 总额
@property (nonatomic, assign) double total_amount;
/// 冻结额度
@property (nonatomic, assign) double freezing_amount;
/// 可用额度
@property (nonatomic, assign) double available_amount;

@end

@interface MGAccountModel : BaseResModel

@property (nonatomic, strong) MGAccountDataModel *data;

@end
