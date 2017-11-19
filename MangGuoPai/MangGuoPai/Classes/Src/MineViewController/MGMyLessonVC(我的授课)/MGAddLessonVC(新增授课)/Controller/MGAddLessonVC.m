//
//  MGAddLessonVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/1.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGAddLessonVC.h"
#import "MGMineSettingView.h"
#import "UITextView+Placeholder.h"
#import "BaseCollectionViewCell.h"
#import "PPPhotoTaker.h"
#import "SDPhotoBrowser.h"
#import "TDSelectPhotoView.h"
#import <YYText.h>
#import "DQAlertView+SelectTableViewExtend.h"
#import "MGResCourseTypeListModel.h"
#import "MGResClassifyModel.h"
#import "MGTeacherDetailVC.h"
#import "MGUploadCollectionViewCell.h"
#import "MGCommonWKWebViewVC.h"
#import "MGMyLessonVC.h"


@interface MGAddLessonVC () <UITextFieldDelegate, UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, SDPhotoBrowserDelegate, DQAlertViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) TDSelectPhotoView *photoView;

/// 课程标题
@property (nonatomic, strong) MGMineSettingView *courseTitleSettingView;
@property (nonatomic, strong) UITextField *courseTitleTextField;

/// 课程分类
@property (nonatomic, strong) MGMineSettingView *courseCategorySettingView;

/// 课程类型
@property (nonatomic, strong) MGMineSettingView *courseTypeSettingView;


/// 课程价格
@property (nonatomic, strong) MGMineSettingView *coursePriceSettingView;

/// 服务时长
@property (nonatomic, strong) MGMineSettingView *courseServiceSettingView;
@property (nonatomic, strong) UILabel *timesLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel *numberLabel;


/// 具体内容
@property (nonatomic, strong) UIView *courseContentBgView;
@property (nonatomic, strong) UITextView *courseContentTextView;

/// 相关资料
@property (nonatomic, strong) UIView *infoBgView;
@property (nonatomic, strong) UICollectionView *colletionView;
@property (nonatomic, strong) UIView *infoLineView;

/// 底部提示
@property (nonatomic, strong) UILabel *bottomTipLabel;

/// 保存
@property (nonatomic, strong) UIButton *saveButton;

/// 相册URL数组
@property (nonatomic, strong) NSMutableArray *dataArrayM;
/// 课程分类数组
@property (nonatomic, strong) NSMutableArray *categorySelectArray;
/// 课程类型数组
@property (nonatomic, strong) NSMutableArray *typeListSelectArray; /// 筛选

/// 每次 数组
@property (nonatomic, copy) NSArray *timesArray;
/// 每次约小时 素组
@property (nonatomic, copy) NSArray *timesHourArray;
@end

@implementation MGAddLessonVC

