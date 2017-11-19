//
//  MGLoginModel.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/5.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGLoginModel.h"


@implementation MGLoginModel


+ (BOOL)loginShowErrorCode:(NSString *)erroCode {
    if ([erroCode isEqualToString:DATA_NOT_FOUND]) {
        [self showMBText:@"对不起！不存在该会员"];
        
        return YES;
    } else if ([erroCode isEqualToString:BIZ_ERR_LOGIN_YOOYO_SESSID_NOT_SUPPORTED]) {
        [self showMBText:@"动态码不为空时，登录会话ID不能为空"];
        
        return YES;
    } else if ([erroCode isEqualToString:BIZ_ERR_MEMBER_LOGIN_FAIL]) {
        [self showMBText:@"用户名或密码错误"];
        
        return YES;
    } else if ([erroCode isEqualToString:BIZ_ERR_LOGIN_SMSCODE_NOT_SUPPORTED]) {
        [self showMBText:@"请输入有效动态码"];
        
        return YES;
    } else if ([erroCode isEqualToString:BIZ_ERR_LOGIN_SMSCODE_SEND_COUNT_MUCH_MORE]) {
        [self showMBText:@"验证码发送过于频繁，请稍候再发"];
        
        return YES;
    } else if ([erroCode isEqualToString:BIZ_ERR_LOGIN_SMSCODE_SEND]) {
        [self showMBText:@"动态码已发到您的手机，请注意查收"];
        
        return YES;
    } else if ([erroCode isEqualToString:BIZ_ERR_MEMBER_SIGNIN_ERROR]) {
        [self showMBText:@"注册失败"];
        
        return YES;
    } else if ([erroCode isEqualToString:BIZ_ERR_LOGIN_SMSCODE_EXPIRED]) {
        [self showMBText:@"注册失败"];
        
        return YES;
    }
    return NO;
}

@end
