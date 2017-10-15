//
//  MGCommonSegmentView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/1.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"

typedef void (^ButtonOnClickBlock)(UIButton *button);

@interface MGCommonSegmentView : BaseView

@property (nonatomic, copy) NSString *leftTitle;

@property (nonatomic, copy) NSString *rightTitle;

/// 按钮点击事件
@property (nonatomic, copy) ButtonOnClickBlock buttonOnClickBlock;

- (void)setSelectedButtonWithTag:(NSInteger)tag;


@end