- (void)initData {
    _categorySelectArray = @[].mutableCopy;
    _typeListSelectArray = @[].mutableCopy;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.lessonType == MGAddLessonTypeAdd ? @"新建课程" : @"修改课程";
    
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    WEAK
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    _courseTitleSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, MineSettingViewHeight)];
    _courseTitleSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"课程标题 : " attr:@{NSFontAttributeName : _courseTitleSettingView.titleLabel.font, NSForegroundColorAttributeName : _courseTitleSettingView.titleLabel.textColor}];
    
    _courseTitleTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - SW(30) - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    _courseTitleTextField.delegate = self;
    _courseTitleTextField.textColor = MGThemeColor_Common_Black;
    _courseTitleTextField.font = PFSC(28);
    _courseTitleTextField.placeholder = @"请输入简洁、生动的课程标题";
    _courseTitleTextField.textAlignment = NSTextAlignmentRight;
    _courseTitleSettingView.customSubView = _courseTitleTextField;
    [_courseTitleSettingView setArrowImageHidden];

    
    
    _courseCategorySettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _courseTitleSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _courseCategorySettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"课程分类 : " attr:@{NSFontAttributeName : _courseCategorySettingView.titleLabel.font, NSForegroundColorAttributeName : _courseCategorySettingView.titleLabel.textColor}];
    _courseCategorySettingView.subTitlelabel.text = @"请选择";
    _courseCategorySettingView.tag = 1000;
    _courseCategorySettingView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self showAlertWithType:0 targetView:self.courseCategorySettingView.subTitlelabel];
    };
    
    _courseTypeSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _courseCategorySettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _courseTypeSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"课程类型 : " attr:@{NSFontAttributeName : _courseTypeSettingView.titleLabel.font, NSForegroundColorAttributeName : _courseTypeSettingView.titleLabel.textColor}];
    _courseTypeSettingView.subTitlelabel.text = @"请选择";
    _courseTypeSettingView.tag = 1000;
    _courseTypeSettingView.backgroundTapWithTagBlock = ^(NSInteger tag) {
        STRONG
        [self showAlertWithType:2 targetView:self.courseTypeSettingView.subTitlelabel];
    };
    
    _coursePriceSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _courseTypeSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _coursePriceSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"课程价格 : " attr:@{NSFontAttributeName : _coursePriceSettingView.titleLabel.font, NSForegroundColorAttributeName : _coursePriceSettingView.titleLabel.textColor}];
    _coursePriceSettingView.subTitlelabel.text = @"选择课程类型后自动生成";
    
    [_coursePriceSettingView setArrowImageHidden];
    
    
    _courseServiceSettingView = [[MGMineSettingView alloc] initWithFrame:CGRectMake(0, _coursePriceSettingView.bottom, kScreenWidth, MineSettingViewHeight)];
    _courseServiceSettingView.titleLabel.attributedText = [MGTool lastRedColorWithString:@"服务时长 : " attr:@{NSFontAttributeName : _courseServiceSettingView.titleLabel.font, NSForegroundColorAttributeName : _courseServiceSettingView.titleLabel.textColor}];
    UIView *serviceBgView = [[UIView alloc] initWithFrame:CGRectMake(_courseServiceSettingView.arrowImageView.left - kScreenWidth * 0.5, 0, kScreenWidth * 0.5, MineSettingViewHeight)];
    
    _timesLabel = [MGUITool labelWithText:@"每次约13小时" textColor:MGThemeColor_Common_Black font:PFSC(28)];
    [_timesLabel sizeToFit];
    _timesLabel.text = @"每次约1小时";
    _timesLabel.right = serviceBgView.width;
    _timesLabel.centerY = serviceBgView.height * 0.5;
    _timesLabel.userInteractionEnabled = YES;
    [_timesLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timesLabelTapOnClick)]];
    
    _arrowImageView = [[UIImageView alloc] init];
    _arrowImageView.image = [UIImage imageNamed:@"mine_more_2"];
    _arrowImageView.frame = CGRectMake(_timesLabel.left - SW(52), 0, SW(44), SW(44));
    _arrowImageView.centerY = serviceBgView.height * 0.5;
    
    
    _numberLabel = [MGUITool labelWithText:@"一次" textColor:MGThemeColor_Common_Black font:PFSC(28)];
    [_numberLabel sizeToFit];
    _numberLabel.right = _arrowImageView.left - SW(8);
    _numberLabel.centerY = serviceBgView.height * 0.5;
    _numberLabel.userInteractionEnabled = YES;
    [_numberLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(numberLabelTapOnClick)]];
    [serviceBgView sd_addSubviews:@[_timesLabel, _arrowImageView, _numberLabel]];
    _courseServiceSettingView.customSubView = serviceBgView;
    
    
    _courseContentBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _courseServiceSettingView.bottom, kScreenWidth, 0)];
    
    UILabel *courseContentTipLabel = [MGUITool labelWithText:@"具体内容 : " textColor:MGThemeColor_Title_Black font:PFSC(28)];
    courseContentTipLabel.frame = CGRectMake(SW(30), SH(30), kScreenWidth * 0.5, courseContentTipLabel.fontLineHeight);
    
    
    _courseContentTextView = [[UITextView alloc] initWithFrame:CGRectMake(SW(30),courseContentTipLabel.bottom + SH(30), kScreenWidth - SW(60), SH(180))];
    _courseContentTextView.font = PFSC(28);
    _courseContentTextView.placeholder = @"请输入内容";
