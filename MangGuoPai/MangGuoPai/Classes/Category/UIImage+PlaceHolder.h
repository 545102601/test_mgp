//
//  UIImage+PlaceHolder.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/31.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (PlaceHolder)

+ (UIImage *)yn_placeholderImageWithView:(UIView *)view;
+ (UIImage *)yn_placeholderImageSize:(CGSize)size;

+ (UIImage *)yn_customImage:(UIColor *)color size:(CGSize)size;

@end
