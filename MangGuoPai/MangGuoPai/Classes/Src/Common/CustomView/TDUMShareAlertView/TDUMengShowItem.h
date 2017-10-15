//
//  TDUMengShowItem.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/26.
//  Copyright © 2017年 梦创. All rights reserved.
//

#import "BaseView.h"

@class TDUMengShowItem;

typedef void(^ItemTapBlock)(TDUMengShowItem *);

@interface TDUMengShowItem : BaseView

//按钮
@property (nonatomic, weak) UIButton *button;
//文字
@property (nonatomic, weak) UILabel *label;

@property (nonatomic, copy) ItemTapBlock itemTapBlock;

- (void)setItemImage:(UIImage *)image;

- (void)setItemTtile:(NSString *)title;


@end
