//
//  MGUpgradeCommunityVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/22.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGUpgradeCommunityVC.h"
#import "MGMineSettingView.h"
#import "TDSelectPhotoView.h"
#import "PPPhotoTaker.h"
#import "SDPhotoBrowser.h"
#import "MGLevelUpgradeSuccessVC.h"
#import "UIButton+NYImageLocation.h"
#import "MGLeveUpgradeUpdateVC.h"
#import "MGResCommunityTypeListModel.h"
#import "MGResCommunityClassicListModel.h"
#import "DQAlertView+SelectTableViewExtend.h"

@interface MGUpgradeCommunityVC ()<SDPhotoBrowserDelegate, UITextFieldDelegate, DQAlertViewDelegate>

@property (nonatomic, strong) TDSelectPhotoView *photoView;

@property (nonatomic, strong) UIScrollView *scrollView;
/// 形象
@property (nonatomic, strong) UIButton *iconButton;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *iconLineView;

/// url
@property (nonatomic, copy) NSString *avatar_rsurl;

/// 社团类型
@property (nonatomic, strong) MGMineSettingView *typeSettingView;

/// 社团昵称
@property (nonatomic, strong) MGMineSettingView *nameSettingView;
@property (nonatomic, strong) UITextField *nameTextField;

/// 城市
@property (nonatomic, strong) MGMineSettingView *citySettingView;
@property (nonatomic, strong) UITextField *cityTextField;


/// 学校
@property (nonatomic, strong) MGMineSettingView *schoolSettingView;
@property (nonatomic, strong) UITextField *schoolTextField;

/// 社团分类
@property (nonatomic, strong) MGMineSettingView *categorySettingView;

/// 社团介绍
@property (nonatomic, strong) MGMineSettingView *introSettingView;
@property (nonatomic, strong) UITextField *introTextField;

/// 联系人
@property (nonatomic, strong) MGMineSettingView *contactSettingView;
@property (nonatomic, strong) UITextField *contactTextField;

/// 手机号
@property (nonatomic, strong) MGMineSettingView *phoneSettingView;
@property (nonatomic, strong) UITextField *phoneTextField;


/// 提交按钮
@property (nonatomic, strong) UIButton *submitButton;
/// 提交提示
@property (nonatomic, strong) UILabel *bottomTipLabel;

@property (nonatomic, strong) NSMutableArray *categorySelectArray;

@property (nonatomic, strong) NSMutableArray *typeSelectArray;

@end

