//
//  MGWorkTableView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/30.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkTableView.h"
#import "MGWorkCell.h"

@interface MGWorkTableView ()

@end


@implementation MGWorkTableView

- (void)prepareUI {
    
    MGCommonEmptyView *emtpyView = [[MGCommonEmptyView alloc] initWithFrame:self.bounds];
    emtpyView.iconImageView.image = [UIImage imageNamed:@"empty_page_icon_07"];
    emtpyView.contentLabel.text = @"暂无工作包";
    self.emptyDataView = emtpyView;
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 0.01;
    
}
//header-secion
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

//footer-hegiht
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return SH(20);
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
    
    return 1;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kMGWorkCellHeight;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MGWorkCell *cell = (MGWorkCell *)[tableView cellWithCellClass:[MGWorkCell class]];
    cell.buttonEventBlock = _buttonEventBlock;
    cell.dataModel = self.dataArrayM[indexPath.section];
    
    return cell;
    
}

@end
