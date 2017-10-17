//
//  MGWorkLookProductTableView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/15.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkLookProductTableView.h"
#import "MGWorkLookProductCell.h"
#import "MGWorkLookProductCommentCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "MGWorkLookProductColletionViewCell.h"

@implementation MGWorkLookProductTableView

- (void)prepareUI {
    
    self.emptyDataSetShouldDisplay = NO;
    self.backgroundColor = [UIColor whiteColor];
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
    NSInteger photoNumber = self.dataArrayM.count > 0 ? 1 : 0 ;
    return photoNumber + 1;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger photoNumber = self.dataArrayM.count > 0 ? 1 : 0 ;
    if (indexPath.row < photoNumber) {
        return kMGWorkLookProductColletionViewCellHeight * self.dataArrayM.count;
    } else {
        return [MGWorkLookProductCommentCell hyb_heightForTableView:tableView
                                                             config:^(UITableViewCell *sourceCell) {
            ((MGWorkLookProductCommentCell *)sourceCell).actorDataModel = self.actorDataModel;
        }
                                                              cache:^NSDictionary *{
            return @{kHYBCacheUniqueKey : [NSString stringWithFormat:@"%ld", self.actorDataModel.id],
                     kHYBCacheStateKey : @"stateKey"};
        }] + SH(30);
    }
    
    return 0;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger photoNumber = self.dataArrayM.count > 0 ? 1 : 0 ;
    if (indexPath.row < photoNumber) {
        MGWorkLookProductCell *cell = (MGWorkLookProductCell *)[tableView cellWithCellClass:[MGWorkLookProductCell class]];
        cell.urlArray = self.dataArrayM;
        return cell;
    } else {
        MGWorkLookProductCommentCell *cell = (MGWorkLookProductCommentCell *)[tableView cellWithCellClass:[MGWorkLookProductCommentCell class]];
        cell.lookOtherFileButtonBlock = _lookOtherFileButtonBlock;
        cell.actorDataModel = _actorDataModel;
        return cell;
    }
    
    return nil;
    
}

- (void)setActorDataModel:(MGResProjectActorDataModel *)actorDataModel {
    
    _actorDataModel = actorDataModel;
    
    self.dataArrayM = actorDataModel.works_phote_rsurls.mutableCopy;
    
}

@end
