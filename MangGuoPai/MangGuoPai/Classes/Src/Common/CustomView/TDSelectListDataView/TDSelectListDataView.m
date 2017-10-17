//
//  TDSelectListDataView.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/7/6.
//  Copyright © 2017年 梦创. All rights reserved.
//

#import "TDSelectListDataView.h"
#import "TDSelectListDataViewContentView.h"

@interface TDSelectListDataView ()

/// 标题
@property (nonatomic, strong) UILabel *titleLabel;

/// 下拉箭头
@property (nonatomic, strong) UIImageView *arrowImageView;

/// 下拉菜单
@property (nonatomic, strong) TDSelectListDataViewContentView *contentView;

@end

@implementation TDSelectListDataView


- (void)prepareFrameViewUI:(CGRect)frame {

    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(superTapOnClick)]];
    
    self.layer.borderColor = MGSepColor.CGColor;
    self.layer.borderWidth = MGSepLineHeight;
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
    _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - SW(28) - SW(20), 0, SW(28), SH(18))];
    _arrowImageView.image = [UIImage imageNamed:@"mine_pulldown_icon"];
    _arrowImageView.centerY = frame.size.height * 0.5;
    
    
    _titleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _titleLabel.frame = CGRectMake(SW(20), 0, _arrowImageView.left , _titleLabel.fontLineHeight);
    _titleLabel.centerY = frame.size.height * 0.5;
    
    [self sd_addSubviews:@[_titleLabel, _arrowImageView]];
    
}


#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response
/// 父类点击事件
- (void)superTapOnClick {
    
    [self endEditing:YES];
    
    [self.contentView showSelectListDataViewContentViewWithAnimated:YES];
    
    [self changeArrowImageWithAnimated:YES isShowRow:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapSelectListDataViewOnClick)]) {
        [self.delegate didTapSelectListDataViewOnClick];
    }
}

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

/// 设置 是否 可点击
- (void)setListDataViewisAllowClick:(BOOL)isAllow {
    
    self.arrowImageView.hidden = !isAllow;
    self.userInteractionEnabled = isAllow;
}

- (void)changeArrowImageWithAnimated:(BOOL)animated isShowRow:(BOOL)isShowRow {
    if (isShowRow) {
        if (animated) {
            [UIView animateWithDuration:0.35 animations:^{
                _arrowImageView.transform = CGAffineTransformRotate(_arrowImageView.transform, -M_PI);
            }];
            
        } else {
            _arrowImageView.transform = CGAffineTransformRotate(_arrowImageView.transform, -M_PI);
        }
    } else {
        if (animated) {
            [UIView animateWithDuration:0.35 animations:^{
                _arrowImageView.transform = CGAffineTransformIdentity;
            }];
        } else {
            _arrowImageView.transform = CGAffineTransformIdentity;
        }
    }
}

/// 设置标题
- (void)setTitleLabelWithTitle:(NSString *)title {
    self.titleLabel.text = title;
}
#pragma mark - Private Function

#pragma mark - Getter and Setter
- (TDSelectListDataViewContentView *)contentView {
    if (!_contentView) {
        _contentView = [TDSelectListDataViewContentView selectListDataViewContentViewWithDataArray:self.dataArray tableViewWidth:self.width inView:self];
        WEAK
        _contentView.didSelectListDataViewContentViewRow = ^(NSInteger row) {
            STRONG
            for (TDSelectListDataViewContentModel *tempModel in self.contentView.array) {
                tempModel.isSelected = NO;
            }
            TDSelectListDataViewContentModel *model = self.contentView.array[row];
            model.isSelected = YES;
            
            [self.contentView hideSelectListDataViewContentViewWithAnimated:YES comletion:^{
                [self.contentView.tableView reloadData];
               
            }];
           
            [self changeArrowImageWithAnimated:YES isShowRow:NO];
            
            if (self.didSelectListDataViewContentViewRow) {
                self.didSelectListDataViewContentViewRow(row);
            }
            
        };
        
        /// 背景点击
        _contentView.didBackgroundViewOnClick = ^{
            STRONG
            [self changeArrowImageWithAnimated:YES isShowRow:NO];
        };
        
    }
    return _contentView;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    self.contentView.array = dataArray;
    [self.contentView.tableView reloadData];
    
}

- (void)reloadTableView {
    
    [self.contentView.tableView reloadData];
    
}

@end
