//
//  TDUMShareAlertView.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/26.
//  Copyright © 2017年 梦创. All rights reserved.
//

#import "BaseView.h"

@interface TDUMShareAlertView : BaseView
/**
 *  初始化
 *
 *  @param title    分享title
 *  @param content  分享内容
 *  @param image    分享的图片     两个二选一,都要则优先获取imageUrl的图片分享
 *  @param imageUrl 分享的图片url
 *  @param url      分享的超链接
 *
 *  @return YNShowUMengShareView
 */
+ (instancetype)showUMengShareViewWithTitle:(NSString *)title shareContent:(NSString *)content shareImage:(UIImage *)image imageUrl:(NSString *)imageUrl shareUrl:(NSString *)url vc:(id)vc;

+ (instancetype)showUMengShareViewWithTitle:(NSString *)title shareContent:(NSString *)content shareImage:(UIImage *)image imageUrl:(NSString *)imageUrl shareUrl:(NSString *)url;

+ (instancetype)showUMengShareViewWithTitle:(NSString *)title shareContent:(NSString *)content shareImage:(UIImage *)image imageUrl:(NSString *)imageUrl shareUrl:(NSString *)url  clickShare:(ShareCompleteBlock)share complete:(ShareCompleteBlock)complete fail:(ShareFailBlock)fail;
/**
 *  显示-默认动画
 */
- (void)show;

/**
 *  隐藏-默认动画
 */
- (void)dismiss;

//显示是否带动画
- (void)showWithAnimation:(BOOL)animation;

//隐藏-是否带动画
- (void)dismissWithAnimation:(BOOL)animation;


@end
