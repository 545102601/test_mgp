//
//  MGWorkLookProductVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/15.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkLookProductVC.h"
#import "MGWorkWriteCommentVC.h"
#import "MGWorkLookProductTableView.h"
#import "MGWorkLookOtherVC.h"

@interface MGWorkLookProductVC ()

@property (nonatomic, strong) MGWorkLookProductTableView *tableView;

@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation MGWorkLookProductVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = [NSString stringWithFormat:@"%@的作品", self.actorModel.actor_name];
    _rightButton = [self setRightButtonWithTitle:@"写评价" target:self selector:@selector(rightButtonOnClick)];
    _rightButton.hidden = YES;
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    WEAK
    _tableView = [[MGWorkLookProductTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    
    _tableView.lookOtherFileButtonBlock = ^{
      STRONG
        MGWorkLookOtherVC *vc = [MGWorkLookOtherVC new];
        vc.actorModel = self.tableView.actorDataModel;
        PushVC(vc)
    };
    
    
}

#pragma mark - 加载数据
- (void)loadData {
    
    [TDLoading showViewInKeyWindow];
    _tableView.hidden = YES;
    [MGBussiness loadProject_Actor_Get:@{@"id" : @(self.actorModel.id)} completion:^(MGResProjectActorDataModel *actorDataModel) {
         [TDLoading hideViewInKeyWindow];
        
        _tableView.actorDataModel = actorDataModel;
        
        _rightButton.hidden = actorDataModel.company_comments.length == 0 ? NO : YES;
        
        _tableView.hidden = NO;
        [_tableView reloadData];
        
    } error:nil];
}


#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

- (void)rightButtonOnClick {
    
    MGWorkWriteCommentVC *vc = [MGWorkWriteCommentVC new];
    vc.actorModel = self.tableView.actorDataModel;
    WEAK
    vc.completionBlock = ^(NSString *comment){
        STRONG
        self.rightButton.hidden = YES;
        self.tableView.actorDataModel.company_comments = comment;
         [self.tableView reloadData];
    };
    PushVC(vc)
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter



@end
