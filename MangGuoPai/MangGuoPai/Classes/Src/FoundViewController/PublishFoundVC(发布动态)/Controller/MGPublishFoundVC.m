//
//  MGPublishFoundVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/22.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGPublishFoundVC.h"
#import "PPPhotoTaker.h"
#import "SDPhotoBrowser.h"
#import "TDSelectPhotoView.h"
#import "UITextView+Placeholder.h"
#import "MGUploadCollectionViewCell.h"


@interface MGPublishFoundVC () <UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, SDPhotoBrowserDelegate>

@property (nonatomic, strong) UITextView *textView;
/// 输入提示
@property (nonatomic, strong) UILabel *inputTipLabel;
/// 相片列表
@property (nonatomic, strong) UICollectionView *colletionView;

@property (nonatomic, strong) TDSelectPhotoView *photoView;

/// 相册URL数组
@property (nonatomic, strong) NSMutableArray *dataArrayM;

@end

@implementation MGPublishFoundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发现";
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
    
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    CGFloat itemWidth = [MGUploadCollectionViewCell getItemWidth];
    
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    layout.minimumLineSpacing = SW(21);
    layout.minimumInteritemSpacing = SW(21);
    layout.sectionInset = UIEdgeInsetsMake(SW(21), SW(60), SH(30), SW(60));
    
    _colletionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _inputTipLabel.bottom, kScreenWidth, itemWidth + SW(21)) collectionViewLayout:layout];
    _colletionView.backgroundColor = [UIColor whiteColor];
    _colletionView.delegate = self;
    _colletionView.dataSource = self;
    _colletionView.scrollEnabled = NO;
    [_colletionView registerClass:[MGUploadCollectionViewCell class] forCellWithReuseIdentifier:@"MGUploadCollectionViewCellID"];
    
    [self.view addSubview:_textView];
    [self.view addSubview:_inputTipLabel];
    [self.view addSubview:_colletionView];
    
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
        NSMutableString *strm = @"".mutableCopy;
        for (NSString *url in self.dataArrayM) {
            [strm appendFormat:@"&pics=%@",url];
        }
        
        [MGBussiness loadTrend_AddWithParams:@{@"urls" : strm, @"content" : content} completion:^(id results) {
            if ([results boolValue]) {
                
                [self.navigationController popViewControllerAnimated:YES];
                if (self.publishCompletionBlock) {
                    self.publishCompletionBlock();
                }
            }
        } error:nil];
        
        
    }
    
    
    
}


#pragma mark - UIColletionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MGUploadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MGUploadCollectionViewCellID" forIndexPath:indexPath];
    cell.item = indexPath.item;
    if (indexPath.item < self.dataArrayM.count) {
        cell.url = self.dataArrayM[indexPath.item];
    } else {
        cell.url = @"addButton";
    }
    WEAK
    cell.buttonEventBlock = ^(NSInteger item, NSInteger tag){
        STRONG
        if (tag == 1001) { /// 添加
            if (indexPath.item == self.dataArrayM.count) { /// 添加按钮
//                                [self.dataArrayM addObject:@"https://www.mangopi.com.cn/M00/00/01/rBIAaFmKgYuAJNzgAAAUPBWtlEc657.png"];
//                                [self.colletionView reloadData];
//                                [self resetCollectionViewFrame];
                
                [self.photoView setBottomTtitleWithString:@"取消"];
                [self.photoView showSelectPhotoWithAnimated:YES inView:KeyWindow];
            } else {
                
                SDPhotoBrowser *photoBrowser = [[SDPhotoBrowser alloc] init];
                photoBrowser.delegate = self;
                photoBrowser.currentImageIndex = item;
                photoBrowser.imageCount = self.dataArrayM.count;
                photoBrowser.sourceImagesContainerView = self.colletionView;
                [photoBrowser show];
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
    if (self.dataArrayM.count > 8) {
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
    
    
}

- (NSMutableArray *)dataArrayM {
    if (!_dataArrayM) {
        _dataArrayM = @[].mutableCopy;
    }
    return _dataArrayM;
}
@end
