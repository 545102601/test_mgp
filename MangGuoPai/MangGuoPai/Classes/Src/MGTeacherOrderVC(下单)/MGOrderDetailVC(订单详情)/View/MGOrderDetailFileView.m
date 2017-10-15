//
//  MGOrderDetailFileView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/7.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGOrderDetailFileView.h"
#import "MGUploadCollectionViewCell.h"
#import "MGCommonWKWebViewVC.h"

@interface MGOrderDetailFileView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *fileTipLabel;
@property (nonatomic, strong) UICollectionView *colletionView;
@property (nonatomic, strong) UIView *fileLineView;


@end

@implementation MGOrderDetailFileView

- (void)prepareFrameViewUI:(CGRect)frame {

    _fileTipLabel = [MGUITool labelWithText:@"相关资料和附件:" textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _fileTipLabel.frame = CGRectMake(SW(30), SW(30), kScreenWidth * 0.5, _fileTipLabel.fontLineHeight);
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    CGFloat itemWidth = [MGUploadCollectionViewCell getItemWidth];
    
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    layout.minimumLineSpacing = SW(21);
    layout.minimumInteritemSpacing = SW(21);
    layout.sectionInset = UIEdgeInsetsMake(SW(0), SW(60), SH(30), SW(60));
    
    _colletionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _fileTipLabel.bottom, kScreenWidth, itemWidth + SW(21)) collectionViewLayout:layout];
    _colletionView.backgroundColor = [UIColor whiteColor];
    _colletionView.delegate = self;
    _colletionView.dataSource = self;
    _colletionView.scrollEnabled = NO;
    [_colletionView registerClass:[MGUploadCollectionViewCell class] forCellWithReuseIdentifier:@"MGUploadCollectionViewCellID"];
    
    
    _fileLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _colletionView.bottom, kScreenWidth - SW(48), MGSepLineHeight)];
    _fileLineView.backgroundColor = MGSepColor;
    
    [self sd_addSubviews:@[_fileTipLabel, _colletionView, _fileLineView]];
    
}
#pragma mark - UIColletionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MGUploadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MGUploadCollectionViewCellID" forIndexPath:indexPath];
    cell.hiddenDeleteButton = YES;
    cell.item = indexPath.item;
    if (indexPath.item < self.dataArrayM.count) {
        cell.url = self.dataArrayM[indexPath.item];
    } else {
        cell.url = @"addButton";
    }
    WEAK
    cell.buttonEventBlock = ^(NSInteger item, NSInteger tag){
        STRONG
        if (tag == 1001) {
            
            MGCommonWKWebViewVC *vc = [MGCommonWKWebViewVC new];
            vc.titleString = @"预览文件";
            vc.urlString = self.dataArrayM[item];;
            [[TDCommonTool findViewController:self].navigationController pushViewController:vc animated:YES];
        }
        
    };
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArrayM.count;
}

/// 刷新高度
- (void)resetCollectionViewFrame {
    
    if (self.dataArrayM.count >= 5) {
        self.colletionView.height = ([MGUploadCollectionViewCell getItemWidth] + SW(21)) * 2;
    } else {
        self.colletionView.height = [MGUploadCollectionViewCell getItemWidth] + SW(21);
    }
    self.fileLineView.top = self.colletionView.bottom;
    self.height = self.fileLineView.bottom;
    if (_resetFrameBlock) {
        _resetFrameBlock(self.height);
    }
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter
- (void)setDetailDataModel:(MGResOrderDetailDataModel *)detailDataModel {
    _detailDataModel = detailDataModel;
    self.dataArrayM = detailDataModel.material_rsurls.mutableCopy;
}

- (void)setDataArrayM:(NSMutableArray *)dataArrayM {
    _dataArrayM = dataArrayM;
    
    [self.colletionView reloadData];
    
    if (self.dataArrayM.count > 0) {
        [self resetCollectionViewFrame];
        self.hidden = NO;
    } else {
        self.height = 0;
        self.hidden = YES;
    }
}

- (void)setTipTitleText:(NSString *)tipTitleText {
    _tipTitleText = tipTitleText;
    
    _fileTipLabel.text = tipTitleText;
}

@end
