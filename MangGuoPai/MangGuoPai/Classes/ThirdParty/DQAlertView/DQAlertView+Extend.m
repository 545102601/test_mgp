//
//  DQAlertView+Extend.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "DQAlertView+Extend.h"
#import "UITextField+Extend.h"

#import "RegexKitLite.h"
@interface DQAlertView () <UITextFieldDelegate>

@end

@implementation DQAlertView (Extend)


- (void)setAlertThemeMessageTip_OneButton {
    
    
    self.shouldDismissOnActionButtonClicked = NO;
    
    self.appearAnimationType = DQAlertViewAnimationTypeZoomIn;
    self.disappearAnimationType = DQAlertViewAnimationTypeFaceOut;
    self.appearTime = 0.25;
    self.disappearTime = 0.25;
    self.dimAlpha = 0.6;
    
    [self.cancelButton setTitleColor:MGThemeBackgroundColor  forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = PFSC(32);
    self.messageLabel.font = PFSC(26);
    self.messageLabel.textColor = MGThemeColor_Common_Black;
    self.titleLabel.font = PFSC(32);
    self.titleLabel.textColor = MGThemeColor_Common_Black;
    
    self.separatorColor = MGSepColor;
    
    [self setBackgroundColor:[UIColor whiteColor]];
}


- (void)setAlertThemeMessageTip_TwoButton {
    
//    self.shouldDismissOnActionButtonClicked = NO;
    
    self.appearAnimationType = DQAlertViewAnimationTypeZoomIn;
    self.disappearAnimationType = DQAlertViewAnimationTypeFaceOut;
    self.appearTime = 0.25;
    self.disappearTime = 0.25;
    self.dimAlpha = 0.6;
    
    [self.cancelButton setTitleColor:MGThemeColor_subTitle_Black forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = PFSC(32);
    
    [self.otherButton setTitleColor:MGThemeBackgroundColor forState:UIControlStateNormal];
    self.otherButton.titleLabel.font = PFSC(32);
    
    
    self.messageLabel.font = PFSC(26);
    self.messageLabel.textColor = MGThemeColor_Common_Black;
    
    self.titleLabel.font = PFSC(32);
    self.titleLabel.textColor = MGThemeColor_Common_Black;
    
    self.separatorColor = MGSepColor;
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    
}

- (void)setAlertThemeWithTextFieldForApplyWork {
    
    /// 背景
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SW(592), SH(240))];
    
    UILabel *titleLabel = [MGUITool labelWithText:@"集结暗号" textColor:MGThemeColor_Title_Black font:PFSC(30) textAlignment:NSTextAlignmentCenter];
    titleLabel.frame = CGRectMake(SW(52), SH(50), tempView.width - 2 * SW(52) , titleLabel.fontLineHeight);
    
    UITextField *inputTextFiled = [[UITextField alloc] init];
    inputTextFiled.frame = CGRectMake(SW(22),titleLabel.bottom + SH(38), tempView.width - 2 * SW(22), SH(70));
    inputTextFiled.tag = 100001;
    inputTextFiled.font = PFSC(28);
    inputTextFiled.textColor = MGThemeColor_Title_Black;
    inputTextFiled.layer.borderColor = MGSepColor.CGColor;
    inputTextFiled.layer.borderWidth = MGSepLineHeight;
    inputTextFiled.layer.cornerRadius = SW(3);
    inputTextFiled.placeholder = @"请输入集结暗号";
    inputTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    inputTextFiled.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SW(20), inputTextFiled.height)];
    inputTextFiled.leftViewMode = UITextFieldViewModeAlways;
    /// 限制数字
    [inputTextFiled limitTextLength:4];
    
    inputTextFiled.delegate = self;
    
    [tempView addSubview:titleLabel];
    [tempView addSubview:inputTextFiled];
    
    self.contentView = tempView;
    
    self.shouldDimBackgroundWhenShowInView = YES;
    self.shouldDismissOnActionButtonClicked = NO;
}


#pragma mark - UITextFiedlDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    /// 屏蔽表情
    if ([string stringContainsEmoji]) {
        return NO;
    }
    
    return YES;
}


