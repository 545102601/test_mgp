//
//  MGMyCouponVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/12.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMyCouponVC.h"
#import "YNPageScrollViewController.h"
#import "MGMyCouponBaseVC.h"

@interface MGMyCouponVC ()<YNPageScrollViewControllerDataSource>

@end

@implementation MGMyCouponVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的优惠卷";
    
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    
    /// 初始化多个控制器
    [self setupNavStyleViewViewController];
    
}


#pragma mark - 加载数据
- (void)loadData {
    
}

//导航条样式
- (void)setupNavStyleViewViewController {
    
    
    
    //配置信息s
    YNPageScrollViewMenuConfigration *configration = [[YNPageScrollViewMenuConfigration alloc]init];
    /// 高度0
    configration.menuHeight = SH(84);
//    configration.itemLeftAndRightMargin = SW(82);
    configration.lineColor = MGThemeShenYellowColor;
    configration.lineHeight = 2;
    configration.pageScrollViewMenuStyle = YNPageScrollViewMenuStyleTop;
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    configration.selectedItemColor = MGThemeShenYellowColor;
    configration.normalItemColor = MGThemeColor_subTitle_Black;
    configration.itemFont = PFSC(30);
//    configration.itemMargin = SW(155);
    configration.aligmentModeCenter = NO;
    configration.scrollMenu = NO;
    configration.showBottomLine = YES;
    configration.bottomLineBgColor = MGSepColor;
    
    
    YNPageScrollViewController *vc = [YNPageScrollViewController pageScrollViewControllerWithControllers:[self getViewController] titles:[self getViewControllerTitle] Configration:configration];
    
    vc.dataSource = self;
    vc.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
    
    
}

- (NSArray *)getViewController {
    
    MGMyCouponBaseVC *vc1 = [MGMyCouponBaseVC new];
    vc1.state = 50;
    
    MGMyCouponBaseVC *vc2 = [MGMyCouponBaseVC new];
    vc2.state = -1;
    
    MGMyCouponBaseVC *vc3 = [MGMyCouponBaseVC new];
    vc3.state = 0;
    
    return @[vc1, vc2, vc3];
}

- (NSArray *)getViewControllerTitle {
    
    return @[@"未使用", @"已过期", @"已使用"];
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate
#pragma mark pageScrollViewControllerDelegate
- (UITableView *)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewForIndex:(NSInteger)index{
    
    MGMyCouponBaseVC *VC= (MGMyCouponBaseVC *)pageScrollViewController.currentViewController;
    return [VC tableView];
    
};
#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter




@end
