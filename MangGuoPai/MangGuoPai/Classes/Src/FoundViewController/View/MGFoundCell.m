//
//  MGFoundCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/4.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGFoundCell.h"

@implementation MGFoundCell

- (void)preapreCellUI {

    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _cellInfoView = [[MGFoundCellInfoView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(150))];
    
    _cellContentView = [[MGFoundCellContentView alloc] initWithFrame:CGRectMake(0, _cellInfoView.bottom, kScreenWidth, 0)];
    
    
    _toolsView = [[MGFoundCellToolsView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(98))];
    
    [self.contentView sd_addSubviews:@[_cellInfoView, _cellContentView, _toolsView]];
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter


- (void)setDataModel:(MGResTrendListDataModel *)dataModel {
    _dataModel = dataModel;
    
    _cellInfoView.indexPath = _indexPath;
    _cellInfoView.favEventBlock = _favEventBlock;
    _cellInfoView.dataModel = dataModel;
    
    
    _cellContentView.indexPath = _indexPath;
    _cellContentView.showAllContentTextForwardBlock = self.showAllContentTextForwardBlock;
    _cellContentView.showAllContentTextBlock = self.showAllContentTextBlock;
    _cellContentView.forwardBgViewTapBlock = _forwardBgViewTapBlock;
    _cellContentView.dataModel = dataModel;
    
    
    _toolsView.y = _cellContentView.bottom;
    _toolsView.indexPath = _indexPath;
    _toolsView.tapButtonBlock = _tapButtonBlock;
    _toolsView.dataModel = dataModel;
    
    
}

@end
