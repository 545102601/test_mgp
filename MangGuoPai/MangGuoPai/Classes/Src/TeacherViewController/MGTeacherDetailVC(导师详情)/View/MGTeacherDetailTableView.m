//
//  MGTeacherDetailTableView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/25.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherDetailTableView.h"
#import "MGTeacherDetailCell.h"

@interface MGTeacherDetailTableView ()

@end

@implementation MGTeacherDetailTableView

- (void)prepareUI {

    self.emptyDataSetShouldDisplay = NO;
    self.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 0.0001;
    
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
    
    return 1;
}
//rows-section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArrayM.count;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SH(168);
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MGTeacherDetailCell *cell = (MGTeacherDetailCell *)[tableView cellWithCellClass:[MGTeacherDetailCell class]];
    cell.dataModel = self.dataArrayM[indexPath.row];
    return cell;
}
@end
