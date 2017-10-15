//
//  MGWorkApplyJoinGroup.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkApplyJoinGroupView.h"
#import "MGWorkApplyJoinGroupViewCell.h"

@implementation MGWorkApplyJoinGroupView

- (void)prepareUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    MGCommonEmptyView *emtpyView = [[MGCommonEmptyView alloc] initWithFrame:self.bounds];
    emtpyView.iconImageView.image = [UIImage imageNamed:@"empty_page_icon_07"];
    emtpyView.contentLabel.text = @"暂无团队信息";
    emtpyView.contentViewOffSetY = -SH(10);
    self.emptyDataView = emtpyView;
    self.emptyDataSetShouldAllowScroll = NO;
    
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
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
    
    return 1;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kMGWorkApplyJoinGroupViewCellHeight;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MGWorkApplyJoinGroupViewCell *cell = (MGWorkApplyJoinGroupViewCell *)[tableView cellWithCellClass:[MGWorkApplyJoinGroupViewCell class]];
    cell.joinBlock = _joinBlock;
    cell.dataModel = self.dataArrayM[indexPath.section];
    
    return cell;
    
}

@end
