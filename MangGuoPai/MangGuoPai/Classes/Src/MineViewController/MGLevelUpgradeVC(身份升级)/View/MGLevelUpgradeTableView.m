//
//  MGLevelUpgradeTableView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/21.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGLevelUpgradeTableView.h"
#import "MGLevelUpgradeCell.h"

@implementation MGLevelUpgradeTableView


- (void)prepareUI {

    self.emptyDataSetShouldDisplay = NO;
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return SH(85);
    }
    return SH(20);
    
}
//header-secion
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        UILabel *titleLabel = [MGUITool labelWithText:
                               [NSString stringWithFormat:@"当前我的身份 : %@",memberDataModelInstance.user_identity_label] textColor:MGButtonImportHighLightedColor font:PFSC(36)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.frame = CGRectMake(0, 0, kScreenWidth, SH(85));
        return titleLabel;
    }
    
    
    
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
    
    return SH(234);
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MGLevelUpgradeCell *cell = (MGLevelUpgradeCell *)[tableView cellWithCellClass:[MGLevelUpgradeCell class]];
    cell.model = self.dataArrayM[indexPath.section];
    return cell;
    
}



@end
