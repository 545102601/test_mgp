//
//  UIImage+Extend.m
//  TDQianxiaoer
//
//  Created by huijie on 2017/3/27.
//  Copyright © 2017年 TDMarket. All rights reserved.
//

#import "UIImage+Extend.h"

@implementation UIImage (Extend)
#pragma mark - Public Function
- (NSString *)toBase64String {
    NSData *imageData;
    
    if ([UIImage imageHasAlpha:self]) {
        imageData = UIImagePNGRepresentation(self);
    } else {
        imageData = UIImageJPEGRepresentation(self, 1.0f);
    }
    
    return [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+ (UIImage *)toImageWithBase64Sting:(NSString *)string {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string
                                                      options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

- (UIImage *)resizeImageWithNewWidth:(CGFloat)defineWidth {
    CGSize imageSize = self.size;
    CGFloat width    = imageSize.width;
    CGFloat height   = imageSize.height;
    
    CGFloat targetWidth  = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [self drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)reduceImage:(UIImage *)originImage toAssignKB:(int)kb {
    
    if (kb <= 0) {
        return originImage;
    }
    
    CGFloat compressionQuality = 0.9;
    NSData * imageData         = UIImageJPEGRepresentation(originImage, compressionQuality);
    
    while (1) {
        if (imageData.length / 1024.0 > kb) {
            compressionQuality = compressionQuality - 0.1;
            imageData = UIImageJPEGRepresentation(originImage, compressionQuality);
            
            // 如果一直找不到合适的尺寸，就不压缩
            if (compressionQuality <= 0) {
                
                return originImage;
            }
            
        } else {
            break;
        }
    }

    return [UIImage imageWithData:imageData];
}

#pragma mark - Private Function
+ (BOOL)imageHasAlpha:(UIImage *)image {
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

/**
 *  压缩图片到指定文件大小
 *
 *  @param image 目标图片
 *  @param size  目标大小（最大值）
 *
 *  @return 返回的图片文件
 */
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size {
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.1f) {
        maxQuality = maxQuality - 0.1f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}


/// 制定大小
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}


+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    // Create a graphics image context
 
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(newSize, NO, [UIScreen mainScreen].scale);

    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    // Get the new image from the context
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
