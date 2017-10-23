//
//  MGUpgradeStudentVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/21.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGUpgradeStudentVC.h"
#import "MGMineSettingView.h"
#import "TDSelectPhotoView.h"
#import "PPPhotoTaker.h"
#import "SDPhotoBrowser.h"
#import "MGLevelUpgradeSuccessVC.h"


@interface MGUpgradeStudentVC ()<SDPhotoBrowserDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;


/// 学生昵称
@property (nonatomic, strong) MGMineSettingView *nameSettingView;
@property (nonatomic, strong) UITextField *nameTextField;

/// 学校昵称
@property (nonatomic, strong) MGMineSettingView *schoolNameSettingView;
@property (nonatomic, strong) UITextField *schoolNameTextField;

/// 专业
@property (nonatomic, strong) MGMineSettingView *professSettingView;
@property (nonatomic, strong) UITextField *professTextField;

/// 头像
@property (nonatomic, strong) MGMineSettingView *iconView;
/// url
@property (nonatomic, copy) NSString *avatar_rsurl;
/// 相片
@property (nonatomic, strong) TDSelectPhotoView *photoView;


/// 提交按钮
@property (nonatomic, strong) UIButton *submitButton;
/// 提交提示
@property (nonatomic, strong) UILabel *bottomTipLabel;


@end

@implementation MGUpgradeStudentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"验证您的学生身份";
    WEAK
    CGFloat submitButtonTop = kScreenHeight - SH(84) - SH(36) - SH(26) - PFSC(28).lineHeight;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, submitButtonTop - 64)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    
    _nameSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, MineSettingViewHeight)];
    _nameSettingView.titleLabel.text = @"真实姓名 : ";
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _nameTextField.delegate = self;
    _nameTextField.font = PFSC(28);
    _nameTextField.placeholder = @"请输入真实姓名";
    _nameTextField.textAlignment = NSTextAlignmentRight;
    _nameSettingView.customSubView = _nameTextField;
    [_nameSettingView setArrowImageHidden];
    
    
    _schoolNameSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _nameTextField.bottom, kScreenWidth, MineSettingViewHeight)];
    _schoolNameSettingView.titleLabel.text = @"学校名称 : ";
    _schoolNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _schoolNameTextField.delegate = self;
    _schoolNameTextField.font = PFSC(28);
    _schoolNameTextField.placeholder = @"请输入学校名称";
    _schoolNameTextField.textAlignment = NSTextAlignmentRight;
    _schoolNameSettingView.customSubView = _schoolNameTextField;
    [_schoolNameSettingView setArrowImageHidden];
    
    
    _professSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _schoolNameSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _professSettingView.titleLabel.text = @"所学专业 : ";
    _professTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _professTextField.delegate = self;
    _professTextField.font = PFSC(28);
    _professTextField.placeholder = @"请输入所学专业";
    _professTextField.textAlignment = NSTextAlignmentRight;
    _professSettingView.customSubView = _professTextField;
    [_professSettingView setArrowImageHidden];
    
    
    _iconView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _professSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _iconView.titleLabel.text = @"学生证照片 : ";
    _iconView.subTitlelabel.text = @"点击上传图片或拍照";
    _iconView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundTap];
    };
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - SW(80), 0, SW(80), SW(80))];
    iconImageView.centerY = _iconView.height * 0.5;
    iconImageView.layer.cornerRadius = SW(40);
    iconImageView.layer.masksToBounds = YES;
    iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    _iconView.customSubView = iconImageView;
    _iconView.subTitlelabel.hidden = NO;
    _iconView.subTitlelabel.textColor = MGThemeColor_Placeholder_Black;
    _iconView.customSubView.hidden = YES;
    [self changeIconImage];
    
    
    [_scrollView sd_addSubviews:@[_nameSettingView, _schoolNameSettingView, _professSettingView, _iconView]];
    
    
    _scrollView.contentSize = CGSizeMake(0, _iconView.bottom);
    
    _submitButton = [MGUITool buttonWithBGColor:nil title:@"提交认证" titleColor: MGThemeColor_Title_Black font:MGThemeFont_36 target:self selector:@selector(submitButtonOnClick)];
    _submitButton.frame = CGRectMake(SW(75), submitButtonTop, SW(600), SH(84));
    [_submitButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_submitButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    _submitButton.layer.masksToBounds = YES;
    _submitButton.layer.cornerRadius = MGButtonLayerCorner;
    
    
    _bottomTipLabel = [MGUITool labelWithText:@"所有信息讲受平台加密保存" textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _bottomTipLabel.textAlignment = NSTextAlignmentCenter;
    _bottomTipLabel.frame = CGRectMake(0, kScreenHeight - PFSC(28).lineHeight - SH(26), kScreenWidth, PFSC(28).lineHeight);
    
    [self.view sd_addSubviews:@[_scrollView, _bottomTipLabel, _submitButton]];
    
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

/// 提交
- (void)submitButtonOnClick {
    
    DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:nil message:@"您确定要提交吗？" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    [alertView setAlertThemeMessageTip_TwoButton];
    WEAK
    alertView.otherButtonAction = ^{
        STRONG
        NSString *name = _nameTextField.text;
        NSString *school = _schoolNameTextField.text;
        NSString *profress = _professTextField.text;
        
        NSMutableString *resultString = @"".mutableCopy;
        
        if (name.length == 0) {
            [resultString appendString:@"请输入真实姓名、"];
        }
        
        if (school.length == 0) {
            [resultString appendString:@"请输入学校名称、"];
        }
        if (profress.length == 0) {
            [resultString appendString:@"请输入所学专业、"];
        }
        if (self.avatar_rsurl.length == 0) {
            [resultString appendString:@"请上传学生证照片、"];
        }
        
        if (resultString.length > 0) {
            NSString *alertStr = [resultString substringToIndex:resultString.length - 1];
            DQAlertView *checkAlertView = [[DQAlertView alloc] initWithTitle:nil message:alertStr cancelButtonTitle:@"我知道了" otherButtonTitle:nil];
            [checkAlertView setAlertThemeMessageTip_OneButton];
            [checkAlertView show];
            return;
        } else { /// 提交数据
            
            [MGBussiness loadUpgradeWithType:0 params:@{@"name" : name, @"school_name" : school, @"major" : profress, @"student_card_photo_rsurl" : self.avatar_rsurl} completion:^(id results) {
                
                if ([results boolValue]) {
                    MGLevelUpgradeSuccessVC *vc = [MGLevelUpgradeSuccessVC new];
                    vc.titleString = @"验证您的学生身份";
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

#pragma mark - Getter and Setter


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
                
                [PPPhotoTaker getPictureFromCemeraNeedEditing:NO needSaveInLibrary:YES finishBlock:^(UIImage *image) {
                    STRONG
                    [self uploadIconImageWithImage:image];
                }];
                
            } else if (type == SelectPhotoViewTypeSelectPhoto) {
                [PPPhotoTaker getPictureFromLibraryNeedEditing:NO finishBlock:^(UIImage *image) {
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
        _iconView.subTitlelabel.hidden = YES;
        _iconView.customSubView.hidden = NO;
        
        UIImageView *iconImageView = (UIImageView *)(_iconView.customSubView);
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:self.avatar_rsurl] placeholderImage:SDWEB_PLACEHODER_IMAGE_ICON];
        
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

@end
