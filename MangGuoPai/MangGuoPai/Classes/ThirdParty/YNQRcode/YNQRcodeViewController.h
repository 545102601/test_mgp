//
//  YNQRcodeViewController.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/22.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#define IS_VAILABLE_IOS8  ([[[UIDevice currentDevice] systemVersion] intValue] >= 8)

typedef void (^QRCodeDidReceiveBlock)(NSString *result, NSString *type);

@interface YNQRcodeViewController : UIViewController

@property (nonatomic, copy, readonly) QRCodeDidReceiveBlock didReceiveBlock;

- (void)setDidReceiveBlock:(QRCodeDidReceiveBlock)didReceiveBlock;

- (void)selfRemoveFromSuperview;

+ (instancetype)showQRCodeVieControllerWithCompletion:(QRCodeDidReceiveBlock)didReceiveBlock;


@end
