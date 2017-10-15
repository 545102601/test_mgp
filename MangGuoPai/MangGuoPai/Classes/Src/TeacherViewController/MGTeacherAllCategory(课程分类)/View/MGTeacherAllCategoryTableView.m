//
//  MGTeacherAllCategoryTableView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherAllCategoryTableView.h"
#import "MGTeacherAllCategoryCell.h"
#import "MGHomeBottomTipCell.h"

@interface MGTeacherAllCategoryTableView ()

@end

@implementation MGTeacherAllCategoryTableView


- (void)prepareUI {

    self.emptyDataSetShouldDisplay = NO;
    
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.0001;
    }
    if (section == self.dataArrayM.count - 1) {
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
    if (self.dataArrayM.count > 0) {
        return self.dataArrayM.count;
    }
    return 0;
}
//rows-section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < self.dataArrayM.count - 1) {
        MGResClassifyDataModel *dataModel = self.dataArrayM[indexPath.section];
        /// 求出 colletionView 的高度
        NSInteger row = ceil(dataModel.details.count / 3.0);
        if (row > 0) {
            CGFloat height = SH(60) + (row - 1) * SH(50) + PFSC(24).lineHeight * row + SH(80);
            return height;
        }
    } else if (indexPath.section == self.dataArrayM.count - 1) {
        /// 底部提示文字
        return PFSC(24).lineHeight + SH(40);
    }
    return 0;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section < self.dataArrayM.count - 1) {
        MGTeacherAllCategoryCell *cell = (MGTeacherAllCategoryCell *)[tableView cellWithCellClass:[MGTeacherAllCategoryCell class]];
        cell.tableIndexPath = indexPath;
        cell.dataModel = self.dataArrayM[indexPath.section];
        cell.categoryDidCellItemBlock = _categoryDidCellItemBlock;
        return cell;
    } else {
        MGHomeBottomTipCell *cell = (MGHomeBottomTipCell *)[tableView cellForIndexPath:indexPath cellClass:[MGHomeBottomTipCell class]];
        return cell;
    }
    
    return nil;
    
}

@end
