//
//  MGAppDriven.h
//  MangGuoPai
//
//  Created by ZYN on 2017/6/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MGAppDrivenManager [MGAppDriven sharedInstance]

@interface MGAppDriven : NSObject

/// 适配iOS11
- (void)adateriOS11;

/// 程序启动
- (void)driven:(NSDictionary *)launchOptions;

/// 初始化主窗口
- (void)initRootWindow;

/// 初始化欢迎页面
- (void)initNewVersionView;

/// 切换环境
- (void)changeTestDev;

/// 开启定时器检测动态
- (void)startTimerForCheckTrendUpdate;

/// 单例
AS_SINGLETON(MGAppDriven);


@end
