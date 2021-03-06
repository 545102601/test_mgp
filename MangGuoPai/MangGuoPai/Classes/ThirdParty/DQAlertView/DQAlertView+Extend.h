//
//  DQAlertView+Extend.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "DQAlertView.h"

@interface DQAlertView (Extend)
/// 单个提示取消按钮
- (void)setAlertThemeMessageTip_OneButton;

/// 提示信息 取消按钮 - 确定按钮
- (void)setAlertThemeMessageTip_TwoButton;

/// 报名集结号
- (void)setAlertThemeWithTextFieldForApplyWork;

/// 消息队长消息回复
- (void)setAlertThemeMessageForWorkWithTitle:(NSString *)title
                                     content:(NSString *)content
                                   workTitle:(NSString *)workTitle
                                       state:(MGGlobaState)state
                                      target:(id)target
                                    agreeSel:(SEL)agreeSel
                                   rejectSel:(SEL)rejectSel
                                   cancelSel:(SEL)cancelSel;


@end
