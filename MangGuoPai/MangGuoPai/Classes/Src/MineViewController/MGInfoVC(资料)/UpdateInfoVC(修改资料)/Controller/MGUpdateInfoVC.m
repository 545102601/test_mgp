//
//  MGUpdateInfoVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/2.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGUpdateInfoVC.h"
#import "CMInputView.h"

@interface MGUpdateInfoVC ()<UITextViewDelegate>

@property (nonatomic, strong) CMInputView *contentTextView;

@property (nonatomic, strong) UILabel *limitLabel;


@end

@implementation MGUpdateInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [self setRightButtonWithTitle:@"确定" target:self selector:@selector(rightOnClick)];
    [button setTitleColor:MGButtonImportDefaultColor forState:UIControlStateNormal];
    [button setTitleColor:MGButtonImportHighLightedColor forState:UIControlStateHighlighted];
    
   
    
}

- (void)setupSubViews {

    
    _contentTextView = [[CMInputView alloc] initWithFrame:CGRectMake(0, 64 + SH(20), kScreenWidth, SH(200))];
    _contentTextView.textColor = MGThemeColor_Common_Black;
    _contentTextView.font = MGThemeFont_28;
    _contentTextView.backgroundColor = [UIColor whiteColor];
    _contentTextView.delegate = self;
    _contentTextView.textContainerInset = UIEdgeInsetsMake(SW(20), SW(20), SW(40), SW(20));
    
    _contentTextView.text = self.contentString;
    
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
    
    NSDictionary *dict = [self getInfo];
    
    self.title = dict[@"title"];
    
    if (self.type == MineInfoTagTypePhone) {
        _contentTextView.keyboardType = UIKeyboardTypeNamePhonePad;
    }
    
    _limitLabel = [MGUITool labelWithText:dict[@"limitNumber"] textColor:MGThemeColor_Placeholder_Black font:MGThemeFont_20 textAlignment:NSTextAlignmentRight];
    [_limitLabel sizeToFit];
    _limitLabel.y = _contentTextView.bottom - SH(40);
    _limitLabel.right = kScreenWidth - SW(20) - _limitLabel.width;
    
    
    
    
    [self.view sd_addSubviews:@[_contentTextView, _limitLabel]];
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 点击确定
- (void)rightOnClick {
    
    
    if (self.type == MineInfoTagTypeEMail) {
        if (_contentTextView.text.length > 0) {
            if (![_contentTextView.text checkEmail]) {
                [self showMBText:@"请输入正确的邮箱地址"];
                return;
            }
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (_completionBlock) {
        NSDictionary *dict = [self getInfo];
        
        _completionBlock(dict[@"key"], _contentTextView.text);
    }
    
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

- (void)textViewDidChange:(UITextView *)textView {
    
    _limitLabel.text = [NSString stringWithFormat:@"%zd",[[self getInfo][@"limitNumber"] integerValue] - textView.text.length];
    
    
}

#pragma mark - System Delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text stringContainsEmoji]) {
        return NO;
    }
    if (text.length > 0) {
        NSInteger length = textView.text.length + text.length;
        if (length > [[self getInfo][@"limitNumber"] integerValue]) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function


- (NSDictionary *)getInfo  {
    
    NSString *title = @"";
    NSString *key = @"";
    NSString *limitNumber = @"100";
    switch (self.type) {
        case MineInfoTagTypeNickName:
            title = @"修改昵称";
            key = @"nick_name";
            limitNumber = @"10";
            break;
        case MineInfoTagTypeSinagtrue:
            title = @"修改签名";
            key = @"my_signature";
            limitNumber = @"30";
            break;
        case MineInfoTagTypeName:
            title = @"修改姓名";
            key = @"name";
            limitNumber = @"10";
            break;
        case MineInfoTagTypeSchool:
            title = @"修改院校";
            key = @"college";
            break;
        case MineInfoTagTypeProfession:
            title = @"修改专业";
            key = @"profession";
            break;
        case MineInfoTagTypeProject:
            title = @"修改项目经验";
            key = @"project_experience";
            limitNumber = @"1000";
            break;
        case MineInfoTagTypeWork:
            title = @"修改工作/实习经历";
            key = @"work_experience";
            limitNumber = @"1000";
            break;
        case MineInfoTagTypeComment:
            title = @"修改自我评价";
            key = @"self_evaluation";
            limitNumber = @"1000";
            break;
        case MineInfoTagTypeQQ:
            title = @"修改QQ";
            key = @"qq";
            limitNumber = @"30";
            break;
        case MineInfoTagTypeWeChat:
            title = @"修改微信";
            key = @"weixin";
            break;
        case MineInfoTagTypePhone:
            title = @"修改手机号码";
            key = @"mobile";
            limitNumber = @"11";
            break;
        case MineInfoTagTypeEMail:
            title = @"修改邮箱";
            key = @"email";
            
            break;
        default:
            break;
    }
    return @{@"title" : title, @"key" : key, @"limitNumber" : limitNumber};
}


#pragma mark - Getter and Setter


@end