@implementation MGUpgradeCommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"注册为社团";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)loadData {
    
    _scrollView.hidden = YES;
    
    _categorySelectArray = @[].mutableCopy;
    _typeSelectArray = @[].mutableCopy;
    
    [MGBussiness loadCommunityType_ListWithCompletion:^(NSArray *typeArray) {
        
        [MGBussiness loadCommunityClassic_ListWithCompletion:^(NSArray *classicArray) {
            
            _scrollView.hidden = NO;
            
            /// 组装分类数组
            for (MGResCommunityTypeListDataModel *dataModel in typeArray) {
                DQAlertSelectedModel *model = [DQAlertSelectedModel new];
                model.id = dataModel.id;
                model.title = dataModel.type_name;
                [self.typeSelectArray addObject:model];
                
            }
            
            
            /// 组装分类数组
            for (MGResCommunityClassicListDataModel *dataModel in classicArray) {
                DQAlertSelectedModel *model = [DQAlertSelectedModel new];
                model.id = dataModel.id;
                model.title = dataModel.classic_name;
                [self.categorySelectArray addObject:model];
                
            }
            
            
            
        } error:nil];
        
    } error:nil];
    

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
    
    _typeSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _iconLineView.bottom, kScreenWidth, MineSettingViewHeight)];
    _typeSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"社团类型* : " attr:@{NSFontAttributeName : _typeSettingView.titleLabel.font, NSForegroundColorAttributeName : _typeSettingView.titleLabel.textColor}];
    _typeSettingView.subTitlelabel.text = @"请选择";
    _typeSettingView.tag = 1000;
    _typeSettingView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self showAlertWithType:0 targetView:self.typeSettingView.subTitlelabel];
    };
    

    
    _nameSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _typeSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _nameSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"姓名* : " attr:@{NSFontAttributeName : _nameSettingView.titleLabel.font, NSForegroundColorAttributeName : _nameSettingView.titleLabel.textColor}];
    
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _nameTextField.delegate = self;
    _nameTextField.textColor = MGThemeColor_Common_Black;
    _nameTextField.font = PFSC(28);
    _nameTextField.placeholder = @"请输入姓名";
    _nameTextField.textAlignment = NSTextAlignmentRight;
    _nameSettingView.customSubView = _nameTextField;
    [_nameSettingView setArrowImageHidden];
    
    
    _citySettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _nameSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _citySettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"城市* : " attr:@{NSFontAttributeName : _citySettingView.titleLabel.font, NSForegroundColorAttributeName : _citySettingView.titleLabel.textColor}];
    
    _cityTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _cityTextField.delegate = self;
    _cityTextField.textColor = MGThemeColor_Common_Black;
    _cityTextField.font = PFSC(28);
    _cityTextField.placeholder = @"请输入城市";
    _cityTextField.textAlignment = NSTextAlignmentRight;
    _citySettingView.customSubView = _cityTextField;
    [_citySettingView setArrowImageHidden];
    
    _schoolSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _citySettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _schoolSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"所在大学学校 : " attr:@{NSFontAttributeName : _schoolSettingView.titleLabel.font, NSForegroundColorAttributeName : _schoolSettingView.titleLabel.textColor}];
    
    _schoolTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _schoolTextField.delegate = self;
    _schoolTextField.textColor = MGThemeColor_Common_Black;
    _schoolTextField.font = PFSC(28);
    _schoolTextField.placeholder = @"请输入学校名称";
    _schoolTextField.textAlignment = NSTextAlignmentRight;
    _schoolSettingView.customSubView = _schoolTextField;
    [_schoolSettingView setArrowImageHidden];
    
    
    _categorySettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _schoolSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _categorySettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"社团分类 : " attr:@{NSFontAttributeName : _categorySettingView.titleLabel.font, NSForegroundColorAttributeName : _categorySettingView.titleLabel.textColor}];
    _categorySettingView.subTitlelabel.text = @"请选择";
    _categorySettingView.tag = 1000;
    _categorySettingView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self showAlertWithType:1 targetView:self.categorySettingView.subTitlelabel];
    };
    
    
    
    _introSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _categorySettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _introSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"社团介绍* : " attr:@{NSFontAttributeName : _introSettingView.titleLabel.font, NSForegroundColorAttributeName : _introSettingView.titleLabel.textColor}];
    
    _introTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _introTextField.delegate = self;
    _introTextField.textColor = MGThemeColor_Common_Black;
    _introTextField.font = PFSC(28);
    _introTextField.placeholder = @"请输入详细介绍";
    _introTextField.textAlignment = NSTextAlignmentRight;
    _introTextField.userInteractionEnabled = NO;
    _introSettingView.customSubView = _introTextField;
    
    _introSettingView.tag = 100002;
    _introSettingView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundOnClickWithTag:tag];
    };
    [_introSettingView setArrowImageHidden];
    
    
    
    
    _contactSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _introSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _contactSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"联系人* : " attr:@{NSFontAttributeName : _contactSettingView.titleLabel.font, NSForegroundColorAttributeName : _contactSettingView.titleLabel.textColor}];
    
    
    
    _contactTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _contactTextField.delegate = self;
    _contactTextField.textColor = MGThemeColor_Common_Black;
    _contactTextField.font = PFSC(28);
    _contactTextField.placeholder = @"请输入联系人名称";
    _contactTextField.textAlignment = NSTextAlignmentRight;
    _contactSettingView.customSubView = _contactTextField;
    
    _contactSettingView.tag = 100001;
