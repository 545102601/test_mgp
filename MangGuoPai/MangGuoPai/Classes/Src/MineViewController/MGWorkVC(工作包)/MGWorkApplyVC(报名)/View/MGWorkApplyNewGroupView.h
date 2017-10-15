//
//  MGWorkApplyNewGroupView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"

@interface MGWorkApplyNewGroupView : BaseView

@property (nonatomic, copy) NSString *teamName;
@property (nonatomic, copy) NSString *roleName;
@property (nonatomic, copy) NSString *ciperName;
@property (nonatomic, copy) NSString *bluttingName;

- (BOOL)checkCondition;

@end
