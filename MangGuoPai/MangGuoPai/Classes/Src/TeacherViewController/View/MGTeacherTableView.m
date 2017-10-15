//
//  MGTeacherTableView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/17.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherTableView.h"
#import "MGTeacherAdvertCell.h"
#import "MGTeacherFunctionCell.h"
#import "MGTeacherRecommendCell.h"
#import "MGTeacherRecommendSectionHeader.h"


@interface MGTeacherTableView ()

@end

@implementation MGTeacherTableView

- (void)prepareUI {

    self.emptyDataSetShouldDisplay = NO;
    [self registerClass:[MGTeacherRecommendSectionHeader class] forHeaderFooterViewReuseIdentifier:@"MGTeacherRecommendSectionHeaderID"];
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 0.0001;
    }
    if (section == 2 && self.recommendArray.count > 0) {
        return SH(100);
    }
    
    return 0.0001;
    
}
//header-secion
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 2 && self.recommendArray.count > 0) {
        MGTeacherRecommendSectionHeader *recHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MGTeacherRecommendSectionHeaderID"];
        return recHeader;
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
    
    return 3;
}
//rows-section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return self.adverArray.count > 0 ? 1 : 0;
        case 1:
            return self.functionArray.count > 0 ? 1 : 0;
        case 2:
            return self.recommendArray.count > 0 ? self.recommendArray.count : 0;
    }
    return 0;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0: /// Advert
            return SH(750);
        case 1: /// function
            if (_functionArray.count > 4) {
                return SW(280);
            } else {
                return SW(150);
            }
        case 2: /// recommend
            return kMGTeacherRecommendCellHeight;
    }
    return 0;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.section) {
        case 0: /// 广告
        {
            MGTeacherAdvertCell *cell = (MGTeacherAdvertCell *)[tableView cellWithCellClass:[MGTeacherAdvertCell class]];
            cell.dataArray = self.adverArray;
            cell.advertCellDidSelectedBlock = _advertCellDidSelectedBlock;
            return cell;
        }
        case 1: /// 小功能
        {
            MGTeacherFunctionCell *cell = (MGTeacherFunctionCell*)[tableView cellWithCellClass:[MGTeacherFunctionCell class]];
            cell.dataArray = self.functionArray;
            cell.didCellItemBlock = _functionDidCellItemBlock;
            return cell;
        }
            
        case 2: /// 推荐
        {
            MGTeacherRecommendCell *cell = (MGTeacherRecommendCell *)[tableView cellWithCellClass:[MGTeacherRecommendCell class]];
            cell.model = self.recommendArray[indexPath.row];
            cell.iconImageTapBlock = _iconImageTapBlock;
            return cell;
        }
            break;
            
    }
    return nil;
}


@end
