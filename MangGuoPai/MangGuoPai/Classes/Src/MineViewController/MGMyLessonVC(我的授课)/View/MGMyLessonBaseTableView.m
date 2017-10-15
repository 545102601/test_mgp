//
//  MGMyLessonBaseTableView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/1.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMyLessonBaseTableView.h"
#import "MGMyLessonBaseCell.h"

@implementation MGMyLessonBaseTableView

- (void)prepareUI {
    MGCommonEmptyView *emtpyView = [[MGCommonEmptyView alloc] initWithFrame:self.bounds];
    emtpyView.iconImageView.image = [UIImage imageNamed:@"empty_page_icon_07"];
    emtpyView.contentLabel.text = @"暂无授课";
    self.emptyDataView = emtpyView;
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
    
    return SH(260);
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MGMyLessonBaseCell *cell = (MGMyLessonBaseCell *)[tableView cellWithCellClass:[MGMyLessonBaseCell class]];
    cell.dataModel = self.dataArrayM[indexPath.section];
    cell.buttonEventBlock = _buttonEventBlock;
    
    return cell;
    
}

@end