//    _courseContentTextView.textContainerInset = UIEdgeInsetsMake(SW(26), SW(26), SW(26), SW(26));
    _courseContentTextView.layer.borderColor = MGSepColor.CGColor;
    _courseContentTextView.layer.borderWidth = MGSepLineHeight;
    _courseContentTextView.textColor = MGThemeColor_Common_Black;
    _courseContentTextView.delegate = self;
    
    UIView *courseContentLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(30), _courseContentTextView.bottom + SH(30), kScreenWidth - SW(60), MGSepLineHeight)];
    courseContentLineView.backgroundColor = MGSepColor;
    
    /// 设置父类frame
    _courseContentBgView.height = courseContentLineView.bottom;
    _courseContentBgView.backgroundColor = [UIColor whiteColor];
    [_courseContentBgView sd_addSubviews:@[courseContentTipLabel, courseContentLineView, _courseContentTextView]];
    
    
    _infoBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _courseContentBgView.bottom, kScreenWidth, 0)];
    
    UILabel *infoTipLabel = [MGUITool labelWithText:@"相关资料和附件 : " textColor:MGThemeColor_Title_Black font:PFSC(28)];
    infoTipLabel.frame = CGRectMake(SW(30), SH(30), kScreenWidth * 0.5, infoTipLabel.fontLineHeight);
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    CGFloat itemWidth = [MGUploadCollectionViewCell getItemWidth];
    
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    layout.minimumLineSpacing = SW(21);
    layout.minimumInteritemSpacing = SW(21);
    layout.sectionInset = UIEdgeInsetsMake(SW(21), SW(60), SH(30), SW(60));
    
    _colletionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, infoTipLabel.bottom, kScreenWidth, itemWidth + SW(21)) collectionViewLayout:layout];
    _colletionView.backgroundColor = [UIColor whiteColor];
    _colletionView.delegate = self;
    _colletionView.dataSource = self;
    _colletionView.scrollEnabled = NO;
    [_colletionView registerClass:[MGUploadCollectionViewCell class] forCellWithReuseIdentifier:@"MGUploadCollectionViewCellID"];
    
    
    _infoLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(30), _colletionView.bottom + SH(30), kScreenWidth - SW(60), MGSepLineHeight)];
    _infoLineView.backgroundColor = MGSepColor;
    
    _infoBgView.height = _infoLineView.bottom;
    
    [_infoBgView sd_addSubviews:@[infoTipLabel, _colletionView, _infoLineView]];
    
    
    _bottomTipLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28) textAlignment:NSTextAlignmentCenter];
    _bottomTipLabel.frame = CGRectMake(SW(30), _infoBgView.bottom + SH(30), kScreenWidth - SW(60), _bottomTipLabel.fontLineHeight * 2 + SH(20));
    NSString *bottomTipText = @"您也可以在PC端登录www.enjoymangopi.com , 使用\r\n电脑上传Word、PPT等文件";
    NSMutableAttributedString *ATTRS = [bottomTipText addLineSpaceWithfont:PFSC(28) lineSpace:SH(20) color:MGThemeColor_Common_Black];
    [ATTRS setYy_alignment:NSTextAlignmentCenter];
    _bottomTipLabel.attributedText = ATTRS;
    
    _saveButton = [MGUITool buttonWithBGColor:nil title:@"保存" titleColor:MGThemeColor_Title_Black font:MGThemeFont_28 target:self selector:@selector(saveButtonOnClick)];
    
    _saveButton.frame = CGRectMake(0, _bottomTipLabel.bottom + SH(50), SW(140), SH(60));
    _saveButton.centerX = kScreenWidth * 0.5;
    [_saveButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_saveButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    _saveButton.layer.masksToBounds = YES;
    _saveButton.layer.cornerRadius = MGButtonLayerCorner;
    
    [_scrollView sd_addSubviews:@[_courseTitleSettingView, _courseCategorySettingView,
                                  _courseTypeSettingView, _coursePriceSettingView,
                                  _courseServiceSettingView, _courseContentBgView,
                                  _infoBgView, _bottomTipLabel,
                                  _saveButton]];
    
    
    _scrollView.contentSize = CGSizeMake(kScreenWidth, _saveButton.bottom + SH(40));
    
    [self.view addSubview:_scrollView];
    
    
}

