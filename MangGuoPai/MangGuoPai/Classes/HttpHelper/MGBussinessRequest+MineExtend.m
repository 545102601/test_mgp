//
//  MGBussinessRequest+MineExtend.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/12.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussinessRequest+MineExtend.h"

@implementation MGBussinessRequest (MineExtend)

/// 收藏列表
+ (void)getFav_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestGetUrl:HTTP_FAV_LIST
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:NO
           successBlock:successBlock
             errorBlock:errorBlock];
}

/// 添加收藏
+ (void)postFav_Add:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_FAV_ADD
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 删除收藏
+ (void)postFav_Del:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    [self requestPostUrl:HTTP_FAV_DEL
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 检查会员是否允许升级学生身份接口
+ (void)postCheck_Upgrade_Student:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_CHECK_UPGRADE_STUDENT
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 检查会员是否允许升级导师身份接口
+ (void)postCheck_Upgrade_Tutor:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_CHECK_UPGRADE_TUTOR
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}
/// 检查会员是否允许升级企业身份接口
+ (void)postCheck_Upgrade_Company:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_CHECK_UPGRADE_COMPANY
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}
/// 检查会员是否允许升级社团身份接口
+ (void)postCheck_Upgrade_Community:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_CHECK_UPGRADE_COMMUNITY
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}
/// 升级会员学生身份接口
+ (void)postUpgrade_Student:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_UPGRADE_STUDENT
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 升级导师身份接口
+ (void)postUpgrade_Tutor:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_UPGRADE_TUTOR
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}
/// 升级企业身份接口
+ (void)postUpgrade_Company:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_UPGRADE_COMPANY
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}
/// 升级社团身份接口
+ (void)postUpgrade_Community:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_UPGRADE_COMMUNITY
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 会员钱包详情接口
+ (void)postMember_Wallet:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_MEMBER_WALLET
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}
/// 绑定银行卡接口
+ (void)postAdd_Card:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_ADD_CARD
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}
/// 解除绑定银行卡接口
+ (void)postDel_Card:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_DEL_CARD
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}
/// 会员银行卡列表接口
+ (void)postCard_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_CARD_LIST
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}
/// 提现申请接口
+ (void)postWallet_Draw:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_WALLET_DRAW
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 提现详情接口
+ (void)postWallet_Draw_Get:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_WALLET_DRAW_GET
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}
/// 前一次提现详细接口
+ (void)postRecent_Wallet_Draw:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_RECENT_WALLET_DRAW
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 会员交易列表接口
+ (void)postWallet_Trans:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_WALLET_TRANS
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}
/// 社团分类列表接口
+ (void)postCommunityClassic_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_COMMUNITYCLASSIC_LIST
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}

/// 社团类型列表接口
+ (void)postCommunityType_List:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_COMMUNITYTYPE_LIST
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}
/// 企业详情接口
+ (void)postCompany_Get:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_COMPANY_GET
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}



/// 领取优惠卷接口
+ (void)postCoupon_Fetch:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestPostUrl:HTTP_COUPON_FETCH
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:YES
            successBlock:successBlock
              errorBlock:errorBlock];
}


/// 优惠卷列表接口
+ (void)getCoupon_Owns:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {

    [self requestGetUrl:HTTP_COUPON_OWNS
                  params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
         timeoutInterval:RequestTiemOut
               isNeedHUD:NO
            successBlock:successBlock
              errorBlock:errorBlock];
    
}

/// 课程可使用的优惠卷
+ (void)getCoupon_Promotion:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock {
    
    [self requestGetUrl:HTTP_PROMOTION
                 params:[[TDBaseData sharedInstance] returnDictionaryWithContent:dict]
        timeoutInterval:RequestTiemOut
              isNeedHUD:NO
           successBlock:successBlock
             errorBlock:errorBlock];
    
}



@end
