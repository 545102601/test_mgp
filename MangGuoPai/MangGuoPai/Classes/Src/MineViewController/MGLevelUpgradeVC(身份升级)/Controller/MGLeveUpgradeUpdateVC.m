//
//  MGLeveUpgradeUpdateVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/23.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGLeveUpgradeUpdateVC.h"
#import "CMInputView.h"

@interface MGLeveUpgradeUpdateVC ()<UITextViewDelegate>

@property (nonatomic, strong) CMInputView *contentTextView;
@property (nonatomic, strong) UILabel *limitLabel;


@end

@implementation MGLeveUpgradeUpdateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [self setRightButtonWithTitle:@"确定" target:self selector:@selector(rightOnClick)];
    [button setTitleColor:MGButtonImportDefaultColor forState:UIControlStateNormal];
    [button setTitleColor:MGButtonImportHighLightedColor forState:UIControlStateHighlighted];
    
    self.title = self.titleString;
    
    _contentTextView = [[CMInputView alloc] initWithFrame:CGRectMake(0, 64 + SH(20), kScreenWidth, SH(200))];
    _contentTextView.textColor = MGThemeColor_Common_Black;
    _contentTextView.font = MGThemeFont_28;
    _contentTextView.backgroundColor = [UIColor whiteColor];
    _contentTextView.delegate = self;
    _contentTextView.textContainerInset = UIEdgeInsetsMake(SW(20), SW(20), SW(40), SW(20));
    WEAK
    _contentTextView.textChangedBlock = ^(NSString *text, CGFloat textHeight) {
        STRONG
         self.contentTextView.scrollEnabled = NO;
         if (textHeight > kScreenHeight - 64 - SH(40)){
            self.contentTextView.height =  kScreenHeight - 64 - SH(40);
             self.contentTextView.scrollEnabled = YES;
         } else if (textHeight > SH(200)) {
             self.contentTextView.height = textHeight;
         } else {
            self.contentTextView.height =  SH(200);
        }
        self.limitLabel.y = _contentTextView.bottom - SH(40);
    };
    
    
    
    
    _limitLabel = [MGUITool labelWithText:self.limitNumber textColor:MGThemeColor_Placeholder_Black font:MGThemeFont_20 textAlignment:NSTextAlignmentRight];
    [_limitLabel sizeToFit];
    _limitLabel.y = _contentTextView.bottom - SH(40);
    _limitLabel.right = kScreenWidth - SW(20) - _limitLabel.width;
    
    
    
    
    [self.view sd_addSubviews:@[_contentTextView, _limitLabel]];
    
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
- (void)rightOnClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    if (_completionBlock) {
        _completionBlock(_contentTextView.text);
    }
    
}
#pragma mark - --Gesture Event Response

- (void)textViewDidChange:(UITextView *)textView {

    _limitLabel.text = [NSString stringWithFormat:@"%zd",[self.limitNumber integerValue] - textView.text.length];
    
    
}

#pragma mark - System Delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text stringContainsEmoji]) {
        return NO;
    }
    if (text.length > 0) {
        NSInteger length = textView.text.length + text.length;
        if (length > [self.limitNumber integerValue]) {
            return NO;
        }
    }
    return YES;
}
#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

@end
