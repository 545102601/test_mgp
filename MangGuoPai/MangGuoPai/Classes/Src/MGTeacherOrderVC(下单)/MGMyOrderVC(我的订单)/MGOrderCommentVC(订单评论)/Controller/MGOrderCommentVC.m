//
//  MGOrderCommentVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGOrderCommentVC.h"
#import "UITextView+Placeholder.h"

@interface MGOrderCommentVC () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
/// 输入提示
@property (nonatomic, strong) UILabel *inputTipLabel;

@end

@implementation MGOrderCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.commentType == MGOrderCommentTypeAdd ? @"点评" : @"回复点评";
    
    [self setRightButtonWithTitle:@"确定" target:self selector:@selector(rightButtonOnClick)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(SW(30), 64 + SH(30), kScreenWidth - SW(60), SH(204))];
    _textView.font = PFSC(28);
    _textView.placeholder = @"请输入内容";
    _textView.textContainerInset = UIEdgeInsetsMake(SW(26), SW(26), SW(26), SW(26));
    _textView.layer.borderColor = MGSepColor.CGColor;
    _textView.layer.borderWidth = MGSepLineHeight;
    _textView.textColor = MGThemeColor_Common_Black;
    _textView.delegate = self;
    
    _inputTipLabel = [MGUITool labelWithText:@"您还可以写100字" textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _inputTipLabel.frame = CGRectMake(0, _textView.bottom + SH(30), kScreenWidth - SW(60), _inputTipLabel.fontLineHeight);
    _inputTipLabel.textAlignment = NSTextAlignmentRight;
    _inputTipLabel.right = kScreenWidth - SW(30);
    
    [self.view addSubview:_textView];
    
    [self.view addSubview:_inputTipLabel];
}



#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 确定
- (void)rightButtonOnClick {
    [self.view endEditing:YES];
    
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
        if (self.commentType == MGOrderCommentTypeReply) { /// 回复点评
            long commentId = 0;
            if (self.dataModel.comments.count > 0) {
                MGResOrderDetailCommentModel *commentData = self.dataModel.comments[0];
                commentId = commentData.id;
            }
            
            [MGBussiness loadCourse_Comment_Reply:@{@"comment_id" : @(commentId), @"course_id" : @(self.dataModel.course_id), @"reply" : content} completion:^(id results) {
                if (self.completiomBlock) {
                    self.completiomBlock();
                }
                PopVC
            } error:nil];
        } else {
            [MGBussiness loadCourse_Comment_Add:@{@"order_id" : @(self.dataModel.id), @"course_id" : @(self.dataModel.course_id), @"content" : content} completion:^(id results) {
                if (self.completiomBlock) {
                    self.completiomBlock();
                }
                PopVC
            } error:nil];
        }
    }
    
}
#pragma mark - --Gesture Event Response
- (void)textViewDidChange:(UITextView *)textView {
    
    _inputTipLabel.text = [NSString stringWithFormat:@"您还可以写%zd字",100 - textView.text.length];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text stringContainsEmoji]) {
        return NO;
    }
    if (text.length > 0) {
        NSInteger length = textView.text.length + text.length;
        if (length > 100) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter




@end
