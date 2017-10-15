//
//  MGTeacherCategoryBaseDetailTableView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/23.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherCategoryBaseDetailTableView.h"
#import "MGTeacherRecommendCell.h"

@implementation MGTeacherCategoryBaseDetailTableView

- (void)prepareUI {
    self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    MGCommonEmptyView *emtpyView = [[MGCommonEmptyView alloc] initWithFrame:self.bounds];
    emtpyView.iconImageView.image = [UIImage imageNamed:@"empty_page_icon_05"];
    emtpyView.contentLabel.text = @"暂无数据";
    self.emptyDataView = emtpyView;

}

#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 10;
    
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
    MGTeacherRecommendCell *cell = (MGTeacherRecommendCell *)[tableView cellWithCellClass:[MGTeacherRecommendCell class]];
    cell.model = self.dataArrayM[indexPath.row];
    cell.iconImageTapBlock = _iconImageTapBlock;
    return cell;

    
}

@end
