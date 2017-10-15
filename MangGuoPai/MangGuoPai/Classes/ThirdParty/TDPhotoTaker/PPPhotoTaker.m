//
//  PPPhotoTaker.m
//  PPTakePhoto
//
//  Created by 林晖杰 on 16/3/28.
//  Copyright © 2016年 林晖杰. All rights reserved.
//

#import "PPPhotoTaker.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define notAllowAccessLibrary @"请在iPhone的“设置-隐私-照片”选项中，允许应用访问你的相册"
#define notAllowAccessCemera @"请在iPhone的“设置-隐私-相机”选项中，允许应用访问你的相机"

typedef enum{
    //相机
    PhotoTakerTypeCamera = 0,
    //相册
    PhotoTakerTypePhoto,
    
}PhotoTakerType;

@interface PPPhotoTaker () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
/** 图片选择器 */
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
/** 回调block */
@property (nonatomic, copy) FinishBlock finishBlock;
/** 设置图片选择器的类型 */
@property (nonatomic, assign) PhotoTakerType takerType;
/** 设置拍照完成的图片，是否需要保存到相册 */
@property (nonatomic, assign) BOOL isNeedSaveInLibrary;
/** 用来标示是否显示了imagePickerController, 避免卡顿情况下多次点击导致的present同一个Controller的bug */
@property (nonatomic, assign) BOOL showPickerController;
/******************************************************************************/

/**
 *  单例
 */
+ (PPPhotoTaker *)sharedPhotoTaker;

/**
 *  弹出控制器
 */
- (void)show:(id)controller;

/**
 *  唤醒主线程
 */
- (void)awakeMainThread;

/**
 *  检测是否有权限访问相册
 */
- (BOOL)privilegeToOpenPhotoLibrary;

/**
 *  检测是否有权限访问相机
 */
- (BOOL)privilegeToTakePhoto;

@end

@implementation PPPhotoTaker

#pragma mark - Setter Function
- (void)setTakerType:(PhotoTakerType)takerType {
    _takerType = takerType;
    
    switch (takerType) {
        case PhotoTakerTypePhoto:
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case PhotoTakerTypeCamera:
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        default:
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
    }
}

#pragma mark - Getter Function
- (UIImagePickerController *)imagePickerController {
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
    }
    
    return _imagePickerController;
}

#pragma mark - System Function

#pragma mark - Private Function
+ (PPPhotoTaker *)sharedPhotoTaker{
    static PPPhotoTaker *sharedPhotoTaker = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        sharedPhotoTaker = [[self alloc] init];
        sharedPhotoTaker.showPickerController = NO;
    });
    return sharedPhotoTaker;
}

- (void)show:(id)controller {
    if (_showPickerController) {
        return;
    }
    
    [self performSelector:@selector(awakeMainThread) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
    
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.showPickerController = YES;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        UIViewController *vc = [TDCommonTool currentViewController];
        if (vc) {
            [vc presentViewController:controller animated:YES completion:nil];
        } else {
            [RootViewController presentViewController:controller animated:YES completion:nil];
        }
    });
}

- (void)awakeMainThread {
    
}

- (BOOL)privilegeToOpenPhotoLibrary {
    
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied) {
        return NO;
    }else {
        return YES;
    }
}

- (BOOL)privilegeToTakePhoto {
    
    AVAuthorizationStatus author = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (author == AVAuthorizationStatusRestricted || author == AVAuthorizationStatusDenied) {
        return NO;
    }else {
        return YES;
    }
}

#pragma mark - Public Function
+ (void)getPictureFromCemera:(FinishBlock)finishBlock {
    [self getPictureFromCemeraNeedEditing:NO needSaveInLibrary:YES finishBlock:finishBlock];
}

+ (void)getPictureFromCemeraNeedEditing:(BOOL)isNeed finishBlock:(FinishBlock)finishBlock {
    [self getPictureFromCemeraNeedEditing:isNeed needSaveInLibrary:YES finishBlock:finishBlock];
}

