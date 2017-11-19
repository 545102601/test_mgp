//
//  MGUpgradeCompanyVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/22.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGUpgradeCompanyVC.h"
#import "MGMineSettingView.h"
#import "MGLevelUpgradeSuccessVC.h"

@interface MGUpgradeCompanyVC () <UITextFieldDelegate>


@property (nonatomic, strong) UIScrollView *scrollView;


/// 企业编码
@property (nonatomic, strong) MGMineSettingView *companyNoSettingView;
@property (nonatomic, strong) UITextField *companyNoTextField;


/// 企业昵称
@property (nonatomic, strong) MGMineSettingView *companyNameSettingView;
@property (nonatomic, strong) UITextField *companyNameTextField;

/// 昵称
@property (nonatomic, strong) MGMineSettingView *nameSettingView;
@property (nonatomic, strong) UITextField *nameTextField;


/// 工作
@property (nonatomic, strong) MGMineSettingView *jobSettingView;
@property (nonatomic, strong) UITextField *jobTextField;


/// 手机号
@property (nonatomic, strong) MGMineSettingView *phoneSettingView;
@property (nonatomic, strong) UITextField *phoneTextField;


/// 提交按钮
@property (nonatomic, strong) UIButton *submitButton;
/// 提交提示
@property (nonatomic, strong) UILabel *bottomTipLabel;

@end


@implementation MGUpgradeCompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册为企业";
}


