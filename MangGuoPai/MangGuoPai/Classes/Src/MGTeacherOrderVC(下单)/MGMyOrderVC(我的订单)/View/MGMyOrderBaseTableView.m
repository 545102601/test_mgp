//
//  MGMyOrderTableView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/3.
//  Copyright © 2017年  Zheng. All rights reserved.
//

#import "MGMyOrderBaseTableView.h"
#import "MGMyOrderBaseCell.h"

@implementation MGMyOrderBaseTableView

- (void)prepareUI {


    MGCommonEmptyView *emtpyView = [[MGCommonEmptyView alloc] initWithFrame:self.bounds];
    emtpyView.iconImageView.image = [UIImage imageNamed:@"empty_page_icon_06"];
    emtpyView.contentLabel.text = @"暂无订单";
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
    MGResOrderListDataModel *dataModel = self.dataArrayM[indexPath.section];
    
    if (self.menuTag == MGGlobaMenuTagLeft) {
        
        switch (dataModel.state) {
            case MGGlobalOrderStateWaitingPay:
                return SH(360);
                
            default:
                return SH(260);
        }
        
    } else { /// 收到的订单
        
        switch (dataModel.state) {
            case MGGlobalOrderStateWaitingPay:
            case MGGlobalOrderStateAlreadyPayWaitingArrangement:
            case MGGlobalOrderStateAlreadyPayAlreadyArrangement:
                return SH(360);
                
            default:
                return SH(260);
        }
    }
    
    return 0;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MGMyOrderBaseCell *cell = (MGMyOrderBaseCell *)[tableView cellWithCellClass:[MGMyOrderBaseCell class]];
    cell.menuTag = self.menuTag;
    cell.indexPath = indexPath;
    cell.dataModel = self.dataArrayM[indexPath.section];
    cell.rightOneButtonBlock = _rightOneButtonBlock;
    cell.rightTwoButtonBlock = _rightTwoButtonBlock;
    return cell;
    
}

@end