+ (void)getPictureFromCemeraNeedEditing:(BOOL)isNeed needSaveInLibrary:(BOOL)needSaveInLibrary finishBlock:(FinishBlock)finishBlock {
    PPPhotoTaker *taker       = [PPPhotoTaker sharedPhotoTaker];
    taker.finishBlock         = finishBlock;
    taker.takerType           = PhotoTakerTypeCamera;
    taker.isNeedSaveInLibrary = needSaveInLibrary;
    
    /* 方式一： 手动请求授权，在进入拍照 */
    // 获取授权状态
    AVAuthorizationStatus author = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (author == AVAuthorizationStatusNotDetermined) { // 未授权
        if ([AVCaptureDevice respondsToSelector:@selector(requestAccessForMediaType: completionHandler:)]) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        taker.imagePickerController.allowsEditing = isNeed;
                        [taker show:taker.imagePickerController];
                    });
                    
                } else {
                }
            }];
            
        } else {
            taker.imagePickerController.allowsEditing = isNeed;
            [taker show:taker.imagePickerController];
        }
        
    }else if (author == AVAuthorizationStatusAuthorized) { // 已授权
        taker.imagePickerController.allowsEditing = isNeed;
        [taker show:taker.imagePickerController];
        
    }else {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:notAllowAccessCemera message:nil preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:nil];
//        [alert addAction:cancelAction];
//        [taker show:alert];
        
        
        DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:@"提示" message:notAllowAccessCemera cancelButtonTitle:@"取消" otherButtonTitle:@"去设置"];
        [alertView setAlertThemeMessageTip_TwoButton];
        alertView.otherButtonAction = ^{
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        };
        
        [alertView show];
        
    }
    
    /* 方式二： 系统自动请求授权 */
    //    if ([taker privilegeToTakePhoto]) {
    //        [taker show:taker.imagePickerController];
    //    }else {
    //        UIAlertController *alert = [UIAlertController alertControllerWithTitle:notAllowAccessCemera message:nil preferredStyle:UIAlertControllerStyleAlert];
    //        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:nil];
    //        [alert addAction:cancelAction];
    //        [taker show:alert];
    //    }
}

+ (void)getPictureFromLibrary:(FinishBlock)finishBlock {
    [self getPictureFromLibraryNeedEditing:NO finishBlock:finishBlock];
}

+ (void)getPictureFromLibraryNeedEditing:(BOOL)isNeed finishBlock:(FinishBlock)finishBlock {
    
    PPPhotoTaker *taker = [PPPhotoTaker sharedPhotoTaker];
    taker.finishBlock   = finishBlock;
    taker.takerType     = PhotoTakerTypePhoto;
    
    /* 方式一： 手动请求授权，在进入拍照 */
    // 获取状态
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    
    if (author == ALAuthorizationStatusNotDetermined) { // 未授权
        
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        
        [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (*stop) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    taker.imagePickerController.allowsEditing = isNeed;
                    [taker show:taker.imagePickerController];
                });
                
                return;
            }
            
            *stop = TRUE;
            
        } failureBlock:^(NSError *error) {
            DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:@"提示" message:notAllowAccessLibrary cancelButtonTitle:@"取消" otherButtonTitle:@"去设置"];
            [alertView setAlertThemeMessageTip_TwoButton];
            alertView.otherButtonAction = ^{
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            };
            
            [alertView show];
        }];
        
    }else if (author == ALAuthorizationStatusAuthorized) { // 已授权
        taker.imagePickerController.allowsEditing = isNeed;
        [taker show:taker.imagePickerController];
        
    }else {
        DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:@"提示" message:notAllowAccessLibrary cancelButtonTitle:@"取消" otherButtonTitle:@"去设置"];
        [alertView setAlertThemeMessageTip_TwoButton];
        alertView.otherButtonAction = ^{
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        };
        
        [alertView show];
    }
    
    /* 方式二： 系统自动请求授权 */
    //    if ([taker privilegeToOpenPhotoLibrary]) {
    //        [taker show:taker.imagePickerController];
    //    }else {
    //        UIAlertController *alert = [UIAlertController alertControllerWithTitle:notAllowAccessLibrary message:nil preferredStyle:UIAlertControllerStyleAlert];
    //        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:nil];
    //        [alert addAction:cancelAction];
    //        [taker show:alert];
    //    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        UIImage *image;
        
        if (picker.allowsEditing) {
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        if (self.isNeedSaveInLibrary) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // 保存图片到相册
                if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
                }
            });
        }
        
        if(self.finishBlock != nil) {
            self.imagePickerController = nil;
            self.finishBlock(image);
        }
        self.showPickerController = NO;
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [picker dismissViewControllerAnimated:YES completion:^{
        self.imagePickerController = nil;
        self.showPickerController = NO;
    }];
}

@end