#pragma mark - 初始化控件
- (void)setupSubViews {
    
    WEAK
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    _scrollView.showsVerticalScrollIndicator = NO;
    
    _companyNoSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, MineSettingViewHeight)];
    _companyNoSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"企业编码* : " attr:@{NSFontAttributeName : _companyNoSettingView.titleLabel.font, NSForegroundColorAttributeName : _companyNoSettingView.titleLabel.textColor}];
    
    UIView *companyBgView = [[UIView alloc] initWithFrame:CGRectMake(_companyNoSettingView.width - SW(520), 0, SW(520), MineSettingViewHeight)];
    
    
    UIButton *_checkButton = [MGUITool buttonWithBGColor:nil title:@"验证" titleColor: MGThemeColor_Title_Black font:MGThemeFont_28 target:self selector:@selector(checkButtonOnClick)];
    _checkButton.frame = CGRectMake(companyBgView.width - SW(30) - SW(120), 0, SW(120), SH(64));
    _checkButton.centerY = companyBgView.height*0.5;
    [_checkButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_checkButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    _checkButton.layer.masksToBounds = YES;
    _checkButton.layer.cornerRadius = MGButtonLayerCorner;
    
    
    _companyNoTextField = [[UITextField alloc] initWithFrame:CGRectMake(_checkButton.left - SW(20) - SW(350), 0, SW(350), MineSettingViewHeight)];
    _companyNoTextField.delegate = self;
    _companyNoTextField.textColor = MGThemeColor_Common_Black;
    _companyNoTextField.font = PFSC(28);
    _companyNoTextField.placeholder = @"请输入企业编码进行验证";
    _companyNoTextField.textAlignment = NSTextAlignmentRight;
    
    [_companyNoTextField addTarget:self action:@selector(companyDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [companyBgView sd_addSubviews:@[_checkButton, _companyNoTextField]];
    
    _companyNoSettingView.customSubView = companyBgView;
    [_companyNoSettingView setArrowImageHidden];
    
    
    _companyNameSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _companyNoSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _companyNameSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"企业名称* : " attr:@{NSFontAttributeName : _companyNameSettingView.titleLabel.font, NSForegroundColorAttributeName : _companyNameSettingView.titleLabel.textColor}];
    
    _companyNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _companyNameTextField.delegate = self;
    _companyNameTextField.textColor = MGThemeColor_Common_Black;
    _companyNameTextField.font = PFSC(28);
    _companyNameTextField.placeholder = @"验证企业编码后返回";
    _companyNameTextField.textAlignment = NSTextAlignmentRight;
    _companyNameTextField.userInteractionEnabled = NO;
    _companyNameSettingView.customSubView = _companyNameTextField;
    [_companyNameSettingView setArrowImageHidden];
    
    
    _nameSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _companyNameSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _nameSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"姓名* : " attr:@{NSFontAttributeName : _nameSettingView.titleLabel.font, NSForegroundColorAttributeName : _nameSettingView.titleLabel.textColor}];
    
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _nameTextField.delegate = self;
    [_nameTextField limitTextLength:10];
    _nameTextField.textColor = MGThemeColor_Common_Black;
    _nameTextField.font = PFSC(28);
    _nameTextField.placeholder = @"请输入姓名";
    _nameTextField.textAlignment = NSTextAlignmentRight;
    _nameSettingView.customSubView = _nameTextField;
    [_nameSettingView setArrowImageHidden];
    
    
    _jobSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _nameSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _jobSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"职业 (身份) * : " attr:@{NSFontAttributeName : _jobSettingView.titleLabel.font, NSForegroundColorAttributeName : _jobSettingView.titleLabel.textColor}];
    
    _jobTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _jobTextField.delegate = self;
    _jobTextField.textColor = MGThemeColor_Common_Black;
    _jobTextField.font = PFSC(28);
    _jobTextField.placeholder = @"请输入职业";
    _jobTextField.textAlignment = NSTextAlignmentRight;
    _jobSettingView.customSubView = _jobTextField;
    [_jobSettingView setArrowImageHidden];
    
    
    _phoneSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _jobSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _phoneSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"联系手机 * : " attr:@{NSFontAttributeName : _phoneSettingView.titleLabel.font, NSForegroundColorAttributeName : _phoneSettingView.titleLabel.textColor}];
    _phoneSettingView.hidden = YES;
    
    
    
    _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _phoneTextField.delegate = self;
    _phoneTextField.textColor = MGThemeColor_Common_Black;
    _phoneTextField.font = PFSC(28);
    _phoneTextField.placeholder = @"请输入联系手机";
    _phoneTextField.textAlignment = NSTextAlignmentRight;
    _phoneSettingView.customSubView = _phoneTextField;
    [_phoneSettingView setArrowImageHidden];
    
    
    
    _submitButton = [MGUITool buttonWithBGColor:nil title:@"提交认证" titleColor: MGThemeColor_Title_Black font:MGThemeFont_36 target:self selector:@selector(submitButtonOnClick)];
    _submitButton.frame = CGRectMake(SW(75), _jobSettingView.bottom + SH(540), SW(600), SH(84));
    [_submitButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_submitButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    _submitButton.layer.masksToBounds = YES;
    _submitButton.layer.cornerRadius = MGButtonLayerCorner;
    
    
    _bottomTipLabel = [MGUITool labelWithText:@"所有信息将受平台加密保存 , 严密监管" textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _bottomTipLabel.textAlignment = NSTextAlignmentCenter;
    _bottomTipLabel.frame = CGRectMake(0, _submitButton.bottom + SH(30), kScreenWidth, PFSC(28).lineHeight);
    
    
    [_scrollView sd_addSubviews:@[_companyNoSettingView,
                                  _companyNameSettingView,
                                  _nameSettingView,
                                  _phoneSettingView,
                                  _jobSettingView,
                                  _submitButton,
                                  _bottomTipLabel]];
    
    [self.view addSubview:_scrollView];
    
    _scrollView.contentSize = CGSizeMake(kScreenWidth, _bottomTipLabel.bottom + SH(20));
    
}

#pragma mark - 加载数据
- (void)loadData {
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 检查企业信息
- (void)checkButtonOnClick {
    
    NSString *companyNo = _companyNoTextField.text;
    
    if (companyNo.length == 0) {
        [self showMBText:@"请输入企业编码进行验证"];
        return;
    }
    
    [MGBussinessRequest postCompany_Get:@{@"company_no" : companyNo} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            NSString *company_name = dic[@"data"][@"company_name"];
            if (company_name.length > 0) {
                
                self.companyNameTextField.text = company_name;
                
            }else {
                [self showMBText:message];
            }
            
        } else {
            [self showMBText:message];
        }
        
    } errorBlock:nil];
    
    
    
    
}
/// 提交认证
- (void)submitButtonOnClick {
    
    DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:nil message:@"您确定要提交吗？" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    [alertView setAlertThemeMessageTip_TwoButton];
    WEAK
    alertView.otherButtonAction = ^{
        STRONG
        
        NSString *no = _companyNoTextField.text;
        NSString *comName = _companyNameTextField.text;
        
        NSString *name = _nameTextField.text;
        NSString *job = _jobTextField.text;
//        NSString *phone = _phoneTextField.text;
        
        
        NSMutableString *resultString = @"".mutableCopy;
        
        if (no.length == 0) {
            [resultString appendString:@"请输入企业编码、"];
        }
        if (comName.length == 0) {
            [resultString appendString:@"请输入企业名称、"];
        }
        if (name.length == 0) {
            [resultString appendString:@"请输入姓名、"];
        }
        
        if (job.length == 0) {
            [resultString appendString:@"请输入职业、"];
        }
//        if (phone.length == 0) {
//            [resultString appendString:@"请输入联系手机、"];
//        } else {
//            if (![phone checkPhoneNum]) {
//                [resultString appendString:@"请输入正确的手机号码、"];
//            }
//        }
        
        if (resultString.length > 0) {
            NSString *alertStr = [resultString substringToIndex:resultString.length - 1];
            DQAlertView *checkAlertView = [[DQAlertView alloc] initWithTitle:nil message:alertStr cancelButtonTitle:@"我知道了" otherButtonTitle:nil];
            [checkAlertView setAlertThemeMessageTip_OneButton];
            [checkAlertView show];
            return;
        } else { /// 提交数据
            
            [MGBussiness loadUpgradeWithType:2 params:@{@"company_no" : no, @"company_name" : comName, @"name" : name,  @"job" : job} completion:^(id results) {
                
                if ([results boolValue]) {
                    MGLevelUpgradeSuccessVC *vc = [MGLevelUpgradeSuccessVC new];
                    vc.titleString = @"注册为企业";
                    PushVC(vc)
                }
                
            } error:nil];
        }
        
    };
    [alertView show];
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate
/// 企业编码有变动 清空企业名称
- (void)companyDidChange:(UITextField *)textField {
    
    self.companyNameTextField.text = @"";
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if ([string stringContainsEmoji]) {
        return NO;
    }
    
    return YES;
}
#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter
@end
