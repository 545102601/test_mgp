//
//  MGNavigationController.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGNavigationController.h"

@interface MGNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation MGNavigationController

+ (void)initialize {
    /*
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    [bar setTintColor:[UIColor whiteColor]];
    [bar setBarTintColor:MGThemeBackgroundColor];
    //    [bar setBackgroundImage:[UIImage imageNamed:@"recomend_btn_gone"] forBarMetrics:UIBarMetricsDefault];
    //去掉导航条的半透明
    bar.translucent = NO;
    //设置导航条字体的富文本属性
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    [bar setTitleTextAttributes:dict];
    */
    
    //设置按钮只能同时点击一个
//    [UIButton appearance].exclusiveTouch = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.navigationBar removeFromSuperview];
    
    self.interactivePopGestureRecognizer.delegate = self;
    
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    /// 屏蔽 控制器个数 等于1的
    if (self.viewControllers.count == 1) {
        return NO;
    }
    
    return YES;
}

#pragma mark - Public Function
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        
//        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        [backBtn setImage:[UIImage imageNamed:@"icon_back_white"] forState:UIControlStateNormal];
//        backBtn.frame = CGRectMake(0, 0, 24, 32);
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//        viewController.navigationItem.leftBarButtonItem = leftItem;
//        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)backBtnClick {
    [self popViewControllerAnimated:YES];
}

@end
