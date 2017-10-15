//
//  MGMessageListTableView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/13.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMessageListTableView.h"
#import "MGMessageListCell.h"

@interface MGMessageListTableView ()


@end

@implementation MGMessageListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        MGCommonEmptyView *emtpyView = [[MGCommonEmptyView alloc] initWithFrame:self.bounds];
        emtpyView.iconImageView.image = [UIImage imageNamed:@"empty_page_icon_02"];
        emtpyView.contentLabel.text = @"暂无消息";
        self.emptyDataView = emtpyView;
        
        
    }
    return self;
}


#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 0.00001;
    
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
    
    return SH(126);
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MGMessageListCell *cell = (MGMessageListCell *)[tableView cellWithCellClass:[MGMessageListCell class]];
    cell.dataModel = self.dataArrayM[indexPath.section];
    
    return cell;
    
}

#pragma mark - EmptyDelegate
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    
    if (!self.dataArrayM) {
        return NO;
    }
    
    return self.dataArrayM.count == 0;
    
}



@end
