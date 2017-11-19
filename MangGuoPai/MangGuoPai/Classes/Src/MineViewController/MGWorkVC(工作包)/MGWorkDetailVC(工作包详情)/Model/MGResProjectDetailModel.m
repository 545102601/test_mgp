//
//  MGResProjectDetailModel.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGResProjectDetailModel.h"

@implementation MGResProjectDetailDataModel



/// 转模型时 格式化时间 成 NSDate
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if ([dic unsignedLongLongValueForKey:@"publish_time" default:0]) {
        self.publish_time = [NSDate dateWithTimeIntervalSince1970: [dic unsignedLongLongValueForKey:@"publish_time" default:0] / 1000.0];
    }
    
    if ([dic unsignedLongLongValueForKey:@"apply_abort_time" default:0]) {
        self.apply_abort_time = [NSDate dateWithTimeIntervalSince1970: [dic unsignedLongLongValueForKey:@"apply_abort_time" default:0] / 1000.0];
    }
    if ([dic unsignedLongLongValueForKey:@"works_abort_time" default:0]) {
        self.works_abort_time = [NSDate dateWithTimeIntervalSince1970: [dic unsignedLongLongValueForKey:@"works_abort_time" default:0] / 1000.0];
    }
    if ([dic unsignedLongLongValueForKey:@"appraise_abort_time" default:0]) {
        self.appraise_abort_time = [NSDate dateWithTimeIntervalSince1970: [dic unsignedLongLongValueForKey:@"appraise_abort_time" default:0] / 1000.0];
    }
    
    if ([dic unsignedLongLongValueForKey:@"member_join_time" default:0]) {
        self.member_join_time = [NSDate dateWithTimeIntervalSince1970: [dic unsignedLongLongValueForKey:@"member_join_time" default:0] / 1000.0];
    }
    
    return YES;
}

- (void)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    
    dic[@"publish_time"] = @([self.publish_time timeIntervalSince1970] * 1000).description;
    
    dic[@"apply_abort_time"] = @([self.apply_abort_time timeIntervalSince1970] * 1000).description;
    dic[@"works_abort_time"] = @([self.works_abort_time timeIntervalSince1970] * 1000).description;
    
    dic[@"appraise_abort_time"] = @([self.appraise_abort_time timeIntervalSince1970] * 1000).description;
    
    dic[@"member_join_time"] = @([self.member_join_time timeIntervalSince1970] * 1000).description;
    
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"actors" : MGResProjectActorDataModel.class,
             @"courses" : MGResCourseListDataModel.class};
}


- (NSString *)publish_time_str {
    if (_publish_time_str.length == 0) {
        _publish_time_str = [self.publish_time stringWithFormat:@"yyyy-MM-dd"];
    }
    return _publish_time_str;
}

- (NSString *)apply_abort_time_str {
    if (_apply_abort_time_str.length == 0) {
        _apply_abort_time_str = [self.apply_abort_time stringWithFormat:@"yyyy-MM-dd"];
    }
    return _apply_abort_time_str;
}

- (NSString *)appraise_abort_time_str {
    if (_appraise_abort_time_str.length == 0) {
        _appraise_abort_time_str = [self.appraise_abort_time stringWithFormat:@"yyyy-MM-dd"];
    }
    return _appraise_abort_time_str;
}


- (NSString *)works_abort_time_str {
    if (_works_abort_time_str.length == 0) {
        _works_abort_time_str = [self.works_abort_time stringWithFormat:@"yyyy-MM-dd"];
    }
    return _works_abort_time_str;
}

- (NSString *)member_join_time_str {
    if (_member_join_time_str.length == 0) {
        _member_join_time_str = [self.member_join_time stringWithFormat:@"yyyy-MM-dd"];
    }
    return _member_join_time_str;
}

- (void)setIntroduction:(NSString *)introduction {
    _introduction = introduction;
    
    if (introduction.length > 0) {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:SH(10)];
        UIColor *color = MGThemeColor_Common_Black;
        
        /// 解析html到富文本中
        NSMutableAttributedString *string = [[NSAttributedString alloc]initWithData:[introduction dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil].mutableCopy;
        /// 设置字体大小
        [string addAttributes:@{NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, string.length)];
        
        self.introductionAttr = string;
        
        self.introductionHeight = [string boundingRectWithSize:CGSizeMake(kScreenWidth - SW(80), HUGE) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size.height;
    }
}


- (void)setPrizes_content:(NSString *)prizes_content {
    _prizes_content = prizes_content;
    
    if (prizes_content.length > 0) {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:SH(10)];
        UIColor *color = MGThemeColor_Common_Black;
        
        NSMutableAttributedString *string = [[NSAttributedString alloc]initWithData:[prizes_content dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil].mutableCopy;
        
        [string addAttributes:@{NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, string.length)];
        
        self.prizesContentAttr = string;
        
        self.prizesContentHeight = [string boundingRectWithSize:CGSizeMake(kScreenWidth - SW(80), HUGE) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size.height;
    }
    
}

- (CGFloat)prizesCellHeight {
    
    CGFloat height = PFSC(30).lineHeight + SH(40);
    
    if (self.prizesIsExpend) {
        height += self.prizesContentHeight;
        height += SH(20);
    }
    return height ;
}


- (BOOL)prizesIsExpend {
    if (self.hiddenExpendButton) {
        return YES;
    }
    return _prizesIsExpend;
}



- (void)setEntry_instructions:(NSString *)entry_instructions {
    _entry_instructions = entry_instructions;
    
    if (entry_instructions.length > 0) {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:SH(10)];
        UIColor *color = MGThemeColor_Common_Black;
        
        NSMutableAttributedString *string = [[NSAttributedString alloc]initWithData:[entry_instructions dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil].mutableCopy;
        
        [string addAttributes:@{NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, string.length)];
        
        self.entryContentAttr = string;
        
        self.entryContentHeight = [string boundingRectWithSize:CGSizeMake(kScreenWidth - SW(80), HUGE) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size.height;
    }
    
}

- (CGFloat)entryCellHeight {
    
    CGFloat height = PFSC(30).lineHeight + SH(40);
    
    if (self.entryIsExpend) {
        height += self.entryContentHeight;
        height += SH(20);
    }
    return height;
}


- (BOOL)entryIsExpend {
    if (self.hiddenExpendButton) {
        return YES;
    }
    return _entryIsExpend;
}

- (BOOL)teamIsExpend {
    if (self.hiddenExpendButton) {
        return YES;
    }
    return _teamIsExpend;
}

- (BOOL)commentIsExpend {
    if (self.hiddenExpendButton) {
        return YES;
    }
    return _commentIsExpend;
}

@end

@implementation MGResProjectDetailModel

@end
