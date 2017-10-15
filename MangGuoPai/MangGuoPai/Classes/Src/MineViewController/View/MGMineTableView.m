//
//  MGMineTableView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/16.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMineTableView.h"
#import "MGMineCell.h"

@interface MGMineTableView ()

@end

@implementation MGMineTableView

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
    
    return [self.dataArrayM[section] count];
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SH(98);
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MGMineCell *cell = (MGMineCell *)[tableView cellWithCellClass:[MGMineCell class]];
    cell.hiddenLine = [self.dataArrayM[indexPath.section] count] -1 == indexPath.row;
    cell.model = self.dataArrayM[indexPath.section][indexPath.row];
    return cell;
    
}

@end
