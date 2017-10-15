//
//  MGWorkTableView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/30.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "YNBaseTableView.h"

@interface MGWorkTableView : YNBaseTableView

/// tag  1000 是 邀请 ， 1003 是详情  1002 是团队  1001 是 作品按钮
@property (nonatomic, copy) MGCommomEventBlock buttonEventBlock;

@end
