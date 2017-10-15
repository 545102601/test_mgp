//
//  MGWorkProductionView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/14.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkProductionView.h"
#import "MGCommonWKWebViewVC.h"
#import "MGWorkProductionColletionViewCell.h"
#import "SDPhotoBrowser.h"

@interface MGWorkProductionView ()<SDPhotoBrowserDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *fileTipLabel;

@property (nonatomic, strong) UICollectionView *colletionView;
@property (nonatomic, strong) UIView *fileLineView;



@end

@implementation MGWorkProductionView


- (void)prepareFrameViewUI:(CGRect)frame {
    
    self.backgroundColor = [UIColor whiteColor];
    
    _fileTipLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(28)];
    
    _fileTipLabel.frame = CGRectMake(SW(30), SW(30), kScreenWidth * 0.5, _fileTipLabel.fontLineHeight);
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    CGFloat itemWidth = [MGWorkProductionColletionViewCell getItemWidth];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    layout.minimumLineSpacing = SW(75);
    layout.minimumInteritemSpacing = SW(70);
    layout.sectionInset = UIEdgeInsetsMake(SH(30), SW(60), SH(30), SW(60));
    
    _colletionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _fileTipLabel.bottom, kScreenWidth, itemWidth + SW(30) * 2) collectionViewLayout:layout];
    _colletionView.backgroundColor = [UIColor whiteColor];
    _colletionView.delegate = self;
    _colletionView.dataSource = self;
    
    [_colletionView registerClass:[MGWorkProductionColletionViewCell class] forCellWithReuseIdentifier:@"MGWorkProductionColletionViewCellID"];
    
    
    _fileLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _colletionView.bottom, kScreenWidth - SW(48), MGSepLineHeight)];
    _fileLineView.backgroundColor = MGSepColor;
    
    [self sd_addSubviews:@[_fileTipLabel, _colletionView, _fileLineView]];
    
    self.height = _fileLineView.bottom;
    
}
#pragma mark - UIColletionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MGWorkProductionColletionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MGWorkProductionColletionViewCellID" forIndexPath:indexPath];
    
    cell.item = indexPath.item;
    
    cell.url = self.dataArrayM[indexPath.item];
   
    WEAK
    cell.buttonEventBlock = ^(NSInteger item, NSInteger tag){
        STRONG
        if (tag == 1001) {
            
            if (self.type == MGWorkProductionViewTypephoto || self.type == MGWorkProductionViewTypeTeam) {
                SDPhotoBrowser *photoBrowser = [[SDPhotoBrowser alloc] init];
                photoBrowser.delegate = self;
                photoBrowser.currentImageIndex = item;
                photoBrowser.imageCount = self.dataArrayM.count;
                photoBrowser.sourceImagesContainerView = self.colletionView;
                [photoBrowser show];
            } else {
                MGCommonWKWebViewVC *vc = [MGCommonWKWebViewVC new];
                vc.titleString = @"预览文件";
                vc.urlString = self.dataArrayM[item];;
                [[TDCommonTool findViewController:self].navigationController pushViewController:vc animated:YES];
                
            }
        }
        
    };
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArrayM.count;
}


#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate
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
#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

- (void)setDataArrayM:(NSMutableArray *)dataArrayM {
    _dataArrayM = dataArrayM;
    
    [_colletionView reloadData];
    
}

- (void)setType:(MGWorkProductionViewType)type {
    _type = type;
    
    
    NSString *title;
    
    switch (type) {
        case 0:
            title = @"作品照片 : ";
            break;
        case 1:
            title = @"文档方案 : ";
            break;
        case 2:
            title = @"团队照片 : ";
            break;
        default:
            break;
    }
    _fileTipLabel.text = title;
}

@end
