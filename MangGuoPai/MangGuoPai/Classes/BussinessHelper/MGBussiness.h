//
//  MGBussiness.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/13.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BussinessCompletion)(id results);

typedef void(^BussinessError)(NSError *error);


/// 对象类型的定义（EntityType）
typedef NS_ENUM(NSInteger, MGGlobalEntityType) {
    MGGlobalEntityTypeNone = 0, /// 不上传
    MGGlobalEntityTypeHomeSetting = 1,    /// 首页设置
    MGGlobalEntityTypeMemeber = 4,        /// 会员
    MGGlobalEntityTypeOrder = 5,          /// 订单
    MGGlobalEntityTypeWork = 6,           /// 工作包
    MGGlobalEntityTypeFriend = 7,         /// 动态
    MGGlobalEntityTypeClass = 8,          /// 课程
    MGGlobalEntityTypeClassCategory = 9,  /// 课程分类
    
};


/// 订单状态  - 前台文本  - 后台文本
typedef NS_ENUM(NSInteger, MGGlobalOrderState) {
    MGGlobalOrderStateNot = 0 , ///      /// 无状态
    MGGlobalOrderStateWaitingDeal = 1, /// 订单待处理  /// 待处理
    MGGlobalOrderStateWaitingPay = 2, /// 订单待付款   /// 待收款
    MGGlobalOrderStateAlreadyPay = 3, /// 订单已付款   /// 待预约
    MGGlobalOrderStateAlreadyPayWaitingArrangement = 4, /// 订单已付款，待安排 /// 待安排
    MGGlobalOrderStateAlreadyPayAlreadyArrangement = 5, /// 订单已付款，已安排 /// 已安排
    MGGlobalOrderStateBussinessFinish = 50, /// 交易完成  /// 交易完成
    MGGlobalOrderStateOrderCancelForUser = -1,/// 订单已取消 /// 用户取消
    MGGlobalOrderStateOrderCancelForService = -2,/// 订单已取消 /// 客服取消
    MGGlobalOrderStateOrderCancelForSystem = -3,/// 订单已取消 /// 系统取消
    
};

/// 状态
typedef NS_ENUM(NSInteger, MGGlobaState) {
    MGGlobaStateNone = 0, /// 停用、隐藏、未发布
    MGGlobaStateAlreadyRead = 1, /// 已阅
    MGGlobaStateNormal = 50, /// 正常、显示、已发布
    MGGlobaStateAudit = -25, ///待审核、
    MGGlobaStateAlreadyReply = -2, /// 已回复
};


/// 审核状态
typedef NS_ENUM(NSInteger, MGGlobaApproveState) {
    MGGlobaApproveStateNone = 0, /// 停用、隐藏、未发布
    MGGlobaApproveStateNormal = 50, /// 正常、显示、已发布
    MGGlobaApproveStateAudit = -25, ///待审核、
};

/// 订单页面的按钮tab
typedef NS_ENUM(NSInteger, MGGlobaOrderButtonTag) {
    MGGlobaOrderButtonTagCancel = 1000, /// 取消
    MGGlobaOrderButtonTagPay = 1001,    /// 立即支付
    MGGlobaOrderButtonTagApply = 1002,  /// 申请售后
    MGGlobaOrderButtonTagComment = 1003,        /// 点评
    MGGlobaOrderButtonTagReplyComment = 1004,   /// 回复点评
    MGGlobaOrderButtonTagSchedule = 1005,       /// 安排日程
    MGGlobaOrderButtonTagCancelSchedule = 1006, /// 取消安排
    MGGlobaOrderButtonTagResetSchedule = 1007  /// 重新安排
};

typedef NS_ENUM(NSInteger, MGGlobaMenuTag) {
    MGGlobaMenuTagLeft = 1,
    MGGlobaMenuTagRight = 2,
};

@interface MGBussiness : NSObject

@end
