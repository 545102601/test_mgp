//
//  MGAccountBlankListVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/28.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGAccountBlankListVC.h"
#import "MGAccountBlankListTableView.h"
#import "MGAccountAddBlankVC.h"
#import "MGAccountBlankListModel.h"


@interface MGAccountBlankListVC ()

@property (nonatomic, strong) MGAccountBlankListTableView *tableView;

@property (nonatomic, strong) UIButton *addBlankButton;

@end

@implementation MGAccountBlankListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的银行卡";
    
}


#pragma mark - 初始化控件
- (void)setupSubViews {
    
    _tableView = [[MGAccountBlankListTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - SH(100)) style:UITableViewStyleGrouped];

    [self.view addSubview:_tableView];
    
    
    _addBlankButton = [MGUITool buttonWithBGColor:nil title:@"+添加银行卡" titleColor:MGThemeColor_Title_Black font:MGThemeFont_30 target:self selector:@selector(addBlankButtonOnClick)];
    [_addBlankButton setBackgroundImage:[UIImage imageWithColor:MGButtonBlankDefaultColor] forState:UIControlStateNormal];
    [_addBlankButton setBackgroundImage:[UIImage imageWithColor:MGButtonBlankHighLightedColor] forState:UIControlStateHighlighted];
    
    _addBlankButton.frame = CGRectMake(0, kScreenHeight - SH(100), kScreenWidth, SH(100));
    
    [self.view addSubview:_addBlankButton];
    
}

#pragma mark - 加载数据
- (void)loadData {
    
    [MGBussiness loadCardListCompletion:^(NSArray *array) {
        self.tableView.dataArrayM = array.mutableCopy;
        [self.tableView reloadData];
        
    } error:nil];
    
}


#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 添加银行卡
- (void)addBlankButtonOnClick {
    
    MGAccountAddBlankVC *vc = [MGAccountAddBlankVC new];
    PushVC(vc)
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter



@end
