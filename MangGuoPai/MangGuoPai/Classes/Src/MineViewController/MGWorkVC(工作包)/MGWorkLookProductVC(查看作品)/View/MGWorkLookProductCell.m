//
//  MGWorkLookProductCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/15.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkLookProductCell.h"
#import "MGWorkLookProductColletionViewCell.h"
#import "SDPhotoBrowser.h"

@interface MGWorkLookProductCell ()<SDPhotoBrowserDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *colletionView;

@end

@implementation MGWorkLookProductCell

- (void)preapreCellUI {
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    CGFloat itemWidth = kScreenWidth;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(itemWidth, kMGWorkLookProductColletionViewCellHeight);
    
    _colletionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.001) collectionViewLayout:layout];
    _colletionView.backgroundColor = [UIColor whiteColor];
    _colletionView.delegate = self;
    _colletionView.dataSource = self;
    _colletionView.showsVerticalScrollIndicator = NO;
    _colletionView.showsHorizontalScrollIndicator = NO;
    _colletionView.scrollEnabled = NO;
    [_colletionView registerClass:[MGWorkLookProductColletionViewCell class] forCellWithReuseIdentifier:@"MGWorkLookProductColletionViewCellID"];
    
    [self.contentView addSubview:_colletionView];
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate
#pragma mark - UIColletionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MGWorkLookProductColletionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MGWorkLookProductColletionViewCellID" forIndexPath:indexPath];
    cell.url = self.urlArray[indexPath.item];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.urlArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SDPhotoBrowser *photoBrowser = [[SDPhotoBrowser alloc] init];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = indexPath.item;
    photoBrowser.imageCount = self.urlArray.count;
    photoBrowser.sourceImagesContainerView = self.colletionView;
    [photoBrowser show];
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
    return [NSURL URLWithString:self.urlArray[index]];
}
#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

- (void)setUrlArray:(NSArray *)urlArray {
    _urlArray = urlArray;
    
    self.colletionView.height = kMGWorkLookProductColletionViewCellHeight * urlArray.count;
    [self.colletionView reloadData];
}

@end
