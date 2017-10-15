//
//  MGUpgradeTutorVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/22.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGUpgradeTutorVC.h"
#import "MGMineSettingView.h"
#import "TDSelectPhotoView.h"
#import "PPPhotoTaker.h"
#import "SDPhotoBrowser.h"
#import "MGLevelUpgradeSuccessVC.h"
#import "UIButton+NYImageLocation.h"
#import "MGLeveUpgradeUpdateVC.h"


@interface MGUpgradeTutorVC () <SDPhotoBrowserDelegate, UITextFieldDelegate>

@property (nonatomic, strong) TDSelectPhotoView *photoView;

@property (nonatomic, strong) UIScrollView *scrollView;
/// 形象
@property (nonatomic, strong) UIButton *iconButton;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *iconLineView;

/// url
@property (nonatomic, copy) NSString *avatar_rsurl;
/// 昵称
@property (nonatomic, strong) MGMineSettingView *nameSettingView;
@property (nonatomic, strong) UITextField *nameTextField;

/// 手机号
@property (nonatomic, strong) MGMineSettingView *phoneSettingView;
@property (nonatomic, strong) UITextField *phoneTextField;
/// 城市
@property (nonatomic, strong) MGMineSettingView *citySettingView;
@property (nonatomic, strong) UITextField *cityTextField;

/// 工作
@property (nonatomic, strong) MGMineSettingView *jobSettingView;
@property (nonatomic, strong) UITextField *jobTextField;

/// 关于
@property (nonatomic, strong) MGMineSettingView *aboutSettingView;
@property (nonatomic, strong) UITextField *aboutTextField;
/// 能力
@property (nonatomic, strong) MGMineSettingView *showSettingView;
@property (nonatomic, strong) UITextField *showTextField;

/// 社交
@property (nonatomic, strong) UIView *socialBgView;

/// 预览
@property (nonatomic, strong) UIButton *preShowButton;
/// 查看
@property (nonatomic, strong) UIButton *lookButton;

/// 提交按钮
@property (nonatomic, strong) UIButton *submitButton;
/// 提交提示
@property (nonatomic, strong) UILabel *bottomTipLabel;

@end

