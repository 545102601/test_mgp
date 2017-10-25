//
//  MGMineInfoVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/24.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMineInfoVC.h"
#import "MGMineSettingView.h"
#import "MGMineInfoHeader.h"
#import "TDSelectPhotoView.h"
#import "PPPhotoTaker.h"
#import "SDPhotoBrowser.h"
#import "MGUpdateInfoVC.h"
#import "TDSelectDatePickerView.h"
#import "DQAlertView+SelectTableViewExtend.h"
#import "MGEResumeVC.h"
@interface MGMineInfoVC () <SDPhotoBrowserDelegate, TDSelectDatePickerViewDelegate>

/// 个人信息模型
@property (nonatomic, strong) MGResMemberDataModel *dataModel;

/// 内容
@property (nonatomic, strong) UIScrollView *contentScrollView;

/// 社交tip
@property (nonatomic, strong) UILabel *socialLabel;
/// 头像
@property (nonatomic, strong) MGMineSettingView *iconView;
/// 昵称
@property (nonatomic, strong) MGMineSettingView *nickNameView;
/// 签名
@property (nonatomic, strong) MGMineSettingView *signatrueView;

/// 基础信息tip
@property (nonatomic, strong) UILabel *baseLabel;
/// 名字
@property (nonatomic, strong) MGMineSettingView *nameView;
/// 性别
@property (nonatomic, strong) MGMineSettingView *sexView;
@property (nonatomic, copy) NSArray *sexSelectArray;


/// 生日
@property (nonatomic, strong) MGMineSettingView *birthdayView;

/// 学习tip
@property (nonatomic, strong) UILabel *schoolLabel;
/// 院校
@property (nonatomic, strong) MGMineSettingView *schoolView;
/// 专业
@property (nonatomic, strong) MGMineSettingView *professionView;
/// 入学
@property (nonatomic, strong) MGMineSettingView *jionSchoolView;

/// 简历tip
@property (nonatomic, strong) UILabel *jianLiLabel;
/// 项目经验
@property (nonatomic, strong) MGMineSettingView *projectView;
/// 工作/实习经历
@property (nonatomic, strong) MGMineSettingView *workView;
/// 电子简历
@property (nonatomic, strong) MGMineSettingView *jianLiView;
/// 自我评价
@property (nonatomic, strong) MGMineSettingView *commentView;

/// 联系方式
@property (nonatomic, strong) UILabel *contactLabel;
/// QQ
@property (nonatomic, strong) MGMineSettingView *qqView;
/// 微信
@property (nonatomic, strong) MGMineSettingView *WeChatView;
/// 手机号码
@property (nonatomic, strong) MGMineSettingView *phoneView;
/// 邮箱
@property (nonatomic, strong) MGMineSettingView *eMailView;

/// 选择相片
@property (nonatomic, strong) TDSelectPhotoView *photoView;

/// 时间选择器
@property (nonatomic, strong) TDSelectDatePickerView *datePickerView;


@end

@implementation MGMineInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人资料";
    
}

