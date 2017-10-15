//
//  MGTeacherCategoryDetailVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/23.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherCategoryDetailVC.h"
#import "YNPageScrollViewController.h"
#import "MGTeacherCategoryBaseDetailVC.h"

@interface MGTeacherCategoryDetailVC ()<YNPageScrollViewControllerDataSource>

@end

@implementation MGTeacherCategoryDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    if (self.selectedIndex == kSelectedParentCategory) {
        self.title = self.dataModel.classify_name;
    } else {
        MGResClassifyDataModel *detailModel = self.dataModel.details[self.selectedIndex];
        self.title = detailModel.classify_name;
    }
    
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
    configration.menuHeight = SH(0);
    configration.itemLeftAndRightMargin = SW(26);
    configration.lineColor = MGThemeShenYellowColor;
    configration.lineHeight = 2;
    configration.pageScrollViewMenuStyle = YNPageScrollViewMenuStyleTop;
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    configration.selectedItemColor = MGThemeShenYellowColor;
    configration.normalItemColor = MGThemeColor_Common_Black;
    configration.itemFont = PFSC(30);
    configration.itemMargin = SW(60);
    
    YNPageScrollViewController *vc = [YNPageScrollViewController pageScrollViewControllerWithControllers:[self getViewController] titles:[self getViewControllerTitle] Configration:configration];
    
    
//    NSInteger selectedIndex = self.selectedIndex;
//    if (selectedIndex == self.dataModel.details.count - 1) {
//        selectedIndex = 0;
//    } else {
//        selectedIndex += 1;
//    }
    
//    vc.pageIndex = selectedIndex;
    vc.dataSource = self;
    vc.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
}

- (NSArray *)getViewController {
    
    NSMutableArray *arrayM = @[].mutableCopy;
    
    /// 选择父类
    if (self.selectedIndex == kSelectedParentCategory) {
        MGTeacherCategoryBaseDetailVC *vc = [MGTeacherCategoryBaseDetailVC new];
        vc.detailModel = self.dataModel;
        [arrayM addObject:vc];
        return arrayM;
    }
    
    for (int i = 0; i < self.dataModel.details.count; i++) {
        MGResClassifyDataModel *detailModel = self.dataModel.details[i];
        MGTeacherCategoryBaseDetailVC *vc = [MGTeacherCategoryBaseDetailVC new];
        vc.detailModel = detailModel;
        
        
        if (self.selectedIndex == i) {
            [arrayM addObject:vc];
            break;
        }
        
//        if (i < self.dataModel.details.count - 1) {
//            [arrayM addObject:vc];
//        } else {
//            [arrayM insertObject:vc atIndex:0];
//        }
    }
    
    
    
    return arrayM;
}
- (NSArray *)getViewControllerTitle {
    NSMutableArray *arrayM = @[].mutableCopy;
    /// 选择父类
    if (self.selectedIndex == kSelectedParentCategory) {
        MGTeacherCategoryBaseDetailVC *vc = [MGTeacherCategoryBaseDetailVC new];
        vc.detailModel = self.dataModel;
        [arrayM addObject:self.dataModel.classify_name];
        return arrayM;
    }
    for (int i = 0; i < self.dataModel.details.count; i++) {
        MGResClassifyDataModel *detailModel = self.dataModel.details[i];

        if (self.selectedIndex == i) {
            [arrayM addObject:detailModel.classify_name];
            break;
        }
        
//        if (i < self.dataModel.details.count - 1) {
//            [arrayM addObject:detailModel.classify_name];
//        } else {
//            [arrayM insertObject:detailModel.classify_name atIndex:0];
//        }
    }
     return arrayM;
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate
#pragma mark pageScrollViewControllerDelegate
- (UITableView *)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewForIndex:(NSInteger)index{
    
    MGTeacherCategoryBaseDetailVC *VC= (MGTeacherCategoryBaseDetailVC *)pageScrollViewController.currentViewController;
    return [VC tableView];
    
};
#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter


@end