@implementation MGUpgradeTutorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"升级导师";
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - 初始化控件
- (void)setupSubViews {
    WEAK
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    _scrollView.showsVerticalScrollIndicator = NO;
    
    
    _iconButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(260))];

    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(260))];
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    
    _iconButton.titleLabel.font = MGThemeFont_30;
    [_iconButton setTitle:@"点击上传您的形象照片" forState:UIControlStateNormal];
    [_iconButton setTitleColor:MGThemeColor_Title_Black forState:UIControlStateNormal];
    [_iconButton addTarget:self action:@selector(iconButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    [_iconButton setImage:[UIImage imageNamed:@"mine_icon_camera"] forState:UIControlStateNormal];
    [_iconButton setImageLocation:NYImageLocationTop spacing:SH(20)];
    
    _iconLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _iconButton.bottom, kScreenWidth, MGSepLineHeight)];
    _iconLineView.backgroundColor = MGSepColor;
    
    
    
    _nameSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _iconLineView.bottom, kScreenWidth, MineSettingViewHeight)];
    _nameSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"姓名* : " attr:@{NSFontAttributeName : _nameSettingView.titleLabel.font, NSForegroundColorAttributeName : _nameSettingView.titleLabel.textColor}];
    
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _nameTextField.delegate = self;
    _nameTextField.textColor = MGThemeColor_Common_Black;
    _nameTextField.font = PFSC(28);
    _nameTextField.placeholder = @"请输入姓名";
    _nameTextField.textAlignment = NSTextAlignmentRight;
    _nameSettingView.customSubView = _nameTextField;
    [_nameSettingView setArrowImageHidden];
    
    _phoneSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _nameSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _phoneSettingView.titleLabel.text = @"联系手机 : ";
    _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _phoneTextField.delegate = self;
    _phoneTextField.textColor = MGThemeColor_Common_Black;
    _phoneTextField.font = PFSC(28);
    _phoneTextField.placeholder = @"请输入联系手机";
    _phoneTextField.textAlignment = NSTextAlignmentRight;
    _phoneSettingView.customSubView = _phoneTextField;
    [_phoneSettingView setArrowImageHidden];
    
    
    
    _citySettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _phoneSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _citySettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"城市* : " attr:@{NSFontAttributeName : _citySettingView.titleLabel.font, NSForegroundColorAttributeName : _citySettingView.titleLabel.textColor}];
    
    _cityTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _cityTextField.delegate = self;
    _cityTextField.textColor = MGThemeColor_Common_Black;
    _cityTextField.font = PFSC(28);
    _cityTextField.placeholder = @"请输入城市";
    _cityTextField.textAlignment = NSTextAlignmentRight;
    _citySettingView.customSubView = _cityTextField;
    [_citySettingView setArrowImageHidden];
    
    
    _jobSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _citySettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _jobSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"职业 (身份) * : " attr:@{NSFontAttributeName : _jobSettingView.titleLabel.font, NSForegroundColorAttributeName : _jobSettingView.titleLabel.textColor}];
    
    _jobTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _jobTextField.delegate = self;
    _jobTextField.textColor = MGThemeColor_Common_Black;
    _jobTextField.font = PFSC(28);
    _jobTextField.placeholder = @"请输入职业";
    _jobTextField.textAlignment = NSTextAlignmentRight;
    _jobSettingView.customSubView = _jobTextField;
    [_jobSettingView setArrowImageHidden];
    
    

    _aboutSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _jobSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _aboutSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"关于我* : " attr:@{NSFontAttributeName : _aboutSettingView.titleLabel.font, NSForegroundColorAttributeName : _aboutSettingView.titleLabel.textColor}];
    
    _aboutTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _aboutTextField.delegate = self;
    _aboutTextField.textColor = MGThemeColor_Common_Black;
    _aboutTextField.font = PFSC(28);
    _aboutTextField.placeholder = @"请输入详细介绍";
    _aboutTextField.textAlignment = NSTextAlignmentRight;
    _aboutTextField.userInteractionEnabled = NO;
    _aboutSettingView.customSubView = _aboutTextField;
   
    _aboutSettingView.tag = 100001;
    _aboutSettingView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundOnClickWithTag:tag];
    };
    [_aboutSettingView setArrowImageHidden];
    
    
    
    
    _showSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _aboutSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _showSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"能力展示 : " attr:@{NSFontAttributeName : _aboutSettingView.titleLabel.font, NSForegroundColorAttributeName : _aboutSettingView.titleLabel.textColor}];
    
    _showTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _showTextField.delegate = self;
    _showTextField.textColor = MGThemeColor_Common_Black;
    _showTextField.font = PFSC(28);
    _showTextField.placeholder = @"请输入个人特长";
    _showTextField.textAlignment = NSTextAlignmentRight;
    _showTextField.userInteractionEnabled = NO;
    _showSettingView.customSubView = _showTextField;
    
    _showSettingView.tag = 100002;
    _showSettingView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundOnClickWithTag:tag];
    };
    [_showSettingView setArrowImageHidden];
    
    
    
    _socialBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _showSettingView.bottom, kScreenWidth, SH(240))];
    UILabel *socialTipLabel = [MGUITool labelWithText:@"社交链接 : " textColor:MGThemeColor_Title_Black font:PFSC(28)];
    socialTipLabel.frame = CGRectMake(SW(30), SH(30), kScreenWidth * 0.5, socialTipLabel.fontLineHeight);
    [_socialBgView sd_addSubviews:@[socialTipLabel]];
    
    
    NSArray *images = @[@"mine_weibo", @"mine_linkedin", @"mine_zhihu", @"mine_qita"];
    NSArray *titles = @[@"微博", @"Linkedin", @"知乎", @"其他"];
    
    
    for (int i = 0; i < 4; i++) {
        NSString *image = images[i];
        NSString *titls = titles[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(SW(34) + i * (SW(160) + SW(10)), socialTipLabel.bottom + SH(30), SW(160), SH(140));
        button.tag = 100 + i;
        button.titleLabel.textColor = MGThemeColor_Common_Black;
        button.titleLabel.font = PFSC(20);
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [button setTitle:titls forState:UIControlStateNormal];
        [button setTitleColor:MGThemeColor_Common_Black forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setImageLocation:NYImageLocationTop spacing:SH(14)];
        [_socialBgView addSubview:button];
        
    }
    
    
    UIView *socialLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(30), _socialBgView.height, kScreenWidth - SW(60), MGSepLineHeight)];
    socialLineView.backgroundColor = MGSepColor;
    [_socialBgView addSubview:socialLineView];
    
    
    _preShowButton = [MGUITool buttonWithBGColor:nil title:@"预览我的导师首页>" titleColor:MGThemeShenYellowColor font:MGThemeFont_28 target:self selector:@selector(preShowButtonOnClick)];
    _preShowButton.frame = CGRectMake(SW(60), _socialBgView.bottom + SH(100), SW(280), SH(44));
    
    
    _lookButton = [MGUITool buttonWithBGColor:nil title:@"查看优秀案例>" titleColor:MGThemeShenYellowColor font:MGThemeFont_28 target:self selector:@selector(lookButtonOnClick)];
    _lookButton.frame = CGRectMake(kScreenWidth - SW(200) - SW(60), _socialBgView.bottom + SH(100), SW(200), SH(44));
    _lookButton.titleLabel.textAlignment = NSTextAlignmentRight;
    
    
    
    _submitButton = [MGUITool buttonWithBGColor:nil title:@"提交认证" titleColor:MGThemeColor_Black font:MGThemeFont_36 target:self selector:@selector(submitButtonOnClick)];
    _submitButton.frame = CGRectMake(SW(75), _lookButton.bottom + SH(52), SW(600), SH(84));
    [_submitButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_submitButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    _submitButton.layer.masksToBounds = YES;
    _submitButton.layer.cornerRadius = MGButtonLayerCorner;
    
    
    _bottomTipLabel = [MGUITool labelWithText:@"所有信息讲受平台加密保存" textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _bottomTipLabel.textAlignment = NSTextAlignmentCenter;
    _bottomTipLabel.frame = CGRectMake(0, _submitButton.bottom + SH(30), kScreenWidth, PFSC(28).lineHeight);
    
    
    [_scrollView sd_addSubviews:@[_iconButton, _iconImageView, _iconLineView,
                                  _nameSettingView,
                                  _phoneSettingView,
                                  _citySettingView,
                                  _jobSettingView,
                                  _aboutSettingView,
                                  _showSettingView,
                                  _socialBgView,
                                  _preShowButton,
                                  _lookButton,
                                  _submitButton,
                                  _bottomTipLabel]];
    
    [self.view addSubview:_scrollView];
    
    _scrollView.contentSize = CGSizeMake(kScreenWidth, _bottomTipLabel.bottom + SH(30));
    
}

#pragma mark - 加载数据
- (void)loadData {
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

- (void)iconButtonOnClick {
    
    [self backgroundTap];
    
}
- (void)backgroundOnClickWithTag:(NSInteger)tag {
    WEAK
    switch (tag) {
        case 100001: /// 关于我
        {
        
            MGLeveUpgradeUpdateVC *vc = [MGLeveUpgradeUpdateVC new];
            vc.titleString = @"介绍自己";
            vc.limitNumber = @"400";
            
            vc.completionBlock = ^(NSString *text){
                STRONG
                self.aboutTextField.text = text;
            };
            
            MGNavigationController *nav = [[MGNavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
            
        }
            break;
            
        case 100002: /// 个人特长
        {
            
            MGLeveUpgradeUpdateVC *vc = [MGLeveUpgradeUpdateVC new];
            vc.titleString = @"个人能力";
            vc.limitNumber = @"200";
            
            vc.completionBlock = ^(NSString *text){
                STRONG
                self.showTextField.text = text;
            };
            
            MGNavigationController *nav = [[MGNavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
            
        }
            break;
    }
    
}


- (void)buttonOnClick:(UIButton *)btn {
    
    switch (btn.tag) {
        case 100: /// 微博
        {
            
        }
        case 101: /// linkedin
        {
        
        }
            break;
        case 102: /// 知乎
        {
            
        }
            break;
        case 103: /// 其他
        {
            
        }
            break;
    }
    
}

/// 预览我的导师首页
- (void)preShowButtonOnClick {
    
    
}
/// 查看
- (void)lookButtonOnClick {
    
    
}
/// 提交
- (void)submitButtonOnClick {
    
    
    DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:nil message:@"您确定要提交吗？" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    [alertView setAlertThemeMessageTip_TwoButton];
    WEAK
    alertView.otherButtonAction = ^{
        STRONG
        NSString *name = _nameTextField.text;
        NSString *phone = _phoneTextField.text;
        NSString *city = _cityTextField.text;
        NSString *job = _jobTextField.text;
        NSString *about = _aboutTextField.text;
        NSString *show = _showTextField.text;
        
        NSMutableString *resultString = @"".mutableCopy;
        
        if (name.length == 0) {
            [resultString appendString:@"请输入姓名、"];
        }
        
        if (city.length == 0) {
            [resultString appendString:@"请输入城市、"];
        }
        if (job.length == 0) {
            [resultString appendString:@"请输入职业、"];
        }
        if (about.length == 0) {
            [resultString appendString:@"请输入详细介绍、"];
        }
        if (self.avatar_rsurl.length == 0) {
            [resultString appendString:@"请上传您的形象图片、"];
        }
        
        if (resultString.length > 0) {
            NSString *alertStr = [resultString substringToIndex:resultString.length - 1];
            DQAlertView *checkAlertView = [[DQAlertView alloc] initWithTitle:nil message:alertStr cancelButtonTitle:@"我知道了" otherButtonTitle:nil];
            [checkAlertView setAlertThemeMessageTip_OneButton];
            [checkAlertView show];
            return;
        } else { /// 提交数据
            
            [MGBussiness loadUpgradeWithType:1 params:@{@"name" : name, @"city" : city, @"jobs" : job, @"about_me" : about, @"logo_rsurl" : self.avatar_rsurl, @"ability" : show} completion:^(id results) {
                
                if ([results boolValue]) {
                    MGLevelUpgradeSuccessVC *vc = [MGLevelUpgradeSuccessVC new];
                    vc.titleString = @"升级为导师";
                    PushVC(vc)
                }
                
            } error:nil];
        }
        
    };
    [alertView show];
    
    
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string stringContainsEmoji]) {
        return NO;
    }
    
    return YES;
}
#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

- (void)backgroundTap {
    [self.view endEditing:YES];
    [self.photoView setBottomTtitleWithString:self.avatar_rsurl.length > 0 ? @"查看" : @"取消"];
    [self.photoView showSelectPhotoWithAnimated:YES inView:KeyWindow];
}

- (TDSelectPhotoView *)photoView {
    if (!_photoView) {
        _photoView = [[TDSelectPhotoView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        WEAK
        _photoView.buttonPhotoOnClickBlock = ^(SelectPhotoViewType type) {
            STRONG
            
            if (type == SelectPhotoViewTypeTakePhoto) {
                
                [PPPhotoTaker getPictureFromCemeraNeedEditing:YES needSaveInLibrary:YES finishBlock:^(UIImage *image) {
                    STRONG
                    [self uploadIconImageWithImage:image];
                }];
                
            } else if (type == SelectPhotoViewTypeSelectPhoto) {
                [PPPhotoTaker getPictureFromLibraryNeedEditing:YES finishBlock:^(UIImage *image) {
                    STRONG
                    [self uploadIconImageWithImage:image];
                }];
            } else {
                if (self.avatar_rsurl.length > 0) {
                    SDPhotoBrowser *photoBrowser = [[SDPhotoBrowser alloc] init];
                    photoBrowser.delegate = self;
                    photoBrowser.currentImageIndex = 0;
                    photoBrowser.imageCount = 1;
                    photoBrowser.sourceImagesContainerView = self.view;
                    [photoBrowser show];
                }
            }
            
            
        };
        [KeyWindow addSubview:_photoView];
    }
    return _photoView;
}

- (void)uploadIconImageWithImage:(UIImage *)image {
    
    [MGBussiness updateLoadImageWithImage:image completion:^(NSString *results) {
        self.avatar_rsurl = results;
        
        [self changeIconImage];
        
    } error:nil];
    
}

- (void)changeIconImage {
    
    if (self.avatar_rsurl.length > 0) {
        
        [self.iconButton setImage:nil forState:UIControlStateNormal];
        [self.iconButton setTitle:@"" forState:UIControlStateNormal];
        
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.avatar_rsurl] placeholderImage:SDWEB_PLACEHODER_IMAGE_ICON];
        
    }
}

#pragma mark - SDPhotoBrowserDelegate
// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return nil;
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    return [NSURL URLWithString:self.avatar_rsurl];
}
#pragma mark - Getter and Setter

@end
