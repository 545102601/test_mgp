//
//  MGTeacherAllCategoryVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherAllCategoryVC.h"
#import "MGTeacherAllCategoryTableView.h"
#import "MGHomeSearchBarView.h"
#import "MGTeacherCategoryDetailVC.h"
#import "MGSearchResultVC.h"

@interface MGTeacherAllCategoryVC ()
/// 搜索框
@property (nonatomic, strong) MGHomeSearchBarView *searchBarView;
/// 我的授课
@property (nonatomic, strong) UIButton *rightNavButton;

@property (nonatomic, strong) MGTeacherAllCategoryTableView *tableView;

@end

@implementation MGTeacherAllCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarYellowAndWhiteBackButton];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    BOOL isShow = memberDataModelInstance.isTutorID;
    _rightNavButton.hidden = !isShow;
    
    _searchBarView.left = isShow ? _rightNavButton.left - SW(500) - SW(20) : (kScreenWidth - SW(500)) *0.5;
    
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    WEAK

    _rightNavButton = [MGUITool buttonWithNorBgImage:nil selBgImage:nil norImage:nil selImage:nil target:self selector:@selector(rightNavButtonOnClick)];
    _rightNavButton.titleLabel.font = PFSC(28);
    [_rightNavButton setTitle:@"我的授课" forState:UIControlStateNormal];
    [_rightNavButton setTitleColor:MGThemeColor_Title_Black forState:UIControlStateNormal];
    [_rightNavButton sizeToFit];
    _rightNavButton.left = kScreenWidth - _rightNavButton.width - SW(20);
    
    _searchBarView = [[MGHomeSearchBarView alloc] initWithFrame:CGRectMake(_rightNavButton.left- SW(500) - SW(20), 25, SW(500), 31)];
    /// 点击搜索框
    
    _searchBarView.searchEventBlock = ^(NSString *text){
        STRONG
        MGSearchResultVC *vc = [MGSearchResultVC new];
        vc.searchText = text;
        self.searchBarView.searchText = @"";
        PushVC(vc)
    };
    
    _rightNavButton.centerY = _searchBarView.centerY;
    
    
    [self.navigationBar sd_addSubviews:@[_rightNavButton, _searchBarView]];
    
    _tableView = [[MGTeacherAllCategoryTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    
    _tableView.dataArrayM = self.dataArray.mutableCopy;
    
    
    /// 选择 item
    _tableView.categoryDidCellItemBlock = ^(NSInteger tableSection, NSInteger colletionItem) {
        STRONG
        
        MGTeacherCategoryDetailVC *vc = [MGTeacherCategoryDetailVC new];
        vc.dataModel = self.tableView.dataArrayM[tableSection];
        vc.selectedIndex = colletionItem;
        
        PushVC(vc)
        
        
    };
    
    
    
}

#pragma mark - 加载数据
- (void)loadData {
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 我的授课
- (void)rightNavButtonOnClick {
    
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

@end
