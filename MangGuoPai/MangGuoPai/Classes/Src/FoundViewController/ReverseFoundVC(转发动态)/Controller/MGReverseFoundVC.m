//
//  MGReverseFoundVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/24.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGReverseFoundVC.h"
#import "UITextView+Placeholder.h"
#import <YYText.h>

@interface MGReverseFoundVC () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
/// 输入提示
@property (nonatomic, strong) UILabel *inputTipLabel;

@property (nonatomic, strong) UIView *reverseBgView;
/// icon
@property (nonatomic, strong) UIImageView *iconImageView;
/// username
@property (nonatomic, strong) UILabel *userNameLabel;

/// 内容
@property (nonatomic, strong) YYLabel *cotentLabel;

@end

@implementation MGReverseFoundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"转发";
    [self setRightButtonWithTitle:@"发布" target:self selector:@selector(rightButtonOnClick)];
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    _inputTipLabel = [MGUITool labelWithText:@"您还可以写100字" textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _inputTipLabel.frame = CGRectMake(0, _textView.bottom + SH(30), kScreenWidth - SW(60), _inputTipLabel.fontLineHeight);
    _inputTipLabel.textAlignment = NSTextAlignmentRight;
    _inputTipLabel.right = kScreenWidth - SW(30);
    
    
    [self.view addSubview:_textView];
    
    [self.view addSubview:_inputTipLabel];
    
    
    
    
    _reverseBgView = [[UIView alloc] initWithFrame:CGRectMake(_textView.left, _inputTipLabel.bottom + SH(30), kScreenWidth - 2 * _textView.left, SH(150))];
    _reverseBgView.backgroundColor = RGB(238, 238, 238);
    
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(30), SH(35), SW(80), SW(80))];
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.layer.cornerRadius = SW(40);
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    _userNameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _userNameLabel.frame = CGRectMake(_iconImageView.right + SW(30), SH(42), SW(480), _userNameLabel.fontLineHeight);
    
    
    _cotentLabel = [YYLabel new];
    _cotentLabel.userInteractionEnabled = YES;
    _cotentLabel.numberOfLines = 2;
    _cotentLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _cotentLabel.frame = CGRectMake(_userNameLabel.left, 0, _reverseBgView.width -   _userNameLabel.left - SW(30), 0);
    _cotentLabel.font = PFSC(28);
    _cotentLabel.textColor = MGThemeColor_Common_Black;
    
    
    [_reverseBgView sd_addSubviews:@[_iconImageView, _userNameLabel, _cotentLabel]];
    
    [self.view addSubview:_reverseBgView];
    
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:self.dataModel.avatar_rsurl] placeholderImage:SDWEB_PLACEHODER_IMAGE_ICON];
    
    _userNameLabel.text = self.dataModel.publisher_name;
    
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:self.dataModel.content];
    attriStr.yy_font = PFSC(28);
    attriStr.yy_color = MGThemeColor_Common_Black;
    attriStr.yy_lineSpacing = SH(10);
    _cotentLabel.attributedText = attriStr;
    
    _cotentLabel.height = [YYTextLayout layoutWithContainerSize:CGSizeMake(_cotentLabel.width, HUGE) text:_cotentLabel.attributedText].textBoundingSize.height;
    
    if (_cotentLabel.height > SH(40)) {
        _userNameLabel.top = SH(20);
    } else {
        _userNameLabel.top = SH(40);
    }
    _cotentLabel.top = _userNameLabel.bottom + SH(10);
    
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
#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

/// 点击右边按钮 + 发布
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
        
        [MGBussiness loadTrend_AddWithParams:@{@"fawordTrendId" : @(self.dataModel.id), @"content" : content} completion:^(id results) {
            if ([results boolValue]) {
                
                [self.navigationController popViewControllerAnimated:YES];
                if (self.publishCompletionBlock) {
                    self.publishCompletionBlock();
                }
            }
        } error:nil];
        
    }
    
}


@end
