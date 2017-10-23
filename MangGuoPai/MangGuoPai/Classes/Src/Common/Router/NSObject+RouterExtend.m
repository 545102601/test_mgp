//
//  NSObject+RouterExtend.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "NSObject+RouterExtend.h"
#import "MGCommonWebViewVC.h"
#import "MGContentDetailVC.h"
#import "MGWorkDetailVC.h"
#import "MGTeacherClassDetailVC.h"
#import "MGTeacherDetailVC.h"
#import "MGMyCouponVC.h"
#import "MGTeacherClassDetailVC.h"
#import "MGFoundDetailVC.h"

#define ROUTER_PUSH(vc) [[self getCurrentViewController].navigationController pushViewController:vc animated:YES];

@implementation NSObject (RouterExtend)


- (void)routerWithParams:(NSDictionary *)params {
    [self.class routerWithParams:params];
}

+ (void)routerWithParams:(NSDictionary *)params {
    
        switch ([params[@"bind_type"] integerValue]) {
            case 4:   /// 导师详情
            {
                if ([params[@"entity_id"] integerValue] == 0) {
                    return ;
                }
                MGTeacherDetailVC *vc = [MGTeacherDetailVC new];
                vc.id = [params[@"entity_id"] integerValue];
                ROUTER_PUSH(vc)
                
            }
                break;
                
            case 6:   /// 工作包详情
            {
                
                if ([params[@"entity_id"] integerValue] == 0) {
                    return ;
                }
                MGWorkDetailVC *vc = [MGWorkDetailVC new];
                vc.id = [params[@"entity_id"] integerValue];
                ROUTER_PUSH(vc)
                
            }
                break;
            case 8:   /// 课程
            {
                
                if ([params[@"entity_id"] integerValue] == 0) {
                    return ;
                }
                MGTeacherClassDetailVC *vc = [MGTeacherClassDetailVC new];
                vc.id = [params[@"entity_id"] integerValue];
                ROUTER_PUSH(vc)
            }
                break;
            case 10:  /// 内容
            {
                if ([params[@"entity_id"] integerValue] == 0) {
                    return ;
                }
                MGContentDetailVC *vc = [MGContentDetailVC new];
                vc.id = [params[@"entity_id"] integerValue];
                ROUTER_PUSH(vc)
                
            }
                break;
            case 20: /// 优惠卷领取
            {
                [self dealCouponWithParams:params];
            }
                break;
            default: /// 0 也是超链接
            {
                NSString *url = params[@"click_url"];
                NSString *title = params[@"title"];
                if (url.length > 0) {
                    MGCommonWebViewVC *vc = [MGCommonWebViewVC new];
                    vc.urlString = url;
                    vc.titleString = title;
                    ROUTER_PUSH(vc)
                }
            }
                break;
        }    
}

+ (void)routerWithEntityType:(MGGlobalEntityType)entityType id:(long)id {
    [self routerWithEntityType:entityType id:id];
}

- (void)routerWithEntityType:(MGGlobalEntityType)entityType id:(long)id {
    
    if (id == 0) return;

    switch (entityType) {
        case MGGlobalEntityTypeMemeber:
        {
            MGTeacherDetailVC *vc = [MGTeacherDetailVC new];
            vc.id = id;
            ROUTER_PUSH(vc)
        }
            break;
        case MGGlobalEntityTypeWork:
        {
            MGWorkDetailVC *vc = [MGWorkDetailVC new];
            vc.id = id;
            ROUTER_PUSH(vc)
        }
            break;
        case MGGlobalEntityTypeClass:
        {
            MGTeacherClassDetailVC *vc = [MGTeacherClassDetailVC new];
            vc.id = id;
            ROUTER_PUSH(vc)
        }
            break;
        case MGGlobalEntityTypeFriend:
        {
            MGFoundDetailVC *vc = [MGFoundDetailVC new];
            vc.id = id;
            ROUTER_PUSH(vc)
        }
            break;
        default:
            break;
    }
    
    
}


- (UIViewController *)getCurrentViewController {
    
    return [self.class getCurrentViewController];
}

+ (UIViewController *)getCurrentViewController {
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView *frontView = [[window subviews] objectAtIndex:0];
    
    id nextResponder = [frontView nextResponder];
    UIViewController *vc = nil;
    if ([nextResponder isKindOfClass:[UIViewController class]])
        vc = nextResponder;
    else
        vc = window.rootViewController;
    if ([vc isKindOfClass:[UITabBarController class]]) {//tabbar
        UINavigationController *nav = ((UITabBarController *)vc).selectedViewController;
        vc = nav.topViewController;
        
    }else if ([vc isKindOfClass:[UINavigationController class]]){
        vc = ((UINavigationController *)vc).topViewController;
    }
    
    UIViewController *tempVC =  vc.presentedViewController;
    if (tempVC) {
        if([tempVC isKindOfClass:[UINavigationController class]]){
            vc = ((UINavigationController *)tempVC).topViewController;
        }else{
            vc = tempVC;
        }
    }
    
    return vc;
}


#pragma mark - Private Function
+ (void)dealCouponWithParams:(NSDictionary *)params {
    
    
    NSInteger entity_id = [params[@"entity_id"] integerValue];
    
    [SESSION_MANAGER setCouponIsSuccess:YES entity_id:entity_id];
    
    [MGBussiness loadCoupon_Fetch:@{@"couponId" : @(entity_id)} completion:^(id results) {
        if ([results boolValue]) {
            [self showMBText:@"领取成功"];
            MGMyCouponVC *vc = [MGMyCouponVC new];
            ROUTER_PUSH(vc)
        }
    } error:nil];
    
    
}


@end
