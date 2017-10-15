//
//  BaseView.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView
/// 布局视图
- (void)prepareViewUI;
/// 布局frame
- (void)prepareFrameViewUI;
- (void)prepareFrameViewUI:(CGRect)frame;

@end