#pragma mark - 加载数据
- (void)loadData {
    
    _scrollView.hidden = YES;
    [TDLoading showViewInKeyWindow];
    [MGBussiness loadCourseCategoryDataWithCompletion:^(NSArray *categoryArray) {
        [MGBussiness loadCourseTypeListDataWithCompletion:^(NSArray *typeListArray) {
            [TDLoading hideViewInKeyWindow];
            _scrollView.hidden = NO;
            
            /// 组装分类类型数组
            for (MGResCourseTypeListDataModel *dataModel in typeListArray) {
                DQAlertSelectedModel *model = [DQAlertSelectedModel new];
                model.id = dataModel.id;
                model.title = [NSString stringWithFormat:@"%@(%@)",dataModel.type,dataModel.method];
                model.price = dataModel.sale_price;
                [self.typeListSelectArray addObject:model];
                
            }
            
            /// 组装分类类型数组
            for (MGResClassifyDataModel *dataModel in categoryArray) {
                DQAlertSelectedModel *model = [DQAlertSelectedModel new];
                model.id = dataModel.id;
                model.title = dataModel.classify_name;
                
                NSMutableArray *subModelArrayM = @[].mutableCopy;
                for (MGResClassifyDataModel *subDataModel in dataModel.details) {
                    DQAlertSelectedModel *subModel = [DQAlertSelectedModel new];
                    subModel.id = subDataModel.id;
                    subModel.title = subDataModel.classify_name;
                    subModel.parentId = subDataModel.parent_id;
                    [subModelArrayM addObject:subModel];
                }
                
                model.subArray = subModelArrayM;
                
                [self.categorySelectArray addObject:model];
                
            }
            
            /// 回显示数据
            [self redisplayLessonData];
            
        } error:nil];
    } error:nil];
    
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 几次
- (void)numberLabelTapOnClick {
    
    [self showAlertWithType:3 targetView:_numberLabel];
    
}
/// 时长
- (void)timesLabelTapOnClick {
    
    [self showAlertWithType:4 targetView:_timesLabel];
    
}

- (void)saveButtonOnClick {
    
    NSString *course_title = [_courseTitleTextField.text removeBlank];
    
    NSString *service_time = [_numberLabel.text removeBlank];
    
    NSString *each_time = [_timesLabel.text removeBlank];
    
    NSString *course_content = [_courseContentTextView.text removeBlank];
    
    NSArray *material_rsurls = _dataArrayM;
    
    NSString *city = @"";
    
    NSInteger type_id = 0;
    
    for (DQAlertSelectedModel *model in self.typeListSelectArray) {
        if (model.isSelected) {
            type_id = model.id;
            break;
        }
    }
    
    NSInteger class_id = 0;
    for (DQAlertSelectedModel *model in self.categorySelectArray) {
        if (model.isSelected) {
            class_id = model.id;
            for (DQAlertSelectedModel *sub_model in model.subArray) {
                if (sub_model.isSelected) {
                    class_id = sub_model.id;
                    break;
                }
            }
            break;
        }
    }
    
    
    NSMutableString *resultString = @"".mutableCopy;
    
    if (course_title.length == 0) {
        [resultString appendString:@"请输入课程标题、"];
    }
    if (class_id == 0) {
        [resultString appendString:@"请选择课程分类、"];
    }
    if (type_id == 0) {
        [resultString appendString:@"请选择课程类型、"];
    }
    
    if (course_content.length == 0) {
        [resultString appendString:@"请输入课程内容、"];
    }
    
    
    if (resultString.length > 0) {
        NSString *alertStr = [resultString substringToIndex:resultString.length - 1];
        DQAlertView *checkAlertView = [[DQAlertView alloc] initWithTitle:nil message:alertStr cancelButtonTitle:@"我知道了" otherButtonTitle:nil];
        [checkAlertView setAlertThemeMessageTip_OneButton];
        [checkAlertView show];
        return;
    } else { /// 提交数据
        NSMutableString *strm = @"".mutableCopy;
        for (NSString *url in material_rsurls) {
            [strm appendFormat:@"&material_rsurls=%@",url];
        }
        
        NSMutableDictionary *params = @{@"urls" : strm, @"course_title" : course_title, @"type_id" : @(type_id), @"service_time" : service_time, @"each_time" : each_time, @"course_content" : course_content, @"class_id" : @(class_id), @"city" : city}.mutableCopy;
        
        if (self.dataModel) {
            [params setObject:@(self.dataModel.id) forKey:@"course_id"];
        }
        
        [MGBussiness loadCourseAddWithParams:params completion:^(id results) {
            if ([results boolValue]) {
                if (self.dataModel) {
                    UIViewController *tempVC = nil;
                    for (UIViewController *vc in self.navigationController.viewControllers) {
                        if([vc isKindOfClass:[MGMyLessonVC class]]) {
                            tempVC = vc;
                            break;
                        };
                    }
                    if (tempVC) {
                        [self.navigationController popToViewController:tempVC animated:YES];
                    } else {
                        PopVC
                    }
                    
                } else {
                    MGTeacherDetailVC *vc = [MGTeacherDetailVC new];
                    /// 传递了会员 id  会员是导师才能发布课程
                    vc.id = memberDataModelInstance.id;
                    PushVC(vc)
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    /// 发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:AddLessonCompletionReloadRefreshView object:nil];
                });
                
            }
        } error:nil];
        
        
    }
    
    
    
    
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

- (NSMutableArray *)dataArrayM {
    if (!_dataArrayM) {
        _dataArrayM = @[].mutableCopy;
    }
    return _dataArrayM;
}

- (NSArray *)timesArray {
    if (!_timesArray) {
        DQAlertSelectedModel *model1 = [DQAlertSelectedModel new];
        model1.isSelected = YES;
        model1.title = @"一次";
        DQAlertSelectedModel *model2 = [DQAlertSelectedModel new];
        model2.title = @"二次";
        DQAlertSelectedModel *model3 = [DQAlertSelectedModel new];
        model3.title = @"三次";
        
        _timesArray = @[model1, model2, model3];
    }
    return _timesArray;
}

- (NSArray *)timesHourArray {
    if (!_timesHourArray) {
        NSMutableArray *tempArrayM = @[].mutableCopy;
        for (int i = 0; i < 6; i++) {
            DQAlertSelectedModel *model1 = [DQAlertSelectedModel new];
            model1.isSelected = i == 0 ? YES : NO;
            NSInteger result = i + 1;
            if (i == 4) {
                result += 3;
            } else if (i == 5) {
                result += 6;
            }
            model1.title = [NSString stringWithFormat: @"每次约%zd小时",result];
            [tempArrayM addObject:model1];
        }

        _timesHourArray = tempArrayM.copy;
    }
    return _timesHourArray;
}

#pragma mark - UIColletionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MGUploadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MGUploadCollectionViewCellID" forIndexPath:indexPath];
    
    cell.item = indexPath.item;
    if (indexPath.item < self.dataArrayM.count) {
        cell.url = self.dataArrayM[indexPath.item];
    } else {
        cell.addButtonType = CellAddButtonTypeGray;
        cell.url = @"addButton";
    }
    WEAK
    cell.buttonEventBlock = ^(NSInteger item, NSInteger tag){
       STRONG
        if (tag == 1001) { /// 添加
            if (indexPath.item == self.dataArrayM.count) { /// 添加按钮
//                [self.dataArrayM addObject:@"https://www.mangopi.com.cn/M00/00/01/rBIAaFmKgYuAJNzgAAAUPBWtlEc657.png"];
//                [self.colletionView reloadData];
//                [self resetCollectionViewFrame];
                
                [self.photoView setBottomTtitleWithString:@"取消"];
                [self.photoView showSelectPhotoWithAnimated:YES inView:KeyWindow];
            } else {
                
                MGCommonWKWebViewVC *vc = [MGCommonWKWebViewVC new];
                vc.titleString = @"预览文件";
                vc.urlString = self.dataArrayM[item];;
                PushVC(vc)
                
//                SDPhotoBrowser *photoBrowser = [[SDPhotoBrowser alloc] init];
//                photoBrowser.delegate = self;
//                photoBrowser.currentImageIndex = item;
//                photoBrowser.imageCount = self.dataArrayM.count;
//                photoBrowser.sourceImagesContainerView = self.colletionView;
//                [photoBrowser show];
            }
            
        } else { // 删除
            
            DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:nil message:@"是否删除？" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
            [alertView setAlertThemeMessageTip_TwoButton];
            alertView.otherButtonAction = ^{

                [self.dataArrayM removeObjectAtIndex:item];
                [self.colletionView reloadData];
                [self resetCollectionViewFrame];
            };
            [alertView show];

        }
        
    };
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataArrayM.count > 6) {
        return self.dataArrayM.count;
    }
    return self.dataArrayM.count + 1;
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
                
            }
            
        };
        [KeyWindow addSubview:_photoView];
    }
    return _photoView;
}

