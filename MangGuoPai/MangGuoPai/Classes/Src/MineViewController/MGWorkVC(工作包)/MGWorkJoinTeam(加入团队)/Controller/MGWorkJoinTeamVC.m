//
//  MGWorkJoinTeamVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/11/15.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkJoinTeamVC.h"
#import "UITextView+Placeholder.h"
#import "MGWorkMyIntroVC.h"

@interface MGWorkJoinTeamVC () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UILabel *ciperTipLabel1;
@property (nonatomic, strong) UILabel *ciperTipLabel2;
@property (nonatomic, strong) UITextField *ciperTextField;
@property (nonatomic, strong) UIButton *directButton;

@property (nonatomic, strong) UIView *centerLineView;

@property (nonatomic, strong) UILabel *applyTipLabel1;
@property (nonatomic, strong) UILabel *applyTipLabel2;
@property (nonatomic, strong) UITextView *introTextView;
@property (nonatomic, strong) UIButton *introButton;


@property (nonatomic, strong) UIButton *applyButton;
@property (nonatomic, strong) UIView *bottomLineView;
/// 填写的资料
@property (nonatomic, strong) NSMutableDictionary *resultDictM;

@end

@implementation MGWorkJoinTeamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"加入已有团队";
    self.view.backgroundColor = [UIColor whiteColor];
    
}


