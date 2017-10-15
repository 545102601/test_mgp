//
//  MGResProjectActorModel.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/2.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGResProjectActorModel.h"

@implementation MGResProjectActorDataModel


- (void)setTutor_comments:(NSString *)tutor_comments {
    _tutor_comments = tutor_comments;
    
    if (tutor_comments.length > 0) {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:SH(10)];
        UIColor *color = MGThemeColor_Common_Black;
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:tutor_comments attributes:@{NSFontAttributeName : MGThemeFont_28,NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle}];
    
        self.tutor_comments_attr = string;
        
        self.tutor_comments_height = [string boundingRectWithSize:CGSizeMake(kScreenWidth - SW(90), HUGE) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size.height;
    }
}

- (void)setCompany_comments:(NSString *)company_comments {
    _company_comments = company_comments;
    
    if (company_comments.length > 0) {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:SH(10)];
        UIColor *color = MGThemeColor_Common_Black;
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:company_comments attributes:@{NSFontAttributeName : MGThemeFont_28,NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle}];
        
        self.company_comments_attr = string;
        
        self.company_comments_height = [string boundingRectWithSize:CGSizeMake(kScreenWidth - SW(90), HUGE) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size.height;
    }
}


@end

@implementation MGResProjectActorModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"members" : MGResProjectTeamDataModel.class};
}

@end
