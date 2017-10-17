//
//  MGHttpConstant.h
//  MangGuoPai
//
//  Created by ZYN on 2017/6/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#ifndef MGHttpConstant_h
#define MGHttpConstant_h

#define RequestTiemOut 30

#if !(PROD_CONFIG)
#define ApiRequestUrl  @"https://demo.lvshetong.cn/mangotree-portal/outer/router"
#else
#define ApiRequestUrl  @"https://www.mangopi.com.cn/outer/router.json"
#endif


///////// http 短连接 //////////
#pragma mark - 项目配置
/// 项目配置信息
#define HTTP_SETTING_LIST @"setting_list"

/// 公告列表
#define HTTP_BULLETIN_LIST @"bulletin_list"
/// 公告详情接口
#define HTTP_BULLETIN_GET @"bulletin_get"
/// 全文搜索
#define HTTP_FULL_SEARCH @"full_search"
/// 内容详情
#define HTTP_CONTENT_GET @"content_get"


/// 消息列表
#define HTTP_MES_LIST @"mes_list"
/// 消息监测
#define HTTP_MES_CHECK @"mes_check"
/// 消息删除
#define HTTP_MES_DEL @"mes_del"
/// 消息阅读
#define HTTP_MES_READ @"mes_read"

/// 收藏列表
#define HTTP_FAV_LIST @"fav_list"
/// 添加收藏
#define HTTP_FAV_ADD @"fav_add"
/// 删除收藏
#define HTTP_FAV_DEL @"fav_del"

/// 动态列表
#define HTTP_TREND_LIST @"trend_list"
/// 添加动态
#define HTTP_TREND_ADD @"trend_add"
/// 检测动态
#define HTTP_TREND_UPDATE @"trend_update"
/// 点赞
#define HTTP_PRAISE_COUNT @"trend_praise"
/// 想看
#define HTTP_WANT_COUNT @"want_count"
/// 转发
#define HTTP_FAWORD_COUNT @"faword_count"
/// 动态详情
#define HTTP_TREND_GET @"trend_get"
/// 回复动态评论
#define HTTP_TREND_REPLY @"trend_reply"

#pragma mark - 用户相关
/// 上传附件
#define HTTP_UPLOAD @"upload"

/// 快速登录
#define HTTP_QUICK_LOGIN @"quick_login"
/// 微信登录
#define HTTP_WX_LOGIN @"wx_login"
/// 微信获取unionId
#define HTTP_WX_UNIONID @"https://api.weixin.qq.com/sns/userinfo"
/// 会员详情
#define HTTP_MEMBER_GET @"member_get"
/// 更新会员基本信息接口
#define HTTP_UPDATE_MEMBER @"update_member"
/// 设置会员信息接口
#define HTTP_MEMBER_SETTING @"member_setting"
/// 会员退出
#define HTTP_LOGOUT @"logout"

/// 检查会员是否允许升级学生身份接口
#define HTTP_CHECK_UPGRADE_STUDENT @"check_upgrade_student"
/// 检查会员是否允许升级导师身份接口
#define HTTP_CHECK_UPGRADE_TUTOR @"check_upgrade_tutor"
/// 检查会员是否允许升级企业身份接口
#define HTTP_CHECK_UPGRADE_COMPANY @"check_upgrade_company"
/// 检查会员是否允许升级社团身份接口
#define HTTP_CHECK_UPGRADE_COMMUNITY @"check_upgrade_community"
/// 升级会员学生身份接口
#define HTTP_UPGRADE_STUDENT @"upgrade_student"
/// 升级会员导师身份接口
#define HTTP_UPGRADE_TUTOR @"upgrade_tutor"
/// 升级会员企业身份接口
#define HTTP_UPGRADE_COMPANY @"upgrade_company"
/// 升级会员社团身份接口
#define HTTP_UPGRADE_COMMUNITY @"upgrade_community"