/// 消息队长消息回复
- (void)setAlertThemeMessageForWorkWithTitle:(NSString *)title
                                     content:(NSString *)content
                                   workTitle:(NSString *)workTitle
                                       state:(MGGlobaState)state
                                      target:(id)target
                                    agreeSel:(SEL)agreeSel
                                   rejectSel:(SEL)rejectSel
                                   cancelSel:(SEL)cancelSel {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SW(600), SH(702))];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.width, SH(100))];
    titleLabel.font = PFSC(32);
    titleLabel.textColor = MGThemeColor_Title_Black;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    
    UIView *titleLineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleLabel.bottom, view.width, MGSepLineHeight)];
    titleLineView.backgroundColor = MGSepColor;
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:SH(20)];
    
    NSMutableAttributedString *contentAttr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName : PFSC(28), NSForegroundColorAttributeName : MGThemeColor_Title_Black, NSParagraphStyleAttributeName : paragraphStyle}];
    
    CGFloat contentHeight = [contentAttr boundingRectWithSize:CGSizeMake(view.width - SH(60), HUGE) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    
    CGFloat maxContentTextViewHeight = MIN(contentHeight, SH(325));
    ;
    
    
    UITextView *contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(SW(30), titleLineView.bottom + SH(30), view.width - SH(60), maxContentTextViewHeight)];
    contentTextView.editable = NO;
    contentTextView.attributedText = contentAttr;
    contentTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UIImageView *_iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(30), contentTextView.bottom + SH(24), SW(80), SW(80))];
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.layer.cornerRadius = SW(80) * 0.5;
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;;
    _iconImageView.image = [UIImage imageNamed:@"mine_manguo_fx"];
    
    UILabel *workTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.right + SW(34), 0, SW(430), PFSC(28).lineHeight)];
    workTitleLabel.font = PFSC(28);
    workTitleLabel.textColor = MGThemeColor_Title_Black;
    workTitleLabel.centerY = _iconImageView.centerY;
    workTitleLabel.text = workTitle;
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _iconImageView.bottom + SH(34), view.width, MGSepLineHeight)];
    bottomLineView.backgroundColor = MGSepColor;
    
    UIButton *agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeButton.titleLabel.font = PFSC(28);
    agreeButton.frame = CGRectMake(SW(14), bottomLineView.bottom + SH(20), SW(170), SH(60));
    agreeButton.layer.cornerRadius = MGButtonLayerCorner;
    agreeButton.layer.masksToBounds = YES;
    agreeButton.layer.borderWidth = MGSepLineHeight;
    agreeButton.layer.borderColor = MGThemeShenYellowColor.CGColor;
    [MGUITool setButtonTheme:agreeButton
                       title:@"同意"
                  titleColor:MGThemeShenYellowColor
               bgImageNColor:[UIColor whiteColor]
               bgImageHColor:[UIColor whiteColor]];
    [agreeButton addTarget:target action:agreeSel forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *rejectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rejectButton.titleLabel.font = PFSC(28);
    rejectButton.frame = CGRectMake(agreeButton.right + SW(20), bottomLineView.bottom + SH(20), SW(170), SH(60));
    rejectButton.layer.cornerRadius = MGButtonLayerCorner;
    rejectButton.layer.masksToBounds = YES;
    rejectButton.layer.borderWidth = MGSepLineHeight;
    rejectButton.layer.borderColor = MGThemeColor_Common_Black.CGColor;
    [MGUITool setButtonTheme:rejectButton
                       title:@"拒绝"
                  titleColor:MGThemeColor_Common_Black
               bgImageNColor:[UIColor whiteColor]
               bgImageHColor:[UIColor whiteColor]];
    [rejectButton addTarget:target action:rejectSel forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.titleLabel.font = PFSC(28);
    cancelButton.frame = CGRectMake(rejectButton.right + SW(20), bottomLineView.bottom + SH(20), view.width - rejectButton.right - SW(20) - SW(14), SH(60));
    cancelButton.layer.cornerRadius = MGButtonLayerCorner;
    cancelButton.layer.masksToBounds = YES;
    cancelButton.layer.borderWidth = MGSepLineHeight;
    cancelButton.layer.borderColor = MGThemeColor_Common_Black.CGColor;
    [MGUITool setButtonTheme:cancelButton
                       title:@"等一下再决定"
                  titleColor:MGThemeColor_Common_Black
               bgImageNColor:[UIColor whiteColor]
               bgImageHColor:[UIColor whiteColor]];
    [cancelButton addTarget:target action:cancelSel forControlEvents:UIControlEventTouchUpInside];
    
    /// 已回复
    if (state == MGGlobaStateAlreadyReply) {
        agreeButton.hidden = YES;
        rejectButton.hidden = YES;
        cancelButton.width = cancelButton.width * 2;
        cancelButton.centerX = view.width * 0.5;
        [cancelButton setTitle:@"已回复" forState:UIControlStateNormal];
    }
    
    self.appearAnimationType = DQAlertViewAnimationTypeZoomIn;
    self.disappearAnimationType = DQAlertViewAnimationTypeFaceOut;
    self.appearTime = 0.25;
    self.disappearTime = 0.25;
    self.dimAlpha = 0.6;
    self.shouldDimBackgroundWhenShowInView = YES;
    
    self.otherButton.hidden = YES;
    self.cancelButton.hidden = YES;
    self.hideSeperator = YES;
    
    [view sd_addSubviews:@[titleLabel, titleLineView, contentTextView, _iconImageView, workTitleLabel, bottomLineView, agreeButton, rejectButton, cancelButton]];
    
    view.height = cancelButton.bottom + SH(20);
    
    self.contentView = view;
}



@end
