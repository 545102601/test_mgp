//
//  MGAccountVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/27.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGAccountVC.h"
#import "MGAccountTableView.h"
#import "MGAccountTableHeader.h"
#import "MGAccountModel.h"
#import "MGAccountTableModel.h"
#import "MGAccountBlankListVC.h"
#import "MGAccountWithDrawVC.h"
#import "MGAccountBlankDetailVC.h"

@interface MGAccountVC ()

@property (nonatomic, strong) MGAccountTableHeader *headerView;

@property (nonatomic, strong) MGAccountTableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArrayM;


@end

@implementation MGAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的账户";
    
}


- (void)initData {
    
    MGAccountTableModel *model1 = [MGAccountTableModel new];
    model1.titleName = @"我的银行卡";
    model1.iconName = @"account_iocn_card";
    
    
    MGAccountTableModel *model2 = [MGAccountTableModel new];
    model2.titleName = @"提现";
    model2.iconName = @"account_iocn_tixian";
    
    MGAccountTableModel *model3 = [MGAccountTableModel new];
    model3.titleName = @"交易明细";
    model3.iconName = @"account_iocn_jiaoyi";
    
    _dataArrayM = @[model1, model2, model3].mutableCopy;
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    WEAK
    _headerView = [[MGAccountTableHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(380))];
    
    _tableView = [[MGAccountTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    
    _tableView.tableHeaderView = _headerView;
    _tableView.dataArrayM = self.dataArrayM;
    [self.view addSubview:_tableView];
    
    _tableView.didSelectedRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
        STRONG
        switch (indexPath.row) {
            case 0:
            {
                MGAccountBlankListVC *vc = [MGAccountBlankListVC new];
                PushVC(vc)
                
            }
                break;
            case 1:
            {
                MGAccountBlankDetailVC *vc = [MGAccountBlankDetailVC new];
                PushVC(vc)
            }
                break;
            case 2:
            {
                MGAccountWithDrawVC *vc = [MGAccountWithDrawVC new];
                PushVC(vc)
            }
                break;
        }
    };
}

#pragma mark - 加载数据
- (void)loadData {
    
    _tableView.hidden = YES;
    
    [MGBussiness loadMemberWalletWithCompletion:^(MGAccountDataModel *dataModel) {
        
        self.headerView.dataModel = dataModel;
        
        _tableView.hidden = NO;
        
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