/// 会员钱包详情接口
#define HTTP_MEMBER_WALLET @"member_wallet"

/// 绑定银行卡
#define HTTP_ADD_CARD @"add_card"
/// 解绑银行卡
#define HTTP_DEL_CARD @"del_card"
/// 银行卡列表
#define HTTP_CARD_LIST @"card_list"
/// 提现申请
#define HTTP_WALLET_DRAW @"wallet_draw"
/// 提现详情
#define HTTP_WALLET_DRAW_GET @"wallet_draw_get"
/// 前一次提现详情
#define HTTP_RECENT_WALLET_DRAW @"recent_wallet_draw"
/// 会员交易列表
#define HTTP_WALLET_TRANS @"wallet_trans"
/// 社团分类列表接口
#define HTTP_COMMUNITYCLASSIC_LIST @"communityClassic_list"
/// 社团类型列表接口
#define HTTP_COMMUNITYTYPE_LIST @"communityType_list"
/// 企业详情接口
#define HTTP_COMPANY_GET @"company_get"

/// 领取优惠卷
#define HTTP_COUPON_FETCH @"coupon_fetch"
/// 优惠卷列表
#define HTTP_COUPON_OWNS @"coupon_owns"
/// 课程可使用的优惠卷
#define HTTP_PROMOTION @"promotion"

#pragma mark - 课程相关
/// 导师课程列表接口
#define HTTP_COURSE_LIST @"course_list"
/// 导师详情
#define HTTP_COURSE_TUTOR @"course_tutor"
/// 课程分类列表
#define HTTP_CLASSIFY_LIST @"classify_list"
/// 课程类型列表
#define HTTP_COURSETYPE_LIST @"courseType_list"
/// 课程详情
#define HTTP_COURSE_GET @"course_get"
/// 上架课程接口
#define HTTP_COURSE_ON @"course_On"
/// 下架课程接口
#define HTTP_COURSE_OFF @"course_Off"
/// 删除授课接口
#define HTTP_COURSE_DEL @"course_del"
/// 新增授课接口
#define HTTP_COURSE_ADD @"course_add"

#pragma mark - 订单
/// 下单接口
#define HTTP_ORDER_ADD @"order_add"
/// 支付接口
#define HTTP_ORDER_PAY @"order_pay"
/// 订单列表
#define HTTP_ORDER_LIST @"order_list"
/// 取消订单
#define HTTP_ORDER_CANCEL @"order_cancel"
/// 订单详情
#define HTTP_ORDER_GET @"order_get"
/// 价格计算
#define HTTP_CALC_PRICE @"calc_price"

/// 安排课程接口
#define HTTP_ORDER_SCHEDULE @"order_schedule"
/// 取消课程安排
#define HTTP_ORDER_SCHEDULE_CANCEL @"order_schedule_cancel"
/// 批量取消安排接口
#define HTTP_BATCH_SCHEDULE_CANCEL @"batch_schedule_cancel"
/// 课程安排日历
#define HTTP_SCHEDULE_CALENDAR @"schedule_calendar"


#pragma mark - 工作包
/// 工作包列表
#define HTTP_WORK_LIST @"project_list"
/// 工作包详情
#define HTTP_PROJECT_GET @"project_get"
/// 报名工作包
#define HTTP_PROJECT_JOIN @"project_join"
/// 工作包参加团队列表
#define HTTP_PROJECT_TEAMS @"project_teams"
/// 工作包参与者详情接口
#define HTTP_PROJECT_ACTOR_GET @"project_actor_get"
/// 工作包参与者团队详情接口
#define HTTP_ACTOR_TEAM_GET @"actor_team_get"
/// 参与者企业评论接口
#define HTTP_ACTOR_COMMENT @"actor_comment"
/// 工作包想参与
#define HTTP_PROJECT_WANT @"project_want"
/// 给参与者投票接口
#define HTTP_ACTOR_VOTE @"actor_vote"


#endif /* MGHttpConstant_h */
