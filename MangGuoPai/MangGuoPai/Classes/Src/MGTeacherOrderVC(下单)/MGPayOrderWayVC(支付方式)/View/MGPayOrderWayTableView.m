//
//  MGPayOrderWayTableView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/1.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGPayOrderWayTableView.h"
#import "MGPayOrderWayCell.h"

@interface MGPayOrderWayTableView ()



@end

@implementation MGPayOrderWayTableView

- (void)prepareUI {
    
    
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
    
    return SH(98);
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MGPayOrderWayCell *cell = (MGPayOrderWayCell*)[tableView cellWithCellClass:[MGPayOrderWayCell class]];
    cell.indexPath = indexPath;
    cell.model = self.dataArrayM[indexPath.row];
    cell.didOnClickSelectedBlock = _didOnClickSelectedBlock;
    return cell;
    
}

@end
