//
//  TDSelectListDataViewContentView.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/7/6.
//  Copyright © 2017年 梦创. All rights reserved.
//

#import "TDSelectListDataViewContentView.h"
#import "TDTDSelectListDataViewContentViewCell.h"


@interface TDSelectListDataViewContentView () <UITableViewDelegate, UITableViewDataSource>
/// 背景视图
@property (nonatomic, strong) UIView *backGroundView;


@end

@implementation TDSelectListDataViewContentView

- (void)prepareFrameViewUI:(CGRect)frame {

    _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [_backGroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapOnClick)]];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = colorHex(@"#EDEFF3");
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    [self sd_addSubviews:@[_backGroundView, _tableView]];
}


/// 背景点击事件
- (void)backgroundTapOnClick {
    
    [self hideSelectListDataViewContentViewWithAnimated:YES];
    if (_didBackgroundViewOnClick) {
        _didBackgroundViewOnClick();
    }
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

+ (instancetype)selectListDataViewContentViewWithDataArray:(NSArray *)array tableViewWidth:(CGFloat)tableViewWidth inView:(UIView *)inView {
    
    TDSelectListDataViewContentView *contentView = [[TDSelectListDataViewContentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    contentView.array = array;
    contentView.inView = inView;
    contentView.tableViewWidth = tableViewWidth;
    
    /// 求偏移量
    CGRect targetFrame = [contentView convertRect:inView.frame fromView:inView.superview];
    contentView.tableView.frame = CGRectMake(targetFrame.origin.x, targetFrame.origin.y + targetFrame.size.height, tableViewWidth, [contentView getTableViewHeight]);
    
    
    return contentView;
}

/// 显示
- (void)showSelectListDataViewContentViewWithAnimated:(BOOL)animated {
    
    [KeyWindow addSubview:self];
    
    self.hidden = NO;
    _tableView.height = 0;
    [UIView animateWithDuration:0.35 animations:^{
        _tableView.height = [self getTableViewHeight];
    }];
    
    
}
/// 隐藏
- (void)hideSelectListDataViewContentViewWithAnimated:(BOOL)animated {
    
    [self hideSelectListDataViewContentViewWithAnimated:animated comletion:nil];
 
}

/// 隐藏
- (void)hideSelectListDataViewContentViewWithAnimated:(BOOL)animated
                                            comletion:(void(^)(void))completion {
    [UIView animateWithDuration:0.35 animations:^{
        _tableView.height = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
        if (completion) {
            completion();
        }
    }];
}

#pragma mark - Private Function
- (CGFloat)getTableViewHeight {
    return self.array.count > 6 ? SH(80) * 6 : self.array.count * SH(80);
    
}
#pragma mark - Getter and Setter


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
    
    return self.array.count;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SH(80);
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TDTDSelectListDataViewContentViewCell *cell = (TDTDSelectListDataViewContentViewCell *)[tableView cellForIndexPath:indexPath cellClass:[TDTDSelectListDataViewContentViewCell class]];
    cell.hiddenBottomLine = self.array.count - 1 == indexPath.row;
    cell.model = self.array[indexPath.row];
    
    return cell;
    
}
//select-tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (_didSelectListDataViewContentViewRow) {
        _didSelectListDataViewContentViewRow(indexPath.row);
    }
}


@end