//    _contactSettingView.backgroundTapWithTagBlock = ^(NSInteger tag) {
//        STRONG
//        [self backgroundOnClickWithTag:tag];
//    };
    [_contactSettingView setArrowImageHidden];

    
    _phoneSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _contactSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _phoneSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"联系手机* : " attr:@{NSFontAttributeName : _phoneSettingView.titleLabel.font, NSForegroundColorAttributeName : _phoneSettingView.titleLabel.textColor}];
    
    _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _phoneTextField.delegate = self;
    _phoneTextField.textColor = MGThemeColor_Common_Black;
    _phoneTextField.font = PFSC(28);
    _phoneTextField.placeholder = @"请输入联系手机";
    _phoneTextField.textAlignment = NSTextAlignmentRight;
    _phoneSettingView.customSubView = _phoneTextField;
    [_phoneSettingView setArrowImageHidden];
    
    
    
    
    _submitButton = [MGUITool buttonWithBGColor:nil title:@"提交认证" titleColor:MGThemeColor_Black font:MGThemeFont_36 target:self selector:@selector(submitButtonOnClick)];
    _submitButton.frame = CGRectMake(SW(75), _phoneSettingView.bottom + SH(40), SW(600), SH(84));
    [_submitButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_submitButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    _submitButton.layer.masksToBounds = YES;
    _submitButton.layer.cornerRadius = MGButtonLayerCorner;
    
    
    _bottomTipLabel = [MGUITool labelWithText:@"所有信息讲受平台加密保存" textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _bottomTipLabel.textAlignment = NSTextAlignmentCenter;
    _bottomTipLabel.frame = CGRectMake(0, _submitButton.bottom + SH(30), kScreenWidth, PFSC(28).lineHeight);
    
    
    [_scrollView sd_addSubviews:@[_iconButton, _iconImageView, _iconLineView,
                                  _typeSettingView,
                                  _categorySettingView,
                                  _nameSettingView,
                                  _phoneSettingView,
                                  _citySettingView,
                                  _schoolSettingView,
                                  _contactSettingView,
                                  _introSettingView,
                                  _submitButton,
                                  _bottomTipLabel]];
    
    [self.view addSubview:_scrollView];
    
    _scrollView.contentSize = CGSizeMake(kScreenWidth, _bottomTipLabel.bottom + SH(30));
    
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
        case 100001: /// 联系人
        {
            
            MGLeveUpgradeUpdateVC *vc = [MGLeveUpgradeUpdateVC new];
            vc.titleString = @"联系人";
            vc.limitNumber = @"10";
            
            vc.completionBlock = ^(NSString *text){
                STRONG
                self.contactTextField.text = text;
            };
            
            MGNavigationController *nav = [[MGNavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
            
        }
            break;
            
        case 100002: /// 社团介绍
        {
            
            MGLeveUpgradeUpdateVC *vc = [MGLeveUpgradeUpdateVC new];
            vc.titleString = @"社团介绍";
            vc.limitNumber = @"200";
            
            vc.completionBlock = ^(NSString *text){
                STRONG
                self.introTextField.text = text;
            };
            
            MGNavigationController *nav = [[MGNavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
            
        }
            break;
    }
    
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
        NSString *school = _schoolTextField.text;
        NSString *contact = _contactTextField.text;
        NSString *intro = _introTextField.text;
        
        
        NSString *typeName = @"";
        
        for (DQAlertSelectedModel *model in self.typeSelectArray) {
            if (model.isSelected) {
                typeName = model.title;
                break;
            }
        }
        
        NSString *categoryName = @"";
        
        for (DQAlertSelectedModel *model in self.categorySelectArray) {
            if (model.isSelected) {
                categoryName = model.title;
                break;
            }
        }
        
        
        
        
        
        NSMutableString *resultString = @"".mutableCopy;
        
        if (typeName.length == 0) {
            
            [resultString appendString:@"请选择社团类型、"];
        }
        
        if (name.length == 0) {
            [resultString appendString:@"请输入社团昵称、"];
        }
        
        if (city.length == 0) {
            [resultString appendString:@"请输入城市、"];
        }
        
        if (intro.length == 0) {
            [resultString appendString:@"请输入社团介绍、"];
        }
        
        if (contact.length == 0) {
            [resultString appendString:@"请输入联系人、"];
        }
        
        
        if (self.avatar_rsurl.length == 0) {
            [resultString appendString:@"请上传您的形象图片、"];
        }
        
        if (phone.length == 0) {
            [resultString appendString:@"请输入联系手机、"];
        } else {
            if (![phone checkPhoneNum]) {
                [resultString appendString:@"请输入正确的手机号码、"];
            }
        }
        
        if (resultString.length > 0) {
            NSString *alertStr = [resultString substringToIndex:resultString.length - 1];
            DQAlertView *checkAlertView = [[DQAlertView alloc] initWithTitle:nil message:alertStr cancelButtonTitle:@"我知道了" otherButtonTitle:nil];
            [checkAlertView setAlertThemeMessageTip_OneButton];
            [checkAlertView show];
            return;
        } else { /// 提交数据
            
            [MGBussiness loadUpgradeWithType:3 params:@{@"community_type" : typeName,
                                                        @"community_name" : name,
                                                        @"city" : city,
                                                        @"place_school" : school,
                                                        @"community_classify" : categoryName,
                                                        @"logo_rsurl" : self.avatar_rsurl,
                                                        @"community_intro" : intro,
                                                        @"link_name" : contact,
                                                        @"phone" : phone} completion:^(id results) {
                
                if ([results boolValue]) {
                    MGLevelUpgradeSuccessVC *vc = [MGLevelUpgradeSuccessVC new];
                    vc.titleString = @"升级为社团";
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

#pragma mark - 选择弹窗
- (void)showAlertWithType:(NSInteger)type targetView:(UILabel *)targView {
    [self showAlertWithType:type targetView:targView array:nil];
}
- (void)showAlertWithType:(NSInteger)type targetView:(UILabel *)targView array:(NSArray *)targetArray {
    NSString *title = nil;
    NSArray *array = targetArray ?: @[];
    NSString *keyName = [NSString stringWithFormat:@"add_lesson_key_type_%zd",type];
    
    switch (type) {
        case 0:
            title = @"选择社团类型";
            array = self.typeSelectArray;
            break;
        case 1:
            title = @"选择社团分类";
            array = self.categorySelectArray;
            break;
            
    }
    
    
    if([TDCommonTool archiveWithModel:array keyName:keyName]){
        DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:nil message:@"" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
        [alertView setAlertThemeMessageTip_TwoButton];
        NSMutableArray *resultArray = [alertView setThemeTableViewToSelectedItemWithTitle:title dataArray:[TDCommonTool getArchiveWithKeyName:keyName]];
        alertView.otherButtonAction = ^{
            DQAlertSelectedModel *selectedResult = nil;
            for (DQAlertSelectedModel *model in resultArray) {
                if (model.isSelected) {
                    selectedResult = model;
                    break;
                }
            }
            for (DQAlertSelectedModel *model in array) {
                model.isSelected = NO;
                if ([model.title isEqualToString:selectedResult.title]) {
                    /// 直接选中
                    model.isSelected = YES;
                    targView.text = model.title;
                }
            }
            
            
        };
        alertView.delegate = self;
        [alertView show];
    };
    
}


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
