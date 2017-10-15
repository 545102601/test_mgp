//
//  MGMyCouponBaseTableView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/12.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMyCouponBaseTableView.h"
#import "MGMyCouponBaseCell.h"

@implementation MGMyCouponBaseTableView

- (void)prepareUI {

    MGCommonEmptyView *emtpyView = [[MGCommonEmptyView alloc] initWithFrame:self.bounds];
    emtpyView.iconImageView.image = [UIImage imageNamed:@"empty_page_icon_04"];
    emtpyView.contentLabel.text = @"暂无优惠卷";
    self.emptyDataView = emtpyView;
    
    self.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return SH(30);
    
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
    
    return kMGMyCouponBaseCellHeight;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MGMyCouponBaseCell *cell = (MGMyCouponBaseCell *)[tableView cellWithCellClass:[MGMyCouponBaseCell class]];
    cell.dataModel = self.dataArrayM[indexPath.section];
    return cell;
    
}


@end
