//
//  AppDelegate.h
//  MangGuoPai
//
//  Created by ZYN on 2017/6/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) MGTabBarController *mainTabbarVC;

@property (strong, nonatomic) UIWindow *window;


/// 去登录
- (void)gotoLogin;

/// 登录弹窗
- (BOOL)loginShowAlert;

/// 单例
+ (instancetype)sharedInstance;

@end

