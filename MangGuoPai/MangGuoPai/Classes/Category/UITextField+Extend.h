//
//  UITextField+Extend.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extend)

- (void)limitTextLength:(int)length;


//添加一个空白的view
-(void)addLeftBlankViewWithWidth:(CGFloat )width;

//添加一个左边图片
-(void)addLeftViewWithImage:(NSString *)image;

//添加一个右边图片
-(void)addRightViewWithImage:(NSString *)image target:(id)target selector:(SEL)selector;


@end
