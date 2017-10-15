//
//  MGHomeTableView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGHomeTableView.h"
#import "MGHomeAdvertCell.h"
#import "MGHomeBulletinCell.h"
#import "MGHomeFunctionCell.h"
#import "MGHomeSimpleGraphCell.h"
#import "MGHomePosterCell.h"
#import "MGHomeBottomTipCell.h"
#import "MGHomeColletionViewTableViewCell.h"
#import "MGHomeColletionViewVVTableViewCell.h"

@interface MGHomeTableView () <UIScrollViewDelegate>

@end

@implementation MGHomeTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        /// 不显示占位图
        self.emptyDataSetShouldDisplay = NO;
        
    }
    return self;

}


#pragma mark - UITableViewDelegate  UITableViewDataSource
#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
     NSInteger lastIndex = 2 + self.ReResults.count;
    switch (section) {
        case 0:
            return 0.0001;
    }
    if (section == lastIndex) {
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
    if (!self.adverArray) { /// 还没加载完毕
        return 0;
    }
    
    return 2 + self.ReResults.count + 1;
}
//rows-section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return !self.adverArray ? 0 : 2;
        case 1:
            return self.functionArray.count > 0 ? 1 : 0;
    }
    return 1;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger lastIndex = 2 + self.ReResults.count;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 0) {       /// 广告
            return SH(400);
        } else if (row == 1) {/// 公告
            return SH(90);
        }
    } else if (section == 1) {
        return SH(420);/// 小功能
    } else if (section < 2 + self.ReResults.count) {
        MGResSettingDataModel *dataModel = self.ReResults[indexPath.section - 2];
        //广告模式
        //单图模式：1
        //多图模式：2
        //多图模式 竖屏：3
        //海报模式：0
        switch ([dataModel.type integerValue]) {
            case 0:
                return SH(620);
            case 1:
                return SH(140) * dataModel.details.count + SH(133);
            case 2:
                return SH(279);
            case 3:
                return SH(435);
            case 4:
                return SH(140) * dataModel.details.count + SH(133);
            default:
                break;
        }
        
        
    } else if (lastIndex) {
        /// 底部提示文字
        return PFSC(24).lineHeight + SH(40);
    }
    
    return 0;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger lastIndex = 2 + self.ReResults.count;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 0) {       /// 广告
            
            MGHomeAdvertCell *cell = (MGHomeAdvertCell *)[tableView cellForIndexPath:indexPath cellClass:[MGHomeAdvertCell class]];
            cell.dataArray = self.adverArray;
            cell.advertCellDidSelectedBlock = _advertCellDidSelectedBlock;
            return cell;
        } else if (row == 1) {/// 公告
            
            MGHomeBulletinCell *cell = (MGHomeBulletinCell *)[tableView cellForIndexPath:indexPath cellClass:[MGHomeBulletinCell class]];
            cell.dataArray = self.bulletinArray;
            cell.bulletinCellDidSelectedBlock = _bulletinCellDidSelectedBlock;
            cell.leftImageTapBlock = _leftImageTapBlock;
            return cell;
        }
    } else if (section == 1) {
        
        MGHomeFunctionCell *cell = (MGHomeFunctionCell *)[tableView cellForIndexPath:indexPath cellClass:[MGHomeFunctionCell class]];
        cell.dataArray = self.functionArray;
        cell.wordAndArray = self.workAndClassArray;
        cell.didCellItemBlock = _functionDidCellItemBlock;
        cell.wordAndClassBlock = _didCellItem;
        return cell;
        
    } else if (section < 2 + self.ReResults.count) {
        MGResSettingDataModel *dataModel = self.ReResults[indexPath.section - 2];
        //广告模式
        //单图模式：1
        //多图模式：2
        //多图模式 竖屏：3
        //海报模式：0
        switch ([dataModel.type integerValue]) {
            case 0:
            {
                
                MGHomePosterCell *cell = (MGHomePosterCell *)[tableView cellForIndexPath:indexPath cellClass:[MGHomePosterCell class]];
                cell.dataModel = self.ReResults[section - 2];
                cell.didCellItem = _didCellItem;
                return cell;
            }
            case 1: 
            {
                
                MGHomeSimpleGraphCell *cell = (MGHomeSimpleGraphCell *)[tableView cellForIndexPath:indexPath cellClass:[MGHomeSimpleGraphCell class]];
                cell.dataModel = self.ReResults[section - 2];
                cell.didCellItem = _didCellItem;
                return cell;
            }
            case 2:
            {
                MGHomeColletionViewTableViewCell *cell = (MGHomeColletionViewTableViewCell *)[tableView cellWithCellClass:[MGHomeColletionViewTableViewCell class]];
                cell.dataModel = self.ReResults[section - 2];
                cell.didCellItem = _didCellItem;
                return cell;
            }
            case 3:
            {
                MGHomeColletionViewVVTableViewCell *cell = (MGHomeColletionViewVVTableViewCell *)[tableView cellWithCellClass:[MGHomeColletionViewVVTableViewCell class]];
                cell.dataModel = self.ReResults[section - 2];
                cell.didCellItem = _didCellItem;
                return cell;
            }
            case 4:
            {
                MGHomeSimpleGraphCell *cell = (MGHomeSimpleGraphCell *)[tableView cellForIndexPath:indexPath cellClass:[MGHomeSimpleGraphCell class]];
                cell.dataModel = self.ReResults[section - 2];
                cell.didCellItem = _didCellItem;
                return cell;
            }
                
            default:
                break;
        }
        
        
    } else if (lastIndex) {
        /// 底部提示文字
        
        MGHomeBottomTipCell *cell = (MGHomeBottomTipCell *)[tableView cellForIndexPath:indexPath cellClass:[MGHomeBottomTipCell class]];
        return cell;
    }
    
    return nil;
    
}

#pragma mark - UIScrollViewDidScroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    if (y > SH(310)) {
        CGFloat alpha = MIN(1, 1 - ((SH(310) + 64 - y) / 64));
        [self.navigationBar gradientBackgroundViewColorWithAlpha:alpha];
    } else {
        [self.navigationBar gradientBackgroundViewColorWithAlpha:0];
    }
    if (y < 0) {
        self.navigationBar.transform = CGAffineTransformMakeTranslation(0, y);
    } else{
        if (self.navigationBar.transform.ty != 0) {
            self.navigationBar.transform = CGAffineTransformMakeTranslation(0, 0);
        }
    }
}


@end
