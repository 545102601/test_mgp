//
//  MGThemeConstant.h
//  MangGuoPai
//
//  Created by ZYN on 2017/6/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#ifndef MGThemeConstant_h
#define MGThemeConstant_h


/// 主色调 - 导航条
#define MGThemeBackgroundColor MGThemeYellowColor

/// 主色调 - 黄色
#define MGThemeYellowColor colorHex(@"#ffcc44")
/// 主色调 - 深黄色
#define MGThemeShenYellowColor colorHex(@"#ffb900")

/// View背景颜色
#define MGBackgroundViewColor colorHex(@"#efeff4")

// 分割线||虚线颜色
#define MGSepColor [UIColor hexColorWithString:@"#cccccc"]
/// 分割线高度
#define MGSepLineHeight ([[UIScreen mainScreen] scale] * 0.25)


#pragma mark - 辅助颜色
/// 浅黄色
#define MGThemeColor_QianYellowColor colorHex(@"#ffef99")
/// 红色
#define MGThemeColor_Red colorHex(@"#ff0030")
/// 蓝色
#define MGThemeColor_Green colorHex(@"#14b2ec")
/// 白色
#define MGThemeColor_White [UIColor whiteColor]

#pragma mark - 次要色
/// 纯黑色 - 价钱
#define MGThemeColor_Black colorHex(@"#000000")
/// 标题文字
#define MGThemeColor_Title_Black colorHex(@"#333333")
/// 一般文字
#define MGThemeColor_Common_Black colorHex(@"#666666")
/// 次要文字
#define MGThemeColor_subTitle_Black colorHex(@"#999999")
/// 输入提示性文字
#define MGThemeColor_Placeholder_Black colorHex(@"#cccccc")
///
//#define MGThemeColor_Black colorHex(@"#f2f2f2")
/// 导航栏颜色
#define MGThemeColor_Nav_Black colorHex(@"#f6f6f7")


/// 文本Placeholder颜色
#define MGTextPlaceholderColor MGThemeColor_Placeholder_Black


#pragma mark - 字体大小
/// 一些注释和备注
#define MGThemeFont_20 PFSC(20)
/// 一般重要的文字
#define MGThemeFont_24 PFSC(24)
/// 内页文字信息
#define MGThemeFont_28 PFSC(28)
/// 栏目标题
#define MGThemeFont_30 PFSC(30)
/// 导航栏标题
#define MGThemeFont_32 PFSC(32)
/// 重要标题文字、商品价格、大按钮文字
#define MGThemeFont_36 PFSC(36)


#pragma mark - 按钮状态颜色
#define MGButtonImportDefaultColor colorHex(@"#ffcc44")
#define MGButtonImportHighLightedColor colorHex(@"#ffb900")
#define MGButtonImportNotEnableColor colorHex(@"#cccccc")

#define MGButtonBlankDefaultColor [UIColor whiteColor]
#define MGButtonBlankHighLightedColor colorHex(@"#fffbf3")
#define MGButtonBlankNotEnableColor [UIColor whiteColor]



/// 内容视图左右边距
#define MGViewLeftMargin getScaleWidth(30)

#define MGViewRightMargin MGViewLeftMargin

/// 公共按钮圆角
#define MGButtonLayerCorner 5

#endif /* MGThemeConstant_h */
