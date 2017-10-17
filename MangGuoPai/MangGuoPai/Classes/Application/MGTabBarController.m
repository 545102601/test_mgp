//
//  MGTabBarController.m
//  MangGuoPai
//
//  Created by ZYN on 2017/6/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTabBarController.h"
#import "MGHomeViewController.h"
#import "MGTeacherViewController.h"
#import "MGFoundViewController.h"
#import "MGMineViewController.h"

@interface MGTabBarController ()

@property (nonatomic, strong) UIView *topLineView;

@end

@implementation MGTabBarController

+ (void)initialize {
    
    /// 修改字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:MGThemeColor_Title_Black} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:MGThemeShenYellowColor} forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage new]];

    
    self.tabBar.backgroundColor = MGThemeColor_Nav_Black;
    
    _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, MGSepLineHeight)];
    _topLineView.backgroundColor = MGSepColor;
//    
//    _topLineView.layer.shadowOpacity = 0.5;
//    _topLineView.layer.shadowOffset = CGSizeMake(4, 0);
//    _topLineView.layer.shadowColor = colorHex(@"#A0A0A0").CGColor;
    
    [self.tabBar addSubview:_topLineView];

    [self setChildVc];
    
}


- (void)setChildVc {
    
    [self addChildViewControllerToRoot:[MGHomeViewController new] title:@"首页" norImage:@"tabbar_home_normal" selImage:@"tabbar_home_selected"];
    
    [self addChildViewControllerToRoot:[MGTeacherViewController new] title:@"导师" norImage:@"tabbar_daoshi_normal" selImage:@"tabbar_daoshi_selected"];
    
    [self addChildViewControllerToRoot:[MGFoundViewController new] title:@"发现" norImage:@"tabbar_faxian_normal" selImage:@"tabbar_faxian_selected"];
    
    [self addChildViewControllerToRoot:[MGMineViewController new] title:@"我的" norImage:@"tabbar_wode_normal" selImage:@"tabbar_wode_selected"];
    
}

- (void)addChildViewControllerToRoot:(UIViewController *)vc
                               title:(NSString *)title
                            norImage:(NSString *)norImage
                            selImage:(NSString *)selImage{
    
    vc.title = title;
    
    MGNavigationController *nav = [[MGNavigationController alloc] initWithRootViewController:vc];
    UIImage *norImage2 = [[UIImage imageNamed:norImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selImage2 = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                   image:norImage2
                                           selectedImage:selImage2];
    nav.tabBarItem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
    nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
    
    
    [self addChildViewController:nav];
    
}

@end
