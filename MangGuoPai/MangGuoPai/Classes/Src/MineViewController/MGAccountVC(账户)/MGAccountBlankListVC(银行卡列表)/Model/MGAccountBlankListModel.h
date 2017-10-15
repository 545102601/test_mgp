//
//  MGAccountBlankListModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/28.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"

@interface MGAccountBlankListDataModel : BaseModel

/// id
@property (nonatomic, assign) long id;
/// 会员id
@property (nonatomic, assign) long member_id;
/// 银行卡昵称
@property (nonatomic, copy) NSString *bank_name;
#warning TODO 银行卡图标
/// 银行卡图标
@property (nonatomic, copy) NSString *bank_icon;

/// 银行卡编号
@property (nonatomic, copy) NSString *card_no;
/// 状态
@property (nonatomic, assign) NSInteger state;
/// 状态标签
@property (nonatomic, copy) NSString *state_label;

@end

@interface MGAccountBlankListModel : BaseResModel

@property (nonatomic, strong) NSArray *data;

@end
