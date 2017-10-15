//
//  MGBussiness+MGMineExtend.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/24.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGBussiness+MineExtend.h"
#import "MGResMemberModel.h"
#import "UIImage+Extend.h"
#import "MGResFavListModel.h"
#import "MGAccountModel.h"
#import "MGAccountBlankListModel.h"
#import "MGResCommunityTypeListModel.h"
#import "MGResCommunityClassicListModel.h"
#import "MGCouponOwnsModel.h"

@implementation MGBussiness (MineExtend)


/// 加载个人信息
+ (void)loadMineMemberGetDataWithCompletion:(BussinessCompletion)completion error:(BussinessError)error {
    NSString *uid = [SESSION_MANAGER getCurrentUserUid];
    [MGBussinessRequest postMember_Get:@{@"id" : uid} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if (isSuccess) {
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                MGResMemberModel *model = [MGResMemberModel yy_modelWithDictionary:dic];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(model.data);
                    }
                });
                
            });
            
        } else {
            [self showMBText:message];
        }
        
    } errorBlock:error];

}

/// 上传用户信息头像
+ (void)uploadIconImageWithImage:(UIImage *)image gender:(NSInteger)gender nickName:(NSString *)nickName entity_id:(long)entity_id completion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [TDLoading showViewInKeyWindow];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *_data = [UIImage compressOriginalImage:image toMaxDataSizeKBytes:256];
        
        NSMutableDictionary *dictM = @{}.mutableCopy;
    
        [dictM setObject:@{@"entity_id" : @(entity_id), @"entity_type_id" : @(MGGlobalEntityTypeMemeber)} forKey:@"params"];
        
        [dictM setObject:@"file" forKey:@"name"];
        [dictM setObject:@"fileName.png" forKey:@"fileName"];
        [dictM setObject:@"image/png" forKey:@"mineType"];
        [dictM setObject:_data forKey:@"data"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MGBussinessRequest postUpload:dictM successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
                if (isSuccess) {
                    NSString *str = dic[@"data"][@"file_name"];
                    NSString *url = dic[@"data"][@"url"];
                    if (str.length > 0) {
                        [MGBussinessRequest postUpdate_Member:@{@"gender" : @(gender), @"nick_name" : nickName ?: @"", @"avatar_rsurl" : str} isNeedHUD:NO successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
                            if (isSuccess) {
                                /// 保存 sd 缓存
                                [[SDWebImageManager sharedManager] saveImageToCache:[UIImage imageWithData:_data] forURL:[NSURL URLWithString:url]];
                                if (completion) {
                                    completion(@{@"success" : @(isSuccess), @"url" : url});
                                }
                            } else {
                                [self showMBText:message];
                            }
                            [TDLoading hideViewInKeyWindow];
                        } errorBlock:error];
                    } else {
                        [TDLoading hideViewInKeyWindow];
                    }
                } else {
                    [TDLoading hideViewInKeyWindow];
                    [self showMBText:message];
                }
            } errorBlock:error];

        });
        
    });
 
}


/// 修改用户信息 - 改为setting_member 接口
+ (void)updateMemeberInfiWithPamras:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {

    [MGBussinessRequest postUpdate_Member:dict isNeedHUD:YES successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            [self showMBText:message];
            
            if (completion) {
                completion(@(isSuccess));
            }
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];

}

/// 加载收藏列表 - 分页
+ (void)loadFav_ListDataWithPageNo:(NSInteger)pageNo Completion:(BussinessCompletion)completion error:(BussinessError)error {

    [MGBussinessRequest getFav_List:@{@"page_no" : @(pageNo)} successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if (isSuccess) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                MGResFavListModel *model = [MGResFavListModel yy_modelWithDictionary:dic];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(model);
                    }
                });
            });
        } else {
            [self showMBText:message];
            if (error) {
                error(nil);
            }
        }
    } errorBlock:error];
    
}


/// 删除收藏
+ (void)loadFav_Del:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest postFav_Del:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            if (completion) {
                completion(@(isSuccess));
            }
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
}


/// 检查身份  0 学生 1 导师 2 公司 3 社团
+ (void)loadCouldUpgradeWithType:(NSInteger)type completion:(BussinessCompletion)completion error:(BussinessError)error {

    switch (type) {
        case 0:
        {
            [MGBussinessRequest postCheck_Upgrade_Student:nil successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
                if (isSuccess) {
                    if (completion) {
                        completion(@(isSuccess));
                    }
                } else {
                    [self showMBText:message];
                    
                }
            } errorBlock:error];
        }
            break;
        case 1:
        {
            [MGBussinessRequest postCheck_Upgrade_Tutor:nil successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
                if (isSuccess) {
                    if (completion) {
                        completion(@(isSuccess));
                    }
                } else {
                    [self showMBText:message];
                }
            } errorBlock:error];
        }
            break;
        case 2:
        {
            [MGBussinessRequest postCheck_Upgrade_Company:nil successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
                if (isSuccess) {
                    if (completion) {
                        completion(@(isSuccess));
                    }
                } else {
                    [self showMBText:message];
                }
            } errorBlock:error];
        }
            break;
        case 3:
        {
            [MGBussinessRequest postCheck_Upgrade_Community:nil successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
                if (isSuccess) {
                    if (completion) {
                        completion(@(isSuccess));
                    }
                } else {
                    [self showMBText:message];
                }
            } errorBlock:error];
        }
            break;
    }
}


