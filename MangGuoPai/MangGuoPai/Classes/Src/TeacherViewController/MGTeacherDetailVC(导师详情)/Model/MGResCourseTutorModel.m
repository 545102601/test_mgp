//
//  MGResCourseTutorModel.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGResCourseTutorModel.h"
#import "MGResCourseListModel.h"

@implementation MGResCourseTutorDataModel

- (void)setIntro:(NSString *)intro {

    _intro = intro;
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:SH(10)];
    UIColor *color = MGThemeColor_subTitle_Black;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:intro attributes:@{NSFontAttributeName : MGThemeFont_24,NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle}];
    _introAttributeString = string;
    
    _introHeight = [string boundingRectWithSize:CGSizeMake(kScreenWidth - SW(60), HUGE) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"courses" : MGResCourseListDataModel.class};
}


@end

@implementation MGResCourseTutorModel





@end