- (void)uploadIconImageWithImage:(UIImage *)image {
    
    [MGBussiness updateLoadImageWithImage:image completion:^(NSString *results) {
        [self.dataArrayM addObject:results];
    
        [self.colletionView reloadData];
        
        [self resetCollectionViewFrame];
        
        
    } error:nil];

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
    return [NSURL URLWithString:self.dataArrayM[index]];
}
- (void)resetCollectionViewFrame {
    
    if (self.dataArrayM.count >= 5) {
        self.colletionView.height = ([MGUploadCollectionViewCell getItemWidth] + SW(21)) * 2 + SH(30);
    } else {
        self.colletionView.height = [MGUploadCollectionViewCell getItemWidth] + SW(21) + SH(30);
    }
    
    self.infoLineView.top = self.colletionView.bottom;
    self.infoBgView.height = self.infoLineView.bottom;
    self.bottomTipLabel.top = self.infoBgView.bottom + SH(30);
    self.saveButton.top = self.bottomTipLabel.bottom + SH(50);
    _scrollView.contentSize = CGSizeMake(kScreenWidth, _saveButton.bottom + SH(40)) ;
    
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
            title = @"课程分类";
            array = self.categorySelectArray;
            break;
        case 1:
            title = @"课程分类";
            break;
            
        case 2:
            title = @"选择课程类型";
            array = self.typeListSelectArray;
            break;
            
        case 3:
            title = @"服务次数";
            array = self.timesArray;
            break;
        case 4:
            title = @"服务时长";
            array = self.timesHourArray;
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
                if (type != 0) {
                    model.isSelected = NO;
                }
                if ([model.title isEqualToString:selectedResult.title]) {
                    if (type == 0 && model.subArray.count > 0) { /// 分类 第二次确定才选中
                        [self showAlertWithType:1 targetView:targView array:model.subArray];
                    } else {
                        if (type == 0) { ///
                            
                            for (DQAlertSelectedModel *parentModel in self.categorySelectArray) {
                                /// 全取消
                                parentModel.isSelected = NO;
                                for (DQAlertSelectedModel *subModel in parentModel.subArray) {
                                    subModel.isSelected = NO;
                                }
                            }
                            
                        } else if (type == 1) { /// 二级
                            for (DQAlertSelectedModel *parentModel in self.categorySelectArray) {
                                /// 全取消
                                parentModel.isSelected = NO;
                                for (DQAlertSelectedModel *subModel in parentModel.subArray) {
                                    subModel.isSelected = NO;
                                }
                            }
                            
                            for (DQAlertSelectedModel *parentModel in self.categorySelectArray) {
                                if (parentModel.id == model.parentId && model.parentId > 0) {
                                    /// 选择父类
                                    parentModel.isSelected = YES;
                                }
                                
                            }
                        }
                        
                        /// 直接选中
                        model.isSelected = YES;
                        
                        targView.text = model.title;
                        if (type == 2) { /// 课程分类类型
                            /// 修改价格
                            self.coursePriceSettingView.subTitlelabel.text = [TDCommonTool formatPriceWithDoublePrice:model.price];
                            self.coursePriceSettingView.subTitlelabel.textColor = MGThemeColor_Black;
                        }
                    }
                }
            }
            
            
        };
        alertView.delegate = self;
        [alertView show];
    };
    
}
#pragma mark - DQAlertViewDelegate
- (void)didAppearAlertView:(DQAlertView *)alertView {
    
    [alertView scrollToSelectedItem];
    
}

