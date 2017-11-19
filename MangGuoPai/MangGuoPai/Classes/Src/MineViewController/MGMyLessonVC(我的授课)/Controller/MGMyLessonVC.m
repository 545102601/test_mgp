//
//  MGMyLessonVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/1.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMyLessonVC.h"
#import "YNPageScrollViewController.h"
#import "MGCommonSegmentView.h"
#import "MGMyLessonAllVC.h"
#import "MGMyLessonPublishVC.h"
#import "MGAddLessonVC.h"

@interface MGMyLessonVC ()<YNPageScrollViewControllerDataSource, YNPageScrollViewControllerDelegate>

@property (nonatomic, strong) MGCommonSegmentView *segmentView;

@property (nonatomic, weak) YNPageScrollViewController *pageScrollViewVC;


@end

@implementation MGMyLessonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRightButtonWithTitle:@"+授课" target:self selector:@selector(addClassButtonOnClick)];
}
#pragma mark - 初始化控件
- (void)setupSubViews {
    
    _segmentView = [[MGCommonSegmentView alloc] initWithFrame:CGRectMake(0, 0, 230, 31)];
    _segmentView.leftTitle = @"所有授课";
    _segmentView.rightTitle = @"上架的授课";
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
    
    MGMyLessonAllVC *sendVC = [MGMyLessonAllVC new];
    sendVC.menuTag = MGGlobaMenuTagLeft;
    
    MGMyLessonPublishVC *receiveVC = [MGMyLessonPublishVC new];
    receiveVC.menuTag = MGGlobaMenuTagRight;
    return @[sendVC, receiveVC];
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// +授课
- (void)addClassButtonOnClick {
    MGAddLessonVC *vc = [MGAddLessonVC new];
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
    
    MGMyLessonBaseVC *VC= (MGMyLessonBaseVC *)pageScrollViewController.currentViewController;
    return [VC tableView];
    
};


- (void)pageScrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self.segmentView setSelectedButtonWithTag:self.pageScrollViewVC.pageIndex + 1];
    
}


@end
