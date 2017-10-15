//
//  MGWorkTeamTableView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/13.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkTeamTableView.h"
#import "MGWorkTeamCell.h"
#import "MGWorkTeamSectionHeader.h"


@implementation MGWorkTeamTableView

- (void)prepareUI {
    
    self.emptyDataSetShouldDisplay = NO;
    self.backgroundColor = [UIColor whiteColor];
    
    [self registerClass:[MGWorkTeamSectionHeader class] forHeaderFooterViewReuseIdentifier:@"MGWorkTeamSectionHeaderID"];
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return kMGWorkTeamSectionHeaderHeight;
    
}
//header-secion
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MGWorkTeamSectionHeader *view = (MGWorkTeamSectionHeader *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MGWorkTeamSectionHeaderID"];
    view.number = self.dataArrayM.count;
    return view;
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
    if (self.dataArrayM.count == 0) return 0;
    return 1;
}
//rows-section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArrayM.count;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kMGWorkTeamCellHeight;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MGWorkTeamCell *cell = (MGWorkTeamCell *)[tableView cellWithCellClass:[MGWorkTeamCell class]];
    cell.dataModel = self.dataArrayM[indexPath.row];
    
    return cell;
    
}

@end