/// 回显数据
- (void)redisplayLessonData {
    
    if (self.dataModel) {
        /// 标题
        self.courseTitleTextField.text = self.dataModel.course_title;
        
        
        /// 课程分类Id
        for (DQAlertSelectedModel *model in self.categorySelectArray) {
            
            /// 1级
            if (model.id == self.dataModel.classify_id) {
                model.isSelected = YES;
                self.courseCategorySettingView.subTitlelabel.text = model.title;
                break;
            }
            
            for (DQAlertSelectedModel *sub_model in model.subArray) {
                if (sub_model.id == self.dataModel.classify_id) {
                    sub_model.isSelected = YES;
                    model.isSelected = YES;
                    self.courseCategorySettingView.subTitlelabel.text = sub_model.title;
                    break;
                }
            }
        }
        
        
        
        /// 课程类型
        for (DQAlertSelectedModel *model in self.typeListSelectArray) {
            if (model.id == self.dataModel.type_id) {
                model.isSelected = YES;
                self.courseTypeSettingView.subTitlelabel.text = model.title;
                break;
            }
        }
        
        /// 内容
        self.courseContentTextView.text = self.dataModel.course_content;
        
        
        /// 服务次数
        for (DQAlertSelectedModel *model in self.timesArray) {
            if ([model.title isEqualToString:self.dataModel.service_time]) {
                model.isSelected = YES;
                break;
            }
        }
        
        /// 价格
        self.coursePriceSettingView.subTitlelabel.text = [TDCommonTool formatPriceWithDoublePrice:self.dataModel.sale_price];
        self.coursePriceSettingView.subTitlelabel.textColor = MGThemeColor_Black;
        
        /// 服务时长
        for (DQAlertSelectedModel *model in self.timesArray) {
            if([model.title isEqualToString:self.dataModel.each_time]) {
                model.isSelected = YES;
                break;
            }
        }
        
        /// 附加文件
        self.dataArrayM = [self.dataModel.material_rsurls mutableCopy];
        [self.colletionView reloadData];
        [self resetCollectionViewFrame];
        
    }
    
    
}



@end
