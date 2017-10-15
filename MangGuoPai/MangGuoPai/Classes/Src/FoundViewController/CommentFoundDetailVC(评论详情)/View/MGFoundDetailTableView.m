//
//  MGFoundDetailTableView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/3.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGFoundDetailTableView.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "MGResTrendListModel.h"
#import "MGFoundCell.h"
#import "MGFoundDetailCommentCell.h"

@implementation MGFoundDetailTableView


- (void)prepareUI {
    
    self.emptyDataSetShouldDisplay = NO;

}


#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.0001;
    }
    
    return SH(20);
    
}
//header-secion
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

//footer-hegiht
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

//footer-section
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}


//sections-tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArrayM.count;
}
//rows-section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MGResTrendListDataModel *dataModel = self.dataArrayM[section];
    return dataModel.comments.count + 1;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MGResTrendListDataModel *dataModel = self.dataArrayM[indexPath.section];
    switch (indexPath.row) {
        case 0:
        {
            NSString *state = @"unopen";
            if (dataModel.shouldShowMoreButton) { // 如果文字大于50字
                if (dataModel.isOpening) { /// 是否需要展开
                    state =  @"open";
                }
            }
            
            return [MGFoundCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                MGFoundCell *cell = (MGFoundCell *)sourceCell;
                // 配置数据
                cell.dataModel = dataModel;
            } cache:^NSDictionary *{
                return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%ld", dataModel.id],
                         kHYBCacheStateKey : state};
            }];
        }
            
        default: /// 加了底部 15
        {
            return [MGFoundDetailCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                MGFoundDetailCommentCell *cell = (MGFoundDetailCommentCell *)sourceCell;
                // 配置数据
                cell.dataModel = dataModel.comments[indexPath.row - 1];
            }] + SH(30);
            
        }
    }
    
    
    
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            
            MGFoundCell *cell = (MGFoundCell *)[tableView cellWithCellClass:[MGFoundCell class]];
            cell.indexPath = indexPath;
            cell.showAllContentTextBlock = _showAllContentTextBlock;
            cell.showAllContentTextForwardBlock = _showAllContentTextForwardBlock;
            cell.forwardBgViewTapBlock = _forwardBgViewTapBlock;
            /// 收藏
            cell.favEventBlock = _favEventBlock;
            /// 点击工具条
            cell.tapButtonBlock = _tapButtonBlock;
            cell.dataModel = self.dataArrayM[indexPath.row];
            return cell;
        }
        default:
        {
            MGFoundDetailCommentCell *cell = (MGFoundDetailCommentCell *)[tableView cellWithCellClass:[MGFoundDetailCommentCell class]];
            MGResTrendListDataModel *dataModel = self.dataArrayM[0];
            cell.isSelfTrend = dataModel.isSelfTrend;
            cell.replyCommentBlock = _replyCommentBlock;
            cell.indexPath = indexPath;
            cell.showTopLine = indexPath.row - 1 == 0;
            cell.showBottomLine = indexPath.row != dataModel.comments.count;
            cell.dataModel = dataModel.comments[indexPath.row - 1];
            return cell;
        }
    }
    return nil;
}

@end
