//
//  MGMyFoundVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMyFoundVC.h"
#import "YNPageScrollViewController.h"
#import "MGCommonSegmentView.h"
#import "MGFoundViewController.h"
#import "MGPublishFoundVC.h"

@interface MGMyFoundVC ()<YNPageScrollViewControllerDataSource, YNPageScrollViewControllerDelegate>

@property (nonatomic, strong) MGCommonSegmentView *segmentView;

@property (nonatomic, weak) YNPageScrollViewController *pageScrollViewVC;

@end

@implementation MGMyFoundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRightButtonWithTitle:@"+动态" target:self selector:@selector(rightButtonOnClick)];
}


#pragma mark - 初始化控件
- (void)setupSubViews {
    
    _segmentView = [[MGCommonSegmentView alloc] initWithFrame:CGRectMake(0, 0, 230, 31)];
    _segmentView.leftTitle = @"我发的动态";
    _segmentView.rightTitle = @"我回复的动态";
    _segmentView.centerX = kScreenWidth * 0.5;
    _segmentView.centerY = self.backBtn.centerY;
    WEAK
    _segmentView.buttonOnClickBlock = ^(UIButton *button) {
        STRONG
        [self.pageScrollViewVC setPageScrollViewMenuSelectPageIndex:button.tag - 1 animated:NO];
        
    };
    [self.navigationBar addSubview:_segmentView];
    
    YNPageScrollViewController *vc = [self pageScrollViewControllerWithSelectIndex:0];
    vc.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
    _pageScrollViewVC = vc;
    
    
}

///
- (YNPageScrollViewController *)pageScrollViewControllerWithSelectIndex:(NSInteger)selectIndex{
    
    
    //配置信息s
    YNPageScrollViewMenuConfigration *configration = [[YNPageScrollViewMenuConfigration alloc]init];
    configration.scrollViewBackgroundColor = [UIColor redColor];
    configration.itemLeftAndRightMargin = 30;
    configration.lineColor = [UIColor orangeColor];
    configration.lineHeight = 2;
    configration.pageScrollViewMenuStyle = YNPageScrollViewMenuStyleNavigation;
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    configration.selectedItemColor = [UIColor redColor];
    configration.showConver = YES;
    
    
    YNPageScrollViewController *vc = [YNPageScrollViewController pageScrollViewControllerWithControllers:[self getViewController] titles:@[@"1",@"2"] Configration:configration];
    vc.pageIndex = selectIndex;
    vc.dataSource = self;
    vc.delegate = self;
    /// 禁止滚动
    vc.parentScrollView.scrollEnabled = YES;
    return vc;
}


- (NSArray *)getViewController {
    
    MGFoundViewController *vc1 = [MGFoundViewController new];
    vc1.externRequestParams = @{@"is_my_send" : @(1)};
    
    MGFoundViewController *vc2 = [MGFoundViewController new];
    vc2.externRequestParams = @{@"is_my_reply" : @(1)};
    return @[vc1, vc2];
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// +动态
/// 右边按钮
- (void)rightButtonOnClick {
    
    MGPublishFoundVC *vc = [MGPublishFoundVC new];
    //    WEAK
    vc.publishCompletionBlock = ^{
        //        STRONG
        //        [self.tableView.mj_header beginRefreshing];
    };
    PushVC(vc)
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

#pragma mark - YNPageScrollViewDelegate

- (UITableView *)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewForIndex:(NSInteger)index{
    
    MGFoundViewController *VC= (MGFoundViewController *)pageScrollViewController.currentViewController;
    return [VC tableView];
    
};


- (void)pageScrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self.segmentView setSelectedButtonWithTag:self.pageScrollViewVC.pageIndex + 1];
    
}



@end
