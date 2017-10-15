//
//  NSObject+Extend.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "NSObject+Extend.h"

@implementation NSObject (Extend)

- (void)showMBText:(NSString *)text {
    
    [self showMBDetailText:text];
    
}


+ (void)showMBText:(NSString *)text {
    
    [self showMBDetailText:text];
    
}


- (void)showMBDetailText:(NSString *)text {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:KeyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = text;
    hud.detailsLabelFont = PFSC(28);
    hud.margin = 22.0f;
    hud.removeFromSuperViewOnHide = YES;
    // 2秒之后再消失
    [hud hide:YES afterDelay:1.5];
}

+ (void)showMBDetailText:(NSString *)text {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:KeyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = text;
    hud.detailsLabelFont = PFSC(28);
    hud.margin = 22.0f;
    hud.removeFromSuperViewOnHide = YES;
    // 2秒之后再消失
    [hud hide:YES afterDelay:1.5];

    
}


@end
