//
//  MGCommonEmptyView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGCommonEmptyView.h"

@implementation MGCommonEmptyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.notDataViewType = YNBaseNotDataViewTypeImageAndLabel;
    }
    return self;
}

@end