- (void)initData {
    _dataModel = memberDataModelInstance;
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    _contentScrollView.showsVerticalScrollIndicator = NO;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    WEAK
    /// 社交信息
    _socialLabel = [MGUITool labelWithText:@"社交信息" textColor:colorHex(@"#5e5b59") font:PFSC(30)];
    _socialLabel.frame = CGRectMake(SW(30), 0, kScreenWidth, _socialLabel.fontLineHeight);
    _socialLabel.centerY = SH(45);
    
    _iconView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, SH(90), kScreenWidth, MineSettingViewHeight)];
    _iconView.titleLabel.text = @"头像 : ";
    _iconView.subTitlelabel.text = @"点击修改";
    _iconView.tag = MineInfoTagTypeIcon;
    _iconView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundTapWithTag:tag];
    };
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - SW(80), 0, SW(80), SW(80))];
    iconImageView.centerY = _iconView.height * 0.5;
    iconImageView.layer.cornerRadius = SW(40);
    iconImageView.layer.masksToBounds = YES;
    iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    _iconView.customSubView = iconImageView;
    _iconView.subTitlelabel.hidden = NO;
    _iconView.customSubView.hidden = YES;
    [self changeIconImage];
    
    _nickNameView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _iconView.bottom, kScreenWidth, MineSettingViewHeight)];
    _nickNameView.titleLabel.text = @"昵称 : ";
    _nickNameView.subTitlelabel.text = memberDataModelInstance.nick_name;
    _nickNameView.subTitlelabel.textColor = MGThemeColor_Title_Black;
    _nickNameView.tag = MineInfoTagTypeNickName;
    _nickNameView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundTapWithTag:tag];
    };

    
    
    _signatrueView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _nickNameView.bottom, kScreenWidth, MineSettingViewHeight)];
    _signatrueView.titleLabel.text = @"签名 : ";
    _signatrueView.subTitlelabel.text = memberDataModelInstance.my_signature;
    _signatrueView.subTitlelabel.textColor = MGThemeColor_Title_Black;
    [_signatrueView setBottomLineHidden];
    _signatrueView.tag = MineInfoTagTypeSinagtrue;
    _signatrueView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundTapWithTag:tag];
    };

    
    
    /// 基本信息
    _baseLabel = [MGUITool labelWithText:@"基本信息" textColor:colorHex(@"#5e5b59") font:PFSC(30)];
    _baseLabel.frame = CGRectMake(SW(30), 0, kScreenWidth, _baseLabel.fontLineHeight);
    _baseLabel.centerY = _signatrueView.bottom + SH(45);
    
    _nameView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _signatrueView.bottom + SH(90), kScreenWidth, MineSettingViewHeight)];
    _nameView.titleLabel.text = @"姓名 : ";
    _nameView.subTitlelabel.text = memberDataModelInstance.name;
    _nameView.subTitlelabel.textColor = MGThemeColor_Title_Black;
    _nameView.tag = MineInfoTagTypeName;
    _nameView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundTapWithTag:tag];
    };

    
    _sexView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _nameView.bottom, kScreenWidth, MineSettingViewHeight)];
    _sexView.titleLabel.text = @"性别 : ";
    _sexView.subTitlelabel.text = memberDataModelInstance.gender_label;
    _sexView.subTitlelabel.textColor = MGThemeColor_Title_Black;
    _sexView.tag = MineInfoTagTypeSex;
    _sexView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundTapWithTag:tag];
    };

    
    
    _birthdayView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _sexView.bottom, kScreenWidth, MineSettingViewHeight)];
    _birthdayView.titleLabel.text = @"生日 : ";
    
    if (memberDataModelInstance.birthday) {
        _birthdayView.subTitlelabel.text = [memberDataModelInstance.birthday formattedStringWithFormat:@"yyyy-MM-dd"];
    }
    _birthdayView.subTitlelabel.textColor = MGThemeColor_Title_Black;
    [_birthdayView setBottomLineHidden];
    _birthdayView.tag = MineInfoTagTypeBirthday;
    _birthdayView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundTapWithTag:tag];
    };

    
    
    /// 学校信息
    _schoolLabel = [MGUITool labelWithText:@"学校信息" textColor:colorHex(@"#5e5b59") font:PFSC(30)];
    _schoolLabel.frame = CGRectMake(SW(30), 0, kScreenWidth, _schoolLabel.fontLineHeight);
    _schoolLabel.centerY = _birthdayView.bottom + SH(45);
    
    _schoolView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _birthdayView.bottom + SH(90), kScreenWidth, MineSettingViewHeight)];
    _schoolView.titleLabel.text = @"院校 : ";
    _schoolView.subTitlelabel.text = memberDataModelInstance.college;
    _schoolView.subTitlelabel.textColor = MGThemeColor_Title_Black;
    _schoolView.tag = MineInfoTagTypeSchool;
    _schoolView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundTapWithTag:tag];
    };

    
    _professionView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _schoolView.bottom, kScreenWidth, MineSettingViewHeight)];
    _professionView.titleLabel.text = @"专业 : ";
    _professionView.subTitlelabel.text = memberDataModelInstance.profession;
    _professionView.subTitlelabel.textColor = MGThemeColor_Title_Black;
    _professionView.tag = MineInfoTagTypeProfession;
    _professionView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundTapWithTag:tag];
    };

    
    _jionSchoolView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _professionView.bottom, kScreenWidth, MineSettingViewHeight)];
    _jionSchoolView.titleLabel.text = @"入学年份 : ";
    _jionSchoolView.subTitlelabel.text = memberDataModelInstance.enter_school;
    _jionSchoolView.subTitlelabel.textColor = MGThemeColor_Title_Black;
    [_jionSchoolView setBottomLineHidden];
    _jionSchoolView.tag = MineInfoTagTypeJoinSchool;
    _jionSchoolView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundTapWithTag:tag];
    };

    
    /// 简历相关
    _jianLiLabel = [MGUITool labelWithText:@"简历相关" textColor:colorHex(@"#5e5b59") font:PFSC(30)];
    _jianLiLabel.frame = CGRectMake(SW(30), 0, kScreenWidth, _jianLiLabel.fontLineHeight);
    _jianLiLabel.centerY = _jionSchoolView.bottom + SH(45);
    
    _projectView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _jionSchoolView.bottom + SH(90), kScreenWidth, MineSettingViewHeight)];
    _projectView.titleLabel.text = @"项目经验 : ";
    _projectView.subTitlelabel.text = memberDataModelInstance.project_experience;
    _projectView.subTitlelabel.textColor = MGThemeColor_Title_Black;
    _projectView.tag = MineInfoTagTypeProject;
    _projectView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundTapWithTag:tag];
    };

    
    _workView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _projectView.bottom, kScreenWidth, MineSettingViewHeight)];
    _workView.titleLabel.text = @"工作/实习经历 : ";
    _workView.subTitlelabel.text = memberDataModelInstance.work_experience;
    _workView.subTitlelabel.textColor = MGThemeColor_Title_Black;
    _workView.tag = MineInfoTagTypeWork;
    _workView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundTapWithTag:tag];
    };

    
    
    _jianLiView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _workView.bottom, kScreenWidth, MineSettingViewHeight)];
    _jianLiView.titleLabel.text = @"电子版简历 : ";
    _jianLiView.subTitlelabel.text = @"";
    _jianLiView.subTitlelabel.textColor = MGThemeColor_Title_Black;
    _jianLiView.tag = MineInfoTagTypeJianLi;
    _jianLiView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundTapWithTag:tag];
    };

    
    _commentView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _jianLiView.bottom, kScreenWidth, MineSettingViewHeight)];
    _commentView.titleLabel.text = @"自我评价 : ";
    _commentView.subTitlelabel.text = memberDataModelInstance.self_evaluation;
    _commentView.subTitlelabel.textColor = MGThemeColor_Title_Black;
    [_commentView setBottomLineHidden];
    _commentView.tag = MineInfoTagTypeComment;
    _commentView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundTapWithTag:tag];
    };

    
    
    /// 联系方式
    _contactLabel = [MGUITool labelWithText:@"联系方式" textColor:colorHex(@"#5e5b59") font:PFSC(30)];
    _contactLabel.frame = CGRectMake(SW(30), 0, kScreenWidth, _contactLabel.fontLineHeight);
    _contactLabel.centerY = _commentView.bottom + SH(45);
    
    _qqView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _commentView.bottom + SH(90), kScreenWidth, MineSettingViewHeight)];
    _qqView.titleLabel.text = @"QQ : ";
    _qqView.subTitlelabel.text = memberDataModelInstance.qq;
    _qqView.subTitlelabel.textColor = MGThemeColor_Title_Black;
    _qqView.tag = MineInfoTagTypeQQ;
    _qqView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundTapWithTag:tag];
    };

    
    _WeChatView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _qqView.bottom, kScreenWidth, MineSettingViewHeight)];
    _WeChatView.titleLabel.text = @"微信 : ";
    _WeChatView.subTitlelabel.text = memberDataModelInstance.weixin;
    _WeChatView.subTitlelabel.textColor = MGThemeColor_Title_Black;
    _WeChatView.tag = MineInfoTagTypeWeChat;
    _WeChatView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundTapWithTag:tag];
    };

    
    
    _phoneView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _WeChatView.bottom, kScreenWidth, MineSettingViewHeight)];
    _phoneView.titleLabel.text = @"手机号码 : ";
    _phoneView.subTitlelabel.text = memberDataModelInstance.mobile;
    _phoneView.subTitlelabel.textColor = MGThemeColor_Title_Black;
    _phoneView.tag = MineInfoTagTypePhone;
