//
//  MGFoundCellInfoView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/4.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"
#import "MGResTrendListModel.h"


@interface MGFoundCellInfoView : BaseView

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) MGCommomEventBlock favEventBlock;

@property (nonatomic, strong) MGResTrendListDataModel *dataModel;



/// 设置是否收藏
- (void)setFavIsCollection:(BOOL)collection;

@end
