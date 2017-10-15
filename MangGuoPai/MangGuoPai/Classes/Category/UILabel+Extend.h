//
//  UILabel+Extend.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/12.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extend)

/// 字的高度
@property (nonatomic, assign, readonly) CGFloat fontLineHeight;
/// 竖排
@property (nonatomic) NSString *verticalText;

@end