//    _phoneView.backgroundTapWithTagBlock = ^(NSInteger tag) {
//        STRONG
//        [self backgroundTapWithTag:tag];
//    };
    [_phoneView setArrowImageHidden];
    
    _eMailView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _phoneView.bottom, kScreenWidth, MineSettingViewHeight)];
    _eMailView.titleLabel.text = @"邮箱 : ";
    _eMailView.subTitlelabel.text = memberDataModelInstance.email;
    _eMailView.subTitlelabel.textColor = MGThemeColor_Title_Black;
    [_eMailView setBottomLineHidden];
    _eMailView.tag = MineInfoTagTypeEMail;
    _eMailView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self backgroundTapWithTag:tag];
    };
    
    
    [_contentScrollView sd_addSubviews:@[_socialLabel, _iconView, _nickNameView, _signatrueView]];
    
    [_contentScrollView sd_addSubviews:@[_baseLabel, _nameView, _sexView, _birthdayView]];
    
    [_contentScrollView sd_addSubviews:@[_schoolLabel, _schoolView, _professionView, _jionSchoolView]];
    
    [_contentScrollView sd_addSubviews:@[_jianLiLabel, _projectView, _workView, _jianLiView, _commentView]];
    
    [_contentScrollView sd_addSubviews:@[_contactLabel, _qqView, _WeChatView, _phoneView, _eMailView]];
    
    _contentScrollView.contentSize = CGSizeMake(0, _eMailView.bottom);
    [self.view addSubview:_contentScrollView];
    
}