#pragma mark - 初始化控件
- (void)setupSubViews {

    _ciperTipLabel1 = [MGUITool labelWithText:@"如果你有团队的集结号，直接加入: "
                                    textColor:MGThemeColor_Black
                                         font:PFSC(30)];
    _ciperTipLabel1.frame = CGRectMake(SW(30), SH(30) + 64, kScreenWidth, _ciperTipLabel1.fontLineHeight);
    
    
    _ciperTipLabel2 = [MGUITool labelWithText:@"集结号: "
                                    textColor:MGThemeColor_subTitle_Black
                                         font:PFSC(30)];
    _ciperTipLabel2.frame = CGRectMake(SW(30), _ciperTipLabel1.bottom + SH(50), SW(120), _ciperTipLabel2.fontLineHeight);
    
    
    _ciperTextField = [[UITextField alloc] initWithFrame:CGRectMake(_ciperTipLabel2.right, _ciperTipLabel2.top, kScreenWidth - SW(300), _ciperTipLabel2.height)];
    [_ciperTextField limitTextLength:4];
    _ciperTextField.delegate = self;
    _ciperTextField.textColor = MGThemeColor_Title_Black;
    _ciperTextField.font = PFSC(30);
    _ciperTextField.placeholder = @"请输入四位数字的集结号";
    [_ciperTextField setValue:colorHex(@"#cccccc") forKeyPath:@"_placeholderLabel.textColor"];
    _ciperTextField.textAlignment = NSTextAlignmentLeft;
    
    _centerLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _ciperTipLabel2.bottom + SH(50), kScreenWidth - SW(48), MGSepLineHeight)];
    _centerLineView.backgroundColor = MGSepColor;
    
    _directButton = [MGUITool buttonWithBGColor:nil title:@"直接加入" titleColor: MGThemeColor_Title_Black font:MGThemeFont_30 target:self selector:@selector(directButtonOnClick)];
    _directButton.layer.cornerRadius = MGButtonLayerCorner;
    _directButton.layer.masksToBounds = YES;
    _directButton.frame = CGRectMake(kScreenWidth - SW(190), 0, SW(160), SH(60));
    _directButton.centerY = _ciperTipLabel2.centerY;
    [_directButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_directButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    
    
    _applyTipLabel1 = [MGUITool labelWithText:@"没有团队的集结号，但我想加入: "
                                    textColor:MGThemeColor_Black
                                         font:PFSC(30)];
    _applyTipLabel1.frame = CGRectMake(SW(30), _centerLineView.bottom + SH(30), kScreenWidth, _applyTipLabel1.fontLineHeight);
    
    
    _applyTipLabel2 = [MGUITool labelWithText:@"自我介绍: "
                                    textColor:MGThemeColor_subTitle_Black
                                         font:PFSC(30)];
    _applyTipLabel2.frame = CGRectMake(SW(30), _applyTipLabel1.bottom + SH(50), SW(145), _applyTipLabel2.fontLineHeight);
    
    
    _introTextView = [[UITextView alloc] initWithFrame:CGRectMake(_applyTipLabel2.right, 0, SW(350), SH(80))];
    _introTextView.centerY = _applyTipLabel2.centerY;
    _introTextView.textContainerInset = UIEdgeInsetsMake(SH(26), 0, 0, 0);
    _introTextView.placeCenterY = @(_introTextView.height * 0.5);
    _introTextView.delegate = self;
    _introTextView.textColor = MGThemeColor_Title_Black;
    _introTextView.font = PFSC(24);
    _introTextView.placeholder = @"请介绍自己的特长、留下个人的联系方式 (手机号、QQ号) ";
    _introTextView.placeholderColor = colorHex(@"#cccccc");
    _introTextView.textAlignment = NSTextAlignmentLeft;
    _introTextView.userInteractionEnabled = NO;
    
    _introButton = [[UIButton alloc] initWithFrame:_introTextView.frame];
    [_introButton addTarget:self action:@selector(introButtonButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _applyButton = [MGUITool buttonWithBGColor:nil title:@"申请加入" titleColor: MGThemeColor_Title_Black font:MGThemeFont_30 target:self selector:@selector(applyButtonOnClick)];
    _applyButton.frame = CGRectMake(kScreenWidth - SW(190), 0, SW(160), SH(60));
    _applyButton.centerY = _applyTipLabel2.centerY;
    _applyButton.layer.cornerRadius = MGButtonLayerCorner;
    _applyButton.layer.masksToBounds = YES;
    [_applyButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_applyButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    
    _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _applyTipLabel2.bottom + SH(50), kScreenWidth - SW(48), MGSepLineHeight)];
    _bottomLineView.backgroundColor = MGSepColor;
    
    [self.view sd_addSubviews:@[_ciperTipLabel1, _ciperTipLabel2, _ciperTextField, _directButton,
                                _centerLineView, _applyTipLabel1, _applyTipLabel2, _introTextView,
                                _introButton, _applyButton, _bottomLineView]];
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

- (void)directButtonOnClick {
    
    if (self.ciperTextField.text.length == 0) {
        [self showMBText:@"请输入集结暗号"];
        return;
    }
    
    [self.view endEditing:YES];
    
    [MGBussiness loadProject_Join:@{@"id" : @(self.dataModel.id), @"type" : @(2), @"team_id" : @(self.teamDataModel.id), @"cipher" : self.ciperTextField.text} completion:^(id results) {
        if ([results boolValue]) {
            [self showMBText:@"报名成功"];
            PopVC
        }
    } error:nil];
}

- (void)applyButtonOnClick {
    
    [self.view endEditing:YES];
    if (self.resultDictM.count == 0) {
        [self showMBText:@"请填写自我介绍"];
        return;
    }
    NSString *mobile = self.resultDictM[@"mobile"];
    NSString *content = self.resultDictM[@"content"];
    NSString *qq = self.resultDictM[@"qq"];
    
    [MGBussiness loadProject_Team_Apply:@{@"project_id" : @(self.dataModel.id), @"team_id" : @(self.teamDataModel.id), @"content" : content, @"mobile" : mobile, @"qq" : qq} completion:^(id results) {
        if ([results boolValue]) {
            DQAlertView *alert = [[DQAlertView alloc] initWithTitle:nil message:@"已将自我介绍发给队长" cancelButtonTitle:@"我知道了" otherButtonTitle:nil];
            [alert setAlertThemeMessageTip_OneButton];
            WEAK
            alert.cancelButtonAction = ^{
                STRONG
                PopVC
            };
            [alert show];
        }
    } error:nil];
    
}

- (void)introButtonButtonOnClick {
    
    [self.view endEditing:YES];
    
    MGWorkMyIntroVC *vc = [MGWorkMyIntroVC new];
    vc.resultDictM = self.resultDictM;
    WEAK
    vc.saveCompletionBlock = ^{
        STRONG
        self.introTextView.text = self.resultDictM[@"content"];
    };
    PushVC(vc)
    
}

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if ([string stringContainsEmoji]) {
        return NO;
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text stringContainsEmoji]) {
        return NO;
    }
    return YES;
}

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter
- (NSMutableDictionary *)resultDictM {
    if (!_resultDictM) {
        _resultDictM = @{}.mutableCopy;
    }
    return _resultDictM;
}

@end
