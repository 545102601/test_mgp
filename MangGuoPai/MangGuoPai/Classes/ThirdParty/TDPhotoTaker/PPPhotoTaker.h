//
//  PPPhotoTaker.h
//  PPTakePhoto
//  工具类：快速获取拍照或者相册选择的图片
//
//  Created by 林晖杰 on 16/3/28.
//  Copyright © 2016年 林晖杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  回调的Block
 *
 *  @param image        选择的图片
 */
typedef void (^FinishBlock)(UIImage *image);

@interface PPPhotoTaker : NSObject
/**
 *  从相机获取图片
 *
 *  @param finishBlock 拍照完成的回调
 */
+ (void)getPictureFromCemera:(FinishBlock)finishBlock;

/**
 *  从相机获取图片
 *
 *  @param isNeed      拍照完是否需要编辑
 *  @param finishBlock 拍照完成的回调
 */
+ (void)getPictureFromCemeraNeedEditing:(BOOL)isNeed finishBlock:(FinishBlock)finishBlock;

/**
 *  从相机获取图片
 *
 *  @param isNeed             拍照完是否需要编辑
 *  @param needSaveInLibrary  拍照完是否需要保存到相册
 *  @param finishBlock        拍照完成的回调
 */
+ (void)getPictureFromCemeraNeedEditing:(BOOL)isNeed needSaveInLibrary:(BOOL)needSaveInLibrary finishBlock:(FinishBlock)finishBlock;

/**
 *  从相册获取图片
 *
 *  @param finishBlock 选择完成图片的回调
 */
+ (void)getPictureFromLibrary:(FinishBlock)finishBlock;

/**
 *  从相册获取图片
 *
 *  @param isNeed      选择完成图片是否需要编辑
 *  @param finishBlock 选择完成图片的回调
 */
+ (void)getPictureFromLibraryNeedEditing:(BOOL)isNeed finishBlock:(FinishBlock)finishBlock;

@end
