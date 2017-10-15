//
//  MGFoundCellPhotosCotainerView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/4.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGFoundCellPhotosCotainerView.h"
#import "SDPhotoBrowser.h"

@interface MGFoundCellPhotosCotainerView ()<SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *imageViewsArray;

@end

@implementation MGFoundCellPhotosCotainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
    self.imageViewsArray = [temp copy];
}


- (void)setPicPathStringsArray:(NSArray *)picPathStringsArray
{
    _picPathStringsArray = picPathStringsArray;
    
    for (long i = _picPathStringsArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (_picPathStringsArray.count == 0) {
        self.height_sd = 0;
        self.fixedHeight = @(0);
        return;
    }
    
    CGFloat itemW = [self itemWidthForPicPathArray:_picPathStringsArray];
    CGFloat itemH = 0;
    if (_picPathStringsArray.count == 1) {
        itemH = SH(320);
//        UIImage *image = [UIImage imageNamed:_picPathStringsArray.firstObject];
//        if (image.size.width) {
//            itemH = image.size.height / image.size.width * itemW;
//        }
    } else {
        itemH = itemW;
    }
    long perRowItemCount = [self perRowItemCountForPicPathArray:_picPathStringsArray];
    CGFloat margin = SW(20);
    
    [_picPathStringsArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
        imageView.hidden = NO;
        imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
        [imageView sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:SDWEB_PLACEHODER_IMAGE(imageView)];
    }];
    
    CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
    int columnCount = ceilf(_picPathStringsArray.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
    self.width_sd = w;
    self.height_sd = h;
    
    self.fixedHeight = @(h);
    self.fixedWidth = @(w);
}

#pragma mark - private actions

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = self.picPathStringsArray.count;
    browser.delegate = self;
    [browser show];
}

- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    if (array.count == 1) {
        return SW(690);
    } else {
        CGFloat w = SW(220);
        return w;
    }
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count < 4) {
        return array.count;
    } else if (array.count == 4) {
        return 2;
    } else {
        return 3;
    }
}


#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = self.picPathStringsArray[index];
    NSURL *url = [NSURL URLWithString:imageName];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}

@end
