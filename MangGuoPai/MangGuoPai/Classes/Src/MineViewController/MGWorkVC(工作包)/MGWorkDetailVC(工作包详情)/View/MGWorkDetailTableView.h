//
//  MGWorkDetailTableView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "YNBaseTableView.h"
#import "MGResProjectDetailModel.h"
#import "MGResProjectActorModel.h"


typedef void(^IconImageTapBlock)(MGResCourseListDataModel *model);

@interface MGWorkDetailTableView : YNBaseTableView

@property (nonatomic, copy) IconImageTapBlock iconImageTapBlock;

@property (nonatomic, copy) MGCommomEventBlock expendButtonBlock;
/// 团队评价
@property (nonatomic, copy) MGCommomEventBlock applyTeamCommentBlock;
/// 查看作品
@property (nonatomic, copy) MGCommomEventBlock applyTeamProductBlock;

/// 查看其他文件
@property (nonatomic, copy) MGCommomEventBlock lookOtherFileButtonBlock;

@property (nonatomic, strong) MGResProjectDetailDataModel *dataModel;


@end
