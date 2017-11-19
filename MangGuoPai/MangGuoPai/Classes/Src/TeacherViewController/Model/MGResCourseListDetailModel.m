//
//  MGResCourseListDetailModel.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGResCourseListDetailModel.h"

@implementation MGResCourseListDetailDataModel

- (void)setCourse_content:(NSString *)course_content {
    _course_content = course_content;
    
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:SH(10)];
    UIColor *color = MGThemeColor_Common_Black;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:course_content attributes:@{NSFontAttributeName : MGThemeFont_24,NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle}];
    _contentAttributeString = string;
    
    _contentHeight = [string boundingRectWithSize:CGSizeMake(kScreenWidth - SW(60), HUGE) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    
    
}


- (void)setType_explains:(NSString *)type_explains {
    _type_explains = type_explains;
    
    NSMutableAttributedString * _attr_str = [[NSAttributedString alloc]initWithData:[type_explains dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil].mutableCopy;
    
    
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:SH(10)];
    UIColor *color = MGThemeColor_Common_Black;
    [_attr_str addAttributes:@{NSFontAttributeName : MGThemeFont_24,NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, _attr_str.length)];
    
    
    _type_explainsAttributeString = _attr_str;
    
    _type_explainsHeight = [_attr_str boundingRectWithSize:CGSizeMake(kScreenWidth - SW(60), HUGE) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    
    
}

@end

@implementation MGResCourseListDetailModel

@end
