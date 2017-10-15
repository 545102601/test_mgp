//
//  TDSelectPhotoView.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/5/4.
//  Copyright © 2017年 团贷网. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"
typedef NS_ENUM(NSInteger, SelectPhotoViewType) {
    SelectPhotoViewTypeLook = 0,
    SelectPhotoViewTypeTakePhoto = 1,
    SelectPhotoViewTypeSelectPhoto = 2
    
};

typedef void(^ButtonPhotoOnClickBlock) (SelectPhotoViewType type);

@interface TDSelectPhotoView : BaseView


@property (nonatomic, copy) ButtonPhotoOnClickBlock buttonPhotoOnClickBlock;

- (void)setBottomTtitleWithString:(NSString *)string;

- (void)showSelectPhotoWithAnimated:(BOOL)animated inView:(UIView *)view;

- (void)hideSelectPhotoWithAnimated:(BOOL)animated inView:(UIView *)view;


@end
