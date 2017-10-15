//
//  MGFoundTableView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/4.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGFoundTableView.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"


@interface MGFoundTableView ()


@end

@implementation MGFoundTableView


- (void)prepareUI {
    
    MGCommonEmptyView *emtpyView = [[MGCommonEmptyView alloc] initWithFrame:self.bounds];
    emtpyView.iconImageView.image = [UIImage imageNamed:@"empty_page_icon_02"];
    emtpyView.contentLabel.text = @"暂无动态";
    self.emptyDataView = emtpyView;
    

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
    
    
    MGResTrendListDataModel *dataModel = self.dataArrayM[indexPath.section];

    NSMutableString *state = @"unopen".mutableCopy;
    if (dataModel.shouldShowMoreButton) { // 如果文字大于50字
        if (dataModel.isOpening) { /// 是否需要展开
            state = @"open".mutableCopy;
        }
    }
    
    /// 转发
    if (dataModel.forward_trend) {
        if (dataModel.forward_trend.shouldShowMoreButton) { // 如果文字大于50字
            if (dataModel.forward_trend.isOpening) { /// 是否需要展开
                [state appendString:@"_forwar_open"];
            } else {
                [state appendString:@"_forwar_unopen"];
            }
        } else {
            [state appendString:@"_forwar_unopen"];
        }
    }
    
    return [MGFoundCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        MGFoundCell *cell = (MGFoundCell *)sourceCell;
        // 配置数据
        cell.dataModel = dataModel;
    } cache:^NSDictionary *{
        return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%ld", dataModel.id],
                 kHYBCacheStateKey : state};
    }];
    
    
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MGFoundCell *cell = (MGFoundCell *)[tableView cellWithCellClass:[MGFoundCell class]];
    cell.indexPath = indexPath;
    cell.showAllContentTextBlock = _showAllContentTextBlock;
    cell.showAllContentTextForwardBlock = _showAllContentTextForwardBlock;
    /// 收藏
    cell.favEventBlock = _favEventBlock;
    /// 点击工具条
    cell.tapButtonBlock = _tapButtonBlock;
    
    cell.forwardBgViewTapBlock = _forwardBgViewTapBlock;
    
    cell.dataModel = self.dataArrayM[indexPath.section];
   

    return cell;
    
}



@end
