//
//  MGPayOrderWayModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/1.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"

@interface MGPayOrderWayModel : BaseModel

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, assign) BOOL isSelected;
/// 0 银行卡 1 支付宝 2 微信
@property (nonatomic, assign) NSInteger type;


@end
