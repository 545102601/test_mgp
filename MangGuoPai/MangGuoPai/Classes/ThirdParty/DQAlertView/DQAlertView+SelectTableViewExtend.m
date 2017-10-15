//
//  DQAlertView+SelectTableViewExtend.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/4.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "DQAlertView+SelectTableViewExtend.h"
#import "YNBaseTableView.h"
#import "BaseTableViewCell.h"


@implementation DQAlertSelectedModel

MJCodingImplementation


@end

/// cell
@interface DQAlertSelectTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleNameLabel;
@property (nonatomic, strong) UIImageView *selectImageView;
@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, strong) DQAlertSelectedModel *dataModel;

@end

@implementation DQAlertSelectTableViewCell

- (void)preapreCellUI {

    
    _titleNameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24)];
    
    _selectImageView = [[UIImageView alloc] init];
    _selectImageView.image = [UIImage imageNamed:@"mine_icon_play"];
    
    
    _bottomLineView = [[UIView alloc] init];
    _bottomLineView.backgroundColor = MGSepColor;
    
    [self.contentView sd_addSubviews:@[_titleNameLabel, _selectImageView, _bottomLineView]];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.contentView.width;
    _titleNameLabel.frame = CGRectMake(0, 0, width * 0.8, _titleNameLabel.fontLineHeight);
    _selectImageView.frame = CGRectMake(width - SW(30), 0, SW(30), SW(30));
    _bottomLineView.frame = CGRectMake(0, 0, width, MGSepLineHeight);
    
    _titleNameLabel.centerY = self.contentView.height * 0.5;
    
    _selectImageView.centerY = self.contentView.height * 0.5;
    
    _bottomLineView.bottom = self.contentView.height - MGSepLineHeight;
    
}

- (void)setDataModel:(DQAlertSelectedModel *)dataModel {
    _dataModel = dataModel;
    
    _titleNameLabel.text = dataModel.title;
    _selectImageView.hidden = !dataModel.isSelected;
    
}

@end

@interface DQAlertSelectTableView : YNBaseTableView


@end

@implementation DQAlertSelectTableView


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
    
    return self.dataArrayM.count;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SH(60);
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DQAlertSelectTableViewCell *cell = (DQAlertSelectTableViewCell *)[tableView cellWithCellClass:[DQAlertSelectTableViewCell class]];
    cell.dataModel = self.dataArrayM[indexPath.row];
    
    return cell;
    
}

@end


@implementation DQAlertView (SelectTableViewExtend)

- (NSMutableArray *)setThemeTableViewToSelectedItemWithTitle:(NSString *)title
                                       dataArray:(NSMutableArray *)array {
    CGFloat bgViewHeight = 0.3;
    
    if (array.count == 2) {
        bgViewHeight = 0.2;
    }
    bgViewHeight = bgViewHeight * kScreenHeight;
    
    CGFloat tableViewHeight = 0.6;
    if (array.count == 2) {
        tableViewHeight = 0.5;
    }
    tableViewHeight = tableViewHeight * bgViewHeight;
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, bgViewHeight)];
    bgView.backgroundColor = [UIColor whiteColor];
    /// 标题
    UILabel *titleLabel = [MGUITool labelWithText:title textColor:MGThemeColor_Title_Black font:PFSC(30) textAlignment:NSTextAlignmentCenter];
    titleLabel.frame = CGRectMake(0, SH(30), self.width, titleLabel.fontLineHeight);
    
    DQAlertSelectTableView *tableView = [[DQAlertSelectTableView alloc] initWithFrame:CGRectMake(SW(60), titleLabel.bottom + SW(40), bgView.width - SW(120), tableViewHeight) style:UITableViewStyleGrouped];
    tableView.tag = 1018612;
    tableView.dataArrayM = array.mutableCopy;
    
    __weak typeof(DQAlertSelectTableView *)weakTableView = tableView;
    tableView.didSelectedRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
        
        DQAlertSelectedModel *selectedModel = weakTableView.dataArrayM[indexPath.row];
        
        for (DQAlertSelectedModel *model in weakTableView.dataArrayM) {
            model.isSelected = NO;
            if ([model.title isEqualToString:selectedModel.title]) {
                model.isSelected = YES;
            }
        }
        [weakTableView reloadData];
        
    };
    [bgView addSubview:titleLabel];
    [bgView addSubview:tableView];
    
    self.contentView = bgView;
    return tableView.dataArrayM;
}



- (void)scrollToSelectedItem {
    

        DQAlertSelectTableView *tableView = [self viewWithTag:1018612];
        
        for (int i = 0; i < tableView.dataArrayM.count; i++) {
            DQAlertSelectedModel *model = tableView.dataArrayM[i];
            if (model.isSelected) {
                [tableView scrollToRow:i inSection:0 atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                break;
            }
        }
}


@end
