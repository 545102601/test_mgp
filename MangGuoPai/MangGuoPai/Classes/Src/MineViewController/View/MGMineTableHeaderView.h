//
//  MGMineTableHeaderView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/16.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"
#import "MGResMemberModel.h"

@protocol MGMineTableHeaderViewDelegate <NSObject>

@optional
/// tag = 1001 收藏， 1002 = msg  , 1003 = 动态, 1004 = 修改个人信息
- (void)didSmallButtonOnClickWithTag:(NSInteger)tag;

@end

@interface MGMineTableHeaderView : BaseView
/// 代理
@property (nonatomic, weak) id<MGMineTableHeaderViewDelegate> delegate;
/// 个人信息模型
@property (nonatomic, strong) MGResMemberDataModel *dataModel;

@end