#pragma mark - 加载数据
- (void)loadData {

}


- (void)backgroundTapWithTag:(MineInfoTagType)type {
    
    switch (type) {
        case MineInfoTagTypeIcon :
        {
            [self.photoView setBottomTtitleWithString:self.dataModel.avatar_rsurl.length > 0 ? @"查看" : @"取消"];
            [self.photoView showSelectPhotoWithAnimated:YES inView:KeyWindow];
        }
            break;
        case MineInfoTagTypeNickName :
        {
            [self updateVCWithType:type];
        }
            break;
        case MineInfoTagTypeSinagtrue :
        {
             [self updateVCWithType:type];
        }
            break;
        case MineInfoTagTypeName :
        {
             [self updateVCWithType:type];
        }
            break;
        case MineInfoTagTypeSex :
        {
            
            [self showAlertWithType:0 targetView:_sexView.subTitlelabel];
            
        }
            break;
        case MineInfoTagTypeBirthday :
        {
            self.datePickerView.tag = 100234;
            [self.datePickerView showSelectDatePickViewWithAnimated:YES inView:self.view];
        }
            break;
        case MineInfoTagTypeSchool :
        {
             [self updateVCWithType:type];
        }
            break;
        case MineInfoTagTypeProfession :
        {
             [self updateVCWithType:type];
        }
            break;
        case MineInfoTagTypeJoinSchool :
        {
            
            self.datePickerView.tag = 100235;
            [self.datePickerView showSelectDatePickViewWithAnimated:YES inView:self.view];
        }
            break;
        case MineInfoTagTypeProject :
        {
             [self updateVCWithType:type];
        }
            break;
        case MineInfoTagTypeWork :
        {
             [self updateVCWithType:type];
        }
            break;
        case MineInfoTagTypeJianLi :
        {
            MGEResumeVC *vc = [MGEResumeVC new];
            vc.resumeUrl = memberDataModelInstance.resume_rsurl;
            PushVC(vc)
        }
            break;
        case MineInfoTagTypeComment :
        {
             [self updateVCWithType:type];
        }
            break;
        case MineInfoTagTypeQQ :
        {
             [self updateVCWithType:type];
        }
            
            break;
        case MineInfoTagTypeWeChat :
        {
             [self updateVCWithType:type];
        }
            break;
        case MineInfoTagTypePhone :
        {
             [self updateVCWithType:type];
        }
            break;
        case MineInfoTagTypeEMail :
        {
             [self updateVCWithType:type];
        }
            break;
    }
    
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

- (void)selectDatePickerView:(TDSelectDatePickerView *)pickerView didSureButtonOnClick:(NSDate *)date {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [formatter stringFromDate:date];
    
    
    if (pickerView.tag == 100234) { /// 生日
        [MGBussiness updateMemeberInfiWithPamras:@{@"gender" : @(memberDataModelInstance.gender), @"nick_name" : memberDataModelInstance.nick_name,@"birthday" : dateString} completion:^(id results) {
            if ([results boolValue]) {
                MGMineSettingView *settingView = [self.view viewWithTag:MineInfoTagTypeBirthday];
                settingView.subTitlelabel.text = dateString;
                [memberDataModelInstance setValue:date forKey:@"birthday"];
                [[NSNotificationCenter defaultCenter] postNotificationName:MineReloadRefreshView object:nil];
            }
            
        } error:nil];

    } else if (pickerView.tag == 100235){ /// 入学年份
        [MGBussiness updateMemeberInfiWithPamras:@{@"gender" : @(memberDataModelInstance.gender), @"nick_name" : memberDataModelInstance.nick_name,@"enter_school" : dateString} completion:^(id results) {
            if ([results boolValue]) {
                MGMineSettingView *settingView = [self.view viewWithTag:MineInfoTagTypeJoinSchool];
                settingView.subTitlelabel.text = dateString;
                [memberDataModelInstance setValue:dateString forKey:@"enter_school"];
                [[NSNotificationCenter defaultCenter] postNotificationName:MineReloadRefreshView object:nil];
            }
            
        } error:nil];

    }
    [self.datePickerView hideSelectDatePickViewWithAnimated:YES inView:self.view];
    
    
}

#pragma mark - Public Function

#pragma mark - Private Function

- (void)updateVCWithType:(NSInteger)type {
    MGMineSettingView *settingView = [self.view viewWithTag:type];
    
    MGUpdateInfoVC *vc = [MGUpdateInfoVC new];
    vc.type = type;
    vc.contentString = settingView.subTitlelabel.text;
    
    
    vc.completionBlock = ^(NSString *key, NSString *value){
        
        /// 是否是nick_name
        BOOL isnick_name = [key isEqualToString:@"nick_name"];
        
        [MGBussiness updateMemeberInfiWithPamras:@{@"gender" : @(memberDataModelInstance.gender), @"nick_name" : isnick_name ? value : memberDataModelInstance.nick_name,key : value} completion:^(id results) {
            if ([results boolValue]) {
                settingView.subTitlelabel.text = value;
                [memberDataModelInstance setValue:value forKey:key];
                [[NSNotificationCenter defaultCenter] postNotificationName:MineReloadRefreshView object:nil];
            }
            
        } error:nil];
        
    };
    
    
    MGNavigationController *nav = [[MGNavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nav animated:YES completion:nil];
    
    
    
    
}


#pragma mark - Getter and Setter


- (TDSelectDatePickerView *)datePickerView {
    if (!_datePickerView) {
        _datePickerView = [[TDSelectDatePickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _datePickerView.delegate = self;
        [KeyWindow addSubview:_datePickerView];
    }
    return _datePickerView;
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
                if (self.dataModel.avatar_rsurl.length > 0) {
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
    [MGBussiness uploadIconImageWithImage:image gender:self.dataModel.gender nickName:self.dataModel.nick_name entity_id:self.dataModel.id completion:^(NSDictionary  *results) {
        if ([results[@"success"] boolValue]) {
            self.dataModel.avatar_rsurl = results[@"url"];
            [self changeIconImage];
            
        }
    } error:nil];
}

- (void)changeIconImage {
    
    if (self.dataModel.avatar_rsurl.length > 0) {
        _iconView.subTitlelabel.hidden = YES;
        _iconView.customSubView.hidden = NO;
        
        UIImageView *iconImageView = (UIImageView *)(_iconView.customSubView);
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:self.dataModel.avatar_rsurl scaleWidth:iconImageView.width] placeholderImage:SDWEB_PLACEHODER_IMAGE_ICON];
        
        /// 发送刷新我的页面通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MineReloadRefreshView object:nil];
        
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
    return [NSURL URLWithString:self.dataModel.avatar_rsurl scaleWidth:kScreenWidth];
}


- (NSArray *)sexSelectArray {
    if (!_sexSelectArray) {
        
        DQAlertSelectedModel *model1 = [DQAlertSelectedModel new];
        model1.isSelected = memberDataModelInstance.gender == 1 ? YES : NO;
        model1.title = @"男";
        DQAlertSelectedModel *model2 = [DQAlertSelectedModel new];
        model2.title = @"女";
        model2.isSelected = memberDataModelInstance.gender == 0 ? YES : NO;
        
        _sexSelectArray = @[model1, model2];
    }
    return _sexSelectArray;
}






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
            title = @"选择性别";
            array = self.sexSelectArray;
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
               
                
                if ([model.title isEqualToString:selectedResult.title]) {
                    
                    NSInteger index = [model.title isEqualToString:@"男"] ? 1 : 0;
                    if(memberDataModelInstance.gender == index) {
                        /// 取消全部
                        for (DQAlertSelectedModel *model in array) {
                            model.isSelected = NO;
                        }
                        /// 直接选中
                        model.isSelected = YES;
                        
                        return;
                    };
                    
                    [MGBussiness updateMemeberInfiWithPamras:@{@"gender" : @(index), @"nick_name" : memberDataModelInstance.nick_name} completion:^(id results) {
                        if ([results boolValue]) {
                            /// 取消全部
                            for (DQAlertSelectedModel *model in array) {
                                model.isSelected = NO;
                            }
                            /// 直接选中
                            model.isSelected = YES;
                            
                            targView.text = model.title;
                            memberDataModelInstance.gender = index;
                            memberDataModelInstance.gender_label = model.title;
                            [[NSNotificationCenter defaultCenter] postNotificationName:MineReloadRefreshView object:nil];
                        }
                        
                    } error:nil];
                    
                    
                    }
            }
        };
        [alertView show];
    };
    
}


@end
