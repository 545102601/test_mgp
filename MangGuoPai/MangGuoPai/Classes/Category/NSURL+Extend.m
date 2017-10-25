//
//  NSURL+Extend.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/24.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "NSURL+Extend.h"

#define RowHeight(height) kScreenWidth > 320.0 ? height*(kScreenWidth/320.0):height;

@implementation NSURL (Extend)

+ (instancetype)URLWithString:(NSString *)URLString scaleWidth:(CGFloat)width {

    return [self calculateImageSizeWithWeight:width AndImageStr:URLString];
    
}

+ (NSURL *)calculateImageSizeWithWeight:(CGFloat)weight AndImageStr:(NSString *)ImageUrl
{
    
    NSString *newImage = @"";
    if (ImageUrl && ImageUrl.length>4) {
        NSInteger ppi = 0;
        ppi = [[UIScreen mainScreen] scale];
        NSInteger imageW = RowHeight(weight);
        
        ImageUrl = [ImageUrl stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        NSRange Rang =  [ImageUrl rangeOfString:@".jpg"];
        
        if (Rang.length>0) {
            newImage = [ImageUrl substringToIndex:Rang.location];
            newImage = [NSString stringWithFormat:@"%@_%ld_-.jpg",newImage,imageW*ppi];
        }else if ([ImageUrl rangeOfString:@".png"].length>0){
            Rang = [ImageUrl rangeOfString:@".png"];
            newImage = [ImageUrl substringToIndex:Rang.location];
            newImage = [NSString stringWithFormat:@"%@_%ld_-.png",newImage,imageW*ppi];
        }else if ([ImageUrl rangeOfString:@".gif"].length>0){
            Rang = [ImageUrl rangeOfString:@".gif"];
            newImage = [ImageUrl substringToIndex:Rang.location];
            newImage = [NSString stringWithFormat:@"%@_%ld_-.gif",newImage,imageW*ppi];
        }
    }
    return [NSURL URLWithString:newImage];
}

@end
