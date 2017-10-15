//
//  MGWorkTeamVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/13.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkTeamVC.h"
#import "MGWorkTeamHeaderView.h"
#import "MGWorkTeamTableView.h"
#import "MGResProjectTeamModel.h"

@interface MGWorkTeamVC ()

@property (nonatomic, strong) MGWorkTeamHeaderView *headerView;

@property (nonatomic, strong) MGWorkTeamTableView *tableView;

@end

@implementation MGWorkTeamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"团队";
    [self setNavigationBarGrayAndBlackBackButton];
    
    
}


#pragma mark - 初始化控件
- (void)setupSubViews {
    
    _headerView = [[MGWorkTeamHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    
    _tableView = [[MGWorkTeamTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    
    
    [self.view sd_addSubviews:@[_headerView, _tableView]];
    
}

#pragma mark - 加载数据
- (void)loadData {

    _headerView.hidden = YES;
    _tableView.hidden = YES;
    
    [MGBussiness loadActor_Team_Get:@{@"id" : @(self.dataModel.actor_member_id)} completion:^(MGResProjectTeamDataModel *dataModel) {
        _headerView.hidden = NO;
        _tableView.hidden = NO;
        
        _headerView.dataModel = dataModel;
        
        _tableView.tableHeaderView = _headerView;
        
        _tableView.dataArrayM = dataModel.members.mutableCopy;
        [_tableView reloadData];
    } error:nil];
    
}


#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

@end
