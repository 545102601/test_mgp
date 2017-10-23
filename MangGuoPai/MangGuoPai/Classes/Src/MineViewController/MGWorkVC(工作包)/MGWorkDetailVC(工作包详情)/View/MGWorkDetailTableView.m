//
//  MGWorkDetailTableView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkDetailTableView.h"
#import "MGWorkDetailProgressCell.h"
#import "MGWorkDetailExplanationCell.h"
#import "MGWorkDetailMoneyCell.h"
#import "MGWorkDetailIntroCell.h"
#import "MGWorkProductCommentCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "MGTeacherRecommendCell.h"
#import "MGTeacherRecommendSectionHeader.h"
#import "MGWorkDetailApplyTeamSectionHeader.h"
#import "MGWorkDetailApplyTeamCell.h"
#import "MGWorkProductCommentSectionHeader.h"
#import "MGResProjectActorModel.h"

@implementation MGWorkDetailTableView

- (void)prepareUI {
    
    self.emptyDataSetShouldDisplay = NO;
    
    [self registerClass:[MGTeacherRecommendSectionHeader class] forHeaderFooterViewReuseIdentifier:@"MGTeacherRecommendSectionHeaderID"];
    
    [self registerClass:[MGWorkDetailApplyTeamSectionHeader class] forHeaderFooterViewReuseIdentifier:@"MGWorkDetailApplyTeamSectionHeaderID"];
    
    [self registerClass:[MGWorkProductCommentSectionHeader class] forHeaderFooterViewReuseIdentifier:@"MGWorkProductCommentSectionHeaderID"];
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return SH(20);
    } else if (section == 1 || section == 2 || section == 3 ) {
        return SH(4);
    } else if (section == 4) {
        return self.dataModel.productionAndCommentArray.count > 0 ? KMGWorkProductCommentSectionHeaderHeight : 0.0001;
    } else if (section == 5) {
        if (memberDataModelInstance.isCompanyID) {
            return self.dataModel.actors.count > 0 ? kMGWorkDetailApplyTeamSectionHeaderHeight : 0.0001;
        }
    } else if (section == 6) {
        return self.dataModel.courses.count > 0 ? SH(84) : 0.0001;
    }
    return 0.0001;
    
}
//header-secion
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 4) {
        if (self.dataModel.productionAndCommentArray.count > 0) {
            MGWorkProductCommentSectionHeader *recHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MGWorkProductCommentSectionHeaderID"];
            recHeader.section = section;
            recHeader.dataModel = self.dataModel;
            recHeader.expendButtonBlock = ^(NSInteger section){
                [UIView performWithoutAnimation:^{
                    [self reloadSection:section withRowAnimation:UITableViewRowAnimationNone];
                }];
            };
            return recHeader;
        }
    }
    else if (section == 5) {
        if (memberDataModelInstance.isCompanyID) {
            if (self.dataModel.actors.count > 0) {
                MGWorkDetailApplyTeamSectionHeader *recHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MGWorkDetailApplyTeamSectionHeaderID"];
                recHeader.section = section;
                recHeader.dataModel = self.dataModel;
                recHeader.expendButtonBlock = ^(NSInteger section){
                    [UIView performWithoutAnimation:^{
                        [self reloadSection:section withRowAnimation:UITableViewRowAnimationNone];
                    }];
                };
                return recHeader;
            }
        }
        
    }
    else if (section == 6) {
        if (self.dataModel.courses.count > 0) {
            MGTeacherRecommendSectionHeader *recHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MGTeacherRecommendSectionHeaderID"];
            return recHeader;
        };
    }
    
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
    if (!self.dataModel) return 0;
    return 7;
}
//rows-section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 4) {
        if (!self.dataModel.commentIsExpend) {
            return 0;
        }
        return self.dataModel.productionAndCommentArray.count;
        
    } else if (section == 5) {
        if (memberDataModelInstance.isCompanyID) {
            if (!self.dataModel.teamIsExpend) {
                return 0;
            }
            return self.dataModel.actors.count;
        }
        return 0;
    } else if (section == 6) {
        return self.dataModel.courses.count;
    }
    return 1;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    switch (section) {
        case 0:
            return SH(365);
        case 1:
            return [MGWorkDetailExplanationCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                MGWorkDetailExplanationCell *cell = (MGWorkDetailExplanationCell *)sourceCell;
                // 配置数据
                cell.dataModel = self.dataModel;
            } cache:^NSDictionary *{
                return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%ld", self.dataModel.id],
                         kHYBCacheStateKey : @"stateKey"};
            }];
        case 2:
            return self.dataModel.prizesCellHeight;
        case 3:
            return self.dataModel.entryCellHeight;
        case 4:
        {
           
            CGFloat height = [MGWorkProductCommentCell hyb_heightForTableView:tableView
                                                                       config:^(UITableViewCell *sourceCell) {
                                                                           MGResProjectActorDataModel *actorDataModel = self.dataModel.productionAndCommentArray[indexPath.row];
                                                                           ((MGWorkProductCommentCell *)sourceCell).actorModel = actorDataModel;
                                                                       }] + SH(30);
            return height;
        }
        case 5:
            return indexPath.row == self.dataModel.actors.count - 1 ? kMGWorkDetailApplyTeamCellHeight + SH(20) : kMGWorkDetailApplyTeamCellHeight;
        case 6:
            return kMGTeacherRecommendCellHeight;
    }
    return 0;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    switch (section) {
        case 0:
        {
            MGWorkDetailProgressCell *cell  = (MGWorkDetailProgressCell *)[tableView cellWithCellClass:[MGWorkDetailProgressCell class]];
            cell.dataModel = self.dataModel;
            return cell;
        }
        case 1:
        {
            MGWorkDetailExplanationCell *cell  = (MGWorkDetailExplanationCell *)[tableView cellWithCellClass:[MGWorkDetailExplanationCell class]];
            cell.dataModel = self.dataModel;
            return cell;
        }
        case 2:  ///
        {
            MGWorkDetailMoneyCell *cell = (MGWorkDetailMoneyCell *)[tableView cellWithCellClass:[MGWorkDetailMoneyCell class]];
            cell.expendButtonBlock = _expendButtonBlock;
            cell.indexPath = indexPath;
            cell.dataModel = self.dataModel;
            return cell;
        }
        case 3:  ///
        {
            MGWorkDetailIntroCell *cell = (MGWorkDetailIntroCell *)[tableView cellWithCellClass:[MGWorkDetailIntroCell class]];
            cell.expendButtonBlock = _expendButtonBlock;
            cell.indexPath = indexPath;
            cell.dataModel = self.dataModel;
            return cell;
        }
        case 4:  /// 作品评论
        {
            MGWorkProductCommentCell *cell = (MGWorkProductCommentCell *)[tableView cellWithCellClass:[MGWorkProductCommentCell class]];
            cell.lookOtherFileButtonBlock = _lookOtherFileButtonBlock;
            cell.indexPath = indexPath;
            cell.actorModel = self.dataModel.productionAndCommentArray[indexPath.row];
            return cell;
        }
        case 5:   /// 报名团队
        {
            MGWorkDetailApplyTeamCell *cell = (MGWorkDetailApplyTeamCell *)[tableView cellWithCellClass:[MGWorkDetailApplyTeamCell class]];
            cell.applyTeamCommentBlock = _applyTeamCommentBlock;
            cell.applyTeamProductBlock = _applyTeamProductBlock;
            cell.actorModel = self.dataModel.actors[indexPath.row];
            return cell;
        }
        case 6:   /// 课程推介
        {
            MGTeacherRecommendCell *cell = (MGTeacherRecommendCell *)[tableView cellWithCellClass:[MGTeacherRecommendCell class]];
            cell.model = self.dataModel.courses[indexPath.row];
            cell.iconImageTapBlock = _iconImageTapBlock;
            return cell;
        }
    }
    
    return nil;
    
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
