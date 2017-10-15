//
//  UIImage+Extend.h
//  TDQianxiaoer
//
//  Created by huijie on 2017/3/27.
//  Copyright © 2017年 TDMarket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extend)
- (NSString *)toBase64String;
+ (UIImage *)toImageWithBase64Sting:(NSString *)string;
- (UIImage *)resizeImageWithNewWidth:(CGFloat)defineWidth;
+ (UIImage *)reduceImage:(UIImage *)originImage toAssignKB:(int)kb;

+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;

+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;
/// 缩小图片 不失真 用在了 分类icon里面
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
