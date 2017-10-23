//
//  MGCommentFoundDetailVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/24.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGFoundDetailVC.h"
#import "MGResTrendListModel.h"
#import "MGFoundDetailTableView.h"
#import "MGFoundCommentPublisherVC.h"
#import "MGReverseFoundVC.h"
#import "MGFoundCell.h"

@interface MGFoundDetailVC ()

@property (nonatomic, strong) MGFoundDetailTableView *tableView;

@end

@implementation MGFoundDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
#pragma mark - 初始化控件
- (void)setupSubViews {
    WEAK
    _tableView = [[MGFoundDetailTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    
    [self.view addSubview:_tableView];
    
    /// 收藏
    _tableView.favEventBlock = ^(MGResTrendListDataModel *dataModel, NSIndexPath *indexPath){
        STRONG
        InterceptLoginShowAlert
        MGFoundCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self favFoundCell:cell dataModel:dataModel];
    };
    
    /// 全文显示
    _tableView.showAllContentTextBlock = ^(NSIndexPath *indexPath){
        STRONG
        MGResTrendListDataModel *dataModel = self.tableView.dataArrayM[indexPath.section];
        dataModel.isOpening = YES;
        [UIView performWithoutAnimation:^{
            [self.tableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
        }];
    };
    /// 转发全文显示
    _tableView.showAllContentTextForwardBlock = ^(NSIndexPath *indexPath){
        STRONG
        MGResTrendListDataModel *dataModel = self.tableView.dataArrayM[indexPath.section];
        dataModel.forward_trend.isOpening = YES;
        [UIView performWithoutAnimation:^{
            [self.tableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
        }];
    };
    _tableView.forwardBgViewTapBlock = ^(MGResTrendListDataModel *dataModel){
        STRONG
        MGFoundDetailVC *vc = [MGFoundDetailVC new];
        vc.dataModel = dataModel;
        PushVC(vc)
    };
    
    /// 回复评论
    _tableView.replyCommentBlock = ^(NSIndexPath *indexPath, MGResFoundDetailCommentDataModel *dataModel){
        STRONG
        InterceptLoginShowAlert
        MGResTrendListDataModel *trendDataModel = self.tableView.dataArrayM[indexPath.section];
        MGFoundCommentPublisherVC *vc = [MGFoundCommentPublisherVC new];
        vc.publisherType = CommentPublisherTypeComment;
        vc.trend_id = trendDataModel.id;
        vc.comment_id = dataModel.id;
        
        vc.publishCompletionBlock = ^{
          STRONG
            [self loadData];
        };
        
        PushVC(vc);
    };
    
    /// 点击工具条
    _tableView.tapButtonBlock = ^(NSInteger type, MGResTrendListDataModel *dataModel, NSIndexPath *indexPath){
        STRONG
        InterceptLoginShowAlert
        MGFoundCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        switch (type) {
            case 0:  /// 转发
            {
                MGReverseFoundVC *vc = [MGReverseFoundVC new];
                vc.dataModel = dataModel;
                PushVC(vc)
            }
                break;
            case 1:  /// 详情
            {
                MGResTrendListDataModel *trendDataModel = self.tableView.dataArrayM[indexPath.section];
                MGFoundCommentPublisherVC *vc = [MGFoundCommentPublisherVC new];
                vc.trend_id = trendDataModel.id;
                PushVC(vc);
            }
                break;
            case 2: /// 点赞
            {
                [self praiseFoundCell:cell dataModel:dataModel];
            }
                break;
        }
    };
}

#pragma mark - 加载数据
- (void)loadData {
    
    long resultId = self.id > 0 ? self.id : self.dataModel.id;
    
    [MGBussiness loadTrend_GetWithParams:@{@"id" : @(resultId)} completion:^(MGResTrendListDataModel *dataModel) {
        if (dataModel) {
            self.title = dataModel.publisher_name;
            NSMutableArray *dataArrayM = @[dataModel].mutableCopy;
            
            self.tableView.dataArrayM = dataArrayM;
            [self.tableView reloadData];
        }
        
    } error:nil];
    
}


/// 收藏
- (void)favFoundCell:(MGFoundCell *)cell dataModel:(MGResTrendListDataModel *)dataModel {
    
    [MGBussiness loadWantCountWithParams:@{@"entity_id" : @(dataModel.id) , @"entity_type_id" : @(MGGlobalEntityTypeFriend)} completion:^(id results) {
        
        if ([results boolValue]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:FoundDetailPariseAndFavRefreshView object:nil userInfo:@{@"id" : @(dataModel.id), @"type" : @"fav"}];
            
            [cell.cellInfoView setFavIsCollection:YES];
        }
        
    } error:nil];
    
}

/// 点赞
- (void)praiseFoundCell:(MGFoundCell *)cell dataModel:(MGResTrendListDataModel *)dataModel {
    
    [MGBussiness loadPraiseWithParams:@{@"id" : @(dataModel.id)} completion:^(id results) {
        if ([results boolValue]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:FoundDetailPariseAndFavRefreshView object:nil userInfo:@{@"id" : @(dataModel.id), @"type" : @"parise"}];
            
            [cell.toolsView setLiked:YES withAnimation:YES];
        }
    } error:nil];
    
    
}

@end