/// 升级身份 0 学生 1 导师 2 公司 3 社团
+ (void)loadUpgradeWithType:(NSInteger)type params:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {

    
    switch (type) {
        case 0:
        {
            [MGBussinessRequest postUpgrade_Student:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
                if (isSuccess) {
                    if (completion) {
                        completion(@(isSuccess));
                    }
                } else {
                    [self showMBText:message];
                }
            } errorBlock:error];
        }
            break;
        case 1:
        {
            [MGBussinessRequest postUpgrade_Tutor:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
                if (isSuccess) {
                    if (completion) {
                        completion(@(isSuccess));
                    }
                } else {
                    [self showMBText:message];
                }
            } errorBlock:error];
        }
            break;
        case 2:
        {
            [MGBussinessRequest postUpgrade_Company:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
                if (isSuccess) {
                    if (completion) {
                        completion(@(isSuccess));
                    }
                } else {
                    [self showMBText:message];
                }
            } errorBlock:error];
        }
            break;
        case 3:
        {
            [MGBussinessRequest postUpgrade_Community:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
                if (isSuccess) {
                    if (completion) {
                        completion(@(isSuccess));
                    }
                } else {
                    [self showMBText:message];
                }
            } errorBlock:error];
        }
            break;
    }

}
/// 社团分类
+ (void)loadCommunityClassic_ListWithCompletion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest postCommunityClassic_List:nil successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if (isSuccess) {
            MGResCommunityClassicListModel *model = [MGResCommunityClassicListModel yy_modelWithDictionary:dic];
            if (completion) {
                completion(model.data);
            }
        } else {
            [self showMBText:message];
        }
        
    } errorBlock:error];
}

/// 社团类型
+ (void)loadCommunityType_ListWithCompletion:(BussinessCompletion)completion error:(BussinessError)error {
    [MGBussinessRequest postCommunityType_List:nil successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        
        if (isSuccess) {
            MGResCommunityTypeListModel *model = [MGResCommunityTypeListModel yy_modelWithDictionary:dic];
            if (completion) {
                completion(model.data);
            }
        } else {
            [self showMBText:message];
        }
        
    } errorBlock:error];
}

/// 上传图片 不指定任何 entity_id 和 entity_type_id
+ (void)updateLoadImageWithImage:(UIImage *)image completion:(BussinessCompletion)completion error:(BussinessError)error {
    [TDLoading showViewInKeyWindow];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *_data = [UIImage compressOriginalImage:image toMaxDataSizeKBytes:256];
        
        NSMutableDictionary *dictM = @{}.mutableCopy;
        
        [dictM setObject:@"file" forKey:@"name"];
        [dictM setObject:@"fileName.png" forKey:@"fileName"];
        [dictM setObject:@"image/png" forKey:@"mineType"];
        [dictM setObject:_data forKey:@"data"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MGBussinessRequest postUpload:dictM successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
                if (isSuccess) {
                    NSString *str = dic[@"data"][@"file_name"];
                    NSString *url = dic[@"data"][@"url"];
                    if (str.length > 0) {
                        if (completion) {
                            /// 保存 sd 缓存
                            [[SDWebImageManager sharedManager] saveImageToCache:[UIImage imageWithData:_data] forURL:[NSURL URLWithString:url]];
                            completion(url);
                        }
                        [TDLoading hideViewInKeyWindow];
                    } else {
                        [TDLoading hideViewInKeyWindow];
                    }
                } else {
                    [TDLoading hideViewInKeyWindow];
                    [self showMBText:message];
                }
            } errorBlock:error];
        });
    });


}

/// 加载会员钱包详情
+ (void)loadMemberWalletWithCompletion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest postMember_Wallet:nil successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            MGAccountModel *model = [MGAccountModel yy_modelWithDictionary:dic];
            if (completion) {
                completion(model.data);
            }
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
    
}


/// 加载银行卡列表
+ (void)loadCardListCompletion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest postCard_List:nil successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            MGAccountBlankListModel *model = [MGAccountBlankListModel yy_modelWithDictionary:dic];
            if (completion) {
                completion(model.data);
            }
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
    
}

/// 领取优惠卷接口
+ (void)loadCoupon_Fetch:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {
    
    [MGBussinessRequest postCoupon_Fetch:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            if (completion) {
                completion(@(isSuccess));
            }
            
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];
    
}

/// 优惠卷列表接口
+ (void)loadCoupon_Owns:(NSDictionary *)dict completion:(BussinessCompletion)completion error:(BussinessError)error {

    [MGBussinessRequest getCoupon_Owns:dict successBlock:^(NSDictionary *dic, NSString *message, NSString *code, BOOL isSuccess) {
        if (isSuccess) {
            
            MGCouponOwnsModel *model = [MGCouponOwnsModel yy_modelWithDictionary:dic];
            if (completion) {
                completion(model);
            }
            
        } else {
            [self showMBText:message];
        }
    } errorBlock:error];

}

@end
