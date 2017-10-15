//
//  UIImage+PlaceHolder.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/31.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "UIImage+PlaceHolder.h"
#import "UIImage+Extend.h"


@implementation UIImage (PlaceHolder)


+ (UIImage *)yn_placeholderImageWithView:(UIView *)view {
    
    return [self yn_placeholderImageSize:view.size];
};


+ (UIImage *)yn_placeholderImageSize:(CGSize)size{
    
    if (size.width <= 0 || size.height <= 0) {
        return nil;
    }
    
    //纯色背景
    
    CGSize imageSize = CGSizeMake(size.width, size.height);
    
    NSString *key = [NSString stringWithFormat:@"yn_placeholderImageSize_%f_%f",imageSize.width,imageSize.height];
    /// 取缓存
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:key];
    if (cacheImage) {
        return cacheImage;
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [MGBackgroundViewColor set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    
    [pressedColorImg drawInRect:CGRectMake(0, 0, pressedColorImg.size.width, pressedColorImg.size.height)];
    
  
    UIImage *image2 = [UIImage imageNamed:@"empty_page_icon_09"];
    if (imageSize.width < imageSize.width || imageSize.height < image2.size.height) {
        CGFloat scale = imageSize.width < imageSize.height ? imageSize.width / imageSize.width : imageSize.height / image2.size.height;
        image2 = [UIImage imageWithImage:image2 scaledToSize:CGSizeMake(image2.size.width * scale, image2.size.height * scale)];
    }
    
    
    [image2 drawInRect:CGRectMake((imageSize.width-image2.size.width)/2, (imageSize.height-image2.size.height)/2, image2.size.width, image2.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    [[SDImageCache sharedImageCache] storeImage:resultingImage forKey:key completion:nil];
    
    
    return resultingImage;
    
}

+ (UIImage *)yn_customImage:(UIColor *)color size:(CGSize)size{
    
    
    if (size.width <= 0 || size.height <= 0) {
        return nil;
    }
    
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
}

+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    UIGraphicsBeginImageContext(image1.size);
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

@end
