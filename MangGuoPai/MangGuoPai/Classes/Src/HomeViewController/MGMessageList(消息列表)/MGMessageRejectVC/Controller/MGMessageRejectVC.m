//
//  MGMessageRejectVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/11/23.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMessageRejectVC.h"
#import "UITextView+Placeholder.h"

@interface MGMessageRejectVC () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
/// 输入提示
@property (nonatomic, strong) UILabel *inputTipLabel;

@end

@implementation MGMessageRejectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"拒绝原因";
    [self setRightButtonWithTitle:@"确定" target:self selector:@selector(rightButtonOnClick)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.textView becomeFirstResponder];
}



#pragma mark - 初始化控件
- (void)setupSubViews {
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(SW(30), 64 + SH(30), kScreenWidth - SW(60), SH(204))];
    _textView.font = PFSC(28);
    _textView.placeholder = @"请输入内容";
    _textView.textContainerInset = UIEdgeInsetsMake(SW(26), SW(26), SW(26), SW(26));
    _textView.layer.borderColor = MGSepColor.CGColor;
    _textView.layer.borderWidth = MGSepLineHeight;
    _textView.textColor = MGThemeColor_Common_Black;
    _textView.delegate = self;
    
    _inputTipLabel = [MGUITool labelWithText:@"您还可以写1000字" textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _inputTipLabel.frame = CGRectMake(0, _textView.bottom + SH(30), kScreenWidth - SW(60), _inputTipLabel.fontLineHeight);
    _inputTipLabel.textAlignment = NSTextAlignmentRight;
    _inputTipLabel.right = kScreenWidth - SW(30);
    
    [self.view addSubview:_textView];
    
    [self.view addSubview:_inputTipLabel];
    
    
    
}

#pragma mark - 加载数据
- (void)loadData {
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate
- (void)textViewDidChange:(UITextView *)textView {
    
    _inputTipLabel.text = [NSString stringWithFormat:@"您还可以写%zd字",1000 - textView.text.length];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text stringContainsEmoji]) {
        return NO;
    }
    if (text.length > 0) {
        NSInteger length = textView.text.length + text.length;
        if (length > 1000) {
            return NO;
        }
    }
    
    return YES;
}
#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

/// 点击右边按钮 + 发布
- (void)rightButtonOnClick {
    
    
    NSString *content = self.textView.text;
    
    NSMutableString *resultString = @"".mutableCopy;
    
    if (content.length == 0) {
        [resultString appendString:@"请输入内容、"];
    }
    
    if (resultString.length > 0) {
        NSString *alertStr = [resultString substringToIndex:resultString.length - 1];
        DQAlertView *checkAlertView = [[DQAlertView alloc] initWithTitle:nil message:alertStr cancelButtonTitle:@"我知道了" otherButtonTitle:nil];
        [checkAlertView setAlertThemeMessageTip_OneButton];
        [checkAlertView show];
        return;
    } else { /// 提交数据
        
        [self.view endEditing:YES];
        
        [MGBussiness loadProject_Team_Apply_Reply:@{@"message_id" : @(self.detailDataModel.id),
                                                    @"is_reject" : @"1",
                                                    @"reject_reason" : content} completion:^(id results) {
                                                        if ([results boolValue]) {
                                                            
                                                            [self showMBText:@"拒绝成功"];
                                                            [self.navigationController popViewControllerAnimated:YES];
                                                            
                                                            if (self.completionBlock) {
                                                                self.completionBlock();
                                                            }
                                                        }
                                                    } error:nil];
        
    }
    
    
    
}

@end
