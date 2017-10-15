//
//  MGColletionListTableView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGFavListTableView.h"
#import "MGFavListCell.h"
#import "MGCommonEmptyView.h"

@interface MGFavListTableView ()

@end

@implementation MGFavListTableView


- (void)prepareUI {
    
    MGCommonEmptyView *eView = [[MGCommonEmptyView alloc] initWithFrame:self.bounds];
    eView.iconImageView.image = [UIImage imageNamed:@"empty_page_icon_03"];
    eView.contentLabel.text = @"暂无收藏";
    self.emptyDataView = eView;
    
    
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
    
    return 1;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SH(170);
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MGFavListCell * cell = (MGFavListCell * )[tableView cellWithCellClass:[MGFavListCell class]];
    cell.dataModel = self.dataArrayM[indexPath.section];
    
    return cell;
    
}

// 设置 哪一行的编辑按钮 状态 指定编辑样式
- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
// 判断点击按钮的样式 来去做添加 或删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    }
    
}
-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"取消收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        if (self.deleteFavBlock) {
            self.deleteFavBlock(indexPath);
        }
        
    }];
    
    rowAction.backgroundColor = RGB(153, 153, 153);
    
//    UITableViewRowAction *rowaction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        
//    }];
//    rowaction.backgroundColor = [UIColor grayColor];
    NSArray *arr = @[rowAction];
    return arr;
}



@end
