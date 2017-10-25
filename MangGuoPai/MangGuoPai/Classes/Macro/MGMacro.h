//
//  MGMacro.h
//  MangGuoPai
//
//  Created by ZYN on 2017/6/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#ifndef MGMacro_h
#define MGMacro_h

/// 单例创建
#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}


#import "MGBussinessRequestHeader.h"

/// 常量
#import "MGThemeConstant.h"
#import "MGNotificationConstant.h"

/// 工具类
#import "MGBussinessRequest.h"
#import "MGBussinessHelperHeader.h"

#import "TDCommonTool.h"
#import "MGTool.h"
#import "TDEncrytAndDecrypt.h"
#import "TDUmengStatisticsManger.h"

/// 分类
#import <YYCategories.h>
#import <YYModel.h>
#import "UIView+Frame.h"
#import "UIColor+Extend.h"
#import "MBProgressHUD+CSH.h"
#import "NSString+Extend.h"
#import "UILabel+Extend.h"
#import "NSDate+Eextend.h"
#import "UITextField+Extend.h"
#import "NSObject+Extend.h"
#import "TDExpendClickButton.h"
#import "TDExpendClickImageView.h"
#import "NSObject+RouterExtend.h"
#import "UIImage+PlaceHolder.h"
#import "NSURL+Extend.h"

/// 常用类
#import "MGResMemberModel.h"
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "PPSessionManager.h"
#import "PPShareManager.h"
#import "MGNavigationController.h"
#import "MGCommonEmptyView.h"

/// UI
#import <SDAutoLayout.h>
#import "TDLoading.h"
#import "MGUITool.h"

/// 替代UIAlert弹窗
#import "DQAlertView.h"
#import "DQAlertView+Extend.h"

/// 通用的block
typedef void(^MGCommomEventBlock)();


//常用字体
//#define PingFangSC(x) [UIFont fontWithName:@"PingFangSC-Regular" size:x]
/// 快速
#define PFSC(x) PingFangSC(getScaleWidth(x))
#define PingFangSC(x) [UIFont systemFontOfSize:x]

#define NaviBarAndStautsBarHeight           64.0f

// 获取屏幕尺寸
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define Screen_Bounds [UIScreen mainScreen].bounds

/// 根据屏幕尺寸计算比例
#define getScaleWidth(x)  x * kScreenWidth / 750.0
#define getScaleHeight(x) x * kScreenHeight / 1334.0
/// 快速
#define SW(x)  getScaleWidth(x)
#define SH(h) getScaleHeight(h)

#define getAbsoluteHeight(x) x.frame.size.height + x.frame.origin.y
#define getAbsoluteWdith(v) v.frame.size.width + v.frame.origin.x
#define RootViewController ApplicationDelegate.mainTabbarVC
#define KeyWindow [UIApplication sharedApplication].keyWindow
#define ApplicationDelegate (AppDelegate.sharedInstance)

//系统版本
#define SystemVersion [[UIDevice currentDevice] systemVersion].floatValue

/// 特定比例
#define __RadioHeight(_width,_radio) (_width/(_radio))
#define __RadionWidth(_height,_radio) (_radio * _height)

/// 颜色
#define colorHex(str) [UIColor colorWithHexString:str]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)

/// 拦截登录present弹窗
#define InterceptLoginShowAlert if (![[AppDelegate sharedInstance] loginShowAlert]) return;



#define PopVC [self.navigationController popViewControllerAnimated:YES];
#define PushVC(VC) [self.navigationController pushViewController:(VC) animated:YES];


/// 强弱引用
#define WEAK @weakify(self)
#define STRONG @strongify(self)


/***************************** debug模式下日志打印用TDLog ***************************/
#ifdef DEBUG
#define TDLog(...) NSLog(__VA_ARGS__);
#else
#define TDLog(...);
#endif
/**********************************************************************************/

#define YMLOGINFO(xx, ...) NSLog(@"<INFO>: " xx, ##__VA_ARGS__)
//判断对象不为空
#define YM_STRING_IS_NOT_VOID(__VALUE) (((__VALUE) != nil) && (![(__VALUE) isEqualToString:@""]))
//
#define YM_STRING_SAFELY(__VALUE) (((__VALUE) == nil) ? @"" : (__VALUE))
/******************************* debug模式下详细日志信息 *****************************/

#ifdef DEBUG
# define TDDetialLog(fmt, ...) NSLog((@"\n[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" "[输出内容:\n "fmt"\n]\n\n"), \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
__FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define TDDetialLog(...);
#endif
/**********************************************************************************/

#define SDWEB_PLACEHODER_IMAGE(view) [UIImage yn_placeholderImageWithView:view]
/// 头像占位图
#define SDWEB_PLACEHODER_IMAGE_ICON [UIImage imageNamed:@"mine_user_women"]



#endif /* MGMacro_h */
