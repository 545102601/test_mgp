//
//  MGBussiness+MGMineExtend.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/24.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussiness.h"

@interface MGBussiness (MineExtend)

/// 加载个人信息
+ (void)loadMineMemberGetDataWithCompletion:(BussinessCompletion)completion error:(BussinessError)error;

/// 上传用户信息头像
+ (void)uploadIconImageWithImage:(UIImage *)image gender:(NSInteger)gender nickName:(NSString *)nickName entity_id:(long)entity_id completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 修改用户信息
+ (void)updateMemeberInfiWithPamras:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;


/// 加载收藏列表 - 分页
+ (void)loadFav_ListDataWithPageNo:(NSInteger)pageNo Completion:(BussinessCompletion)completion error:(BussinessError)error;


/// 删除收藏
+ (void)loadFav_Del:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;


/// 检查身份  0 学生 1 导师 2 公司 3 社团
+ (void)loadCouldUpgradeWithType:(NSInteger)type completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 升级身份 0 学生 1 导师 2 公司 3 社团
+ (void)loadUpgradeWithType:(NSInteger)type params:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 社团分类
+ (void)loadCommunityClassic_ListWithCompletion:(BussinessCompletion)completion error:(BussinessError)error;

/// 社团类型
+ (void)loadCommunityType_ListWithCompletion:(BussinessCompletion)completion error:(BussinessError)error;

/// 上传图片 不指定任何 entity_id 和 entity_type_id
+ (void)updateLoadImageWithImage:(UIImage *)image completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 加载会员钱包详情
+ (void)loadMemberWalletWithCompletion:(BussinessCompletion)completion error:(BussinessError)error;

/// 加载银行卡列表
+ (void)loadCardListCompletion:(BussinessCompletion)completion error:(BussinessError)error;

/// 领取优惠卷接口
+ (void)loadCoupon_Fetch:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 优惠卷列表接口
+ (void)loadCoupon_Owns:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

/// 课程可使用的优惠卷
+ (void)loadCoupon_Promotion:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error;

@end
