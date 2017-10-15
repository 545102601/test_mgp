//
//  MGHomeSearchBarView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/13.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"

typedef void(^HomeSearchBarViewTapBlock)(void);

@interface MGHomeSearchBarView : BaseView

@property (nonatomic, copy) NSString *searchText;

@property (nonatomic, copy) HomeSearchBarViewTapBlock searchBarViewTapBlock;

@property (nonatomic, copy) MGCommomEventBlock searchEventBlock;

@end
