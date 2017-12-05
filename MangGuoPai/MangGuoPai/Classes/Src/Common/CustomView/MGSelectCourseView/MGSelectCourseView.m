//
//  MGSelectCourseView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/6.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGSelectCourseView.h"
#import "MGSelectCourseCell.h"

@interface MGSelectCourseView () <UITableViewDelegate, UITableViewDataSource>

/// 内容
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *topBgView;

@property (nonatomic, strong) UIButton *addAccountButton;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIButton *sureButton;

/// 背景
@property (nonatomic, strong) UIView *backgroundView;



@end

@implementation MGSelectCourseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    self.hidden = YES;
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    
    
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor = RGBA(0, 0, 0, 1);
    _backgroundView.alpha = 0;
    [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTapOnClick)]];
    [self addSubview:_backgroundView];
    
    
    _topBgView = [[UIView alloc] init];
    _topBgView.backgroundColor = [UIColor clearColor];
    
    
    _addAccountButton = [MGUITool buttonWithBGColor:nil title:@"选择想听的课程" titleColor:MGThemeColor_Title_Black font:PFSC(30) target:nil selector:nil];
    _addAccountButton.userInteractionEnabled = NO;
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = MGSepColor;
    
    [_topBgView addSubview:_addAccountButton];
    [_topBgView addSubview:_lineView];
    
    [_contentView addSubview:_topBgView];
    
    
    _sureButton = [MGUITool buttonWithBGColor:nil title:@"确定" titleColor: MGThemeColor_Title_Black font:MGThemeFont_36 target:self selector:@selector(sureButtonOnClick:)];
    [_sureButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_sureButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    
    [_contentView addSubview:_sureButton];
    
    [self addSubview:_contentView];
    
    
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
    _backgroundView.frame = self.bounds;
    
    _topBgView.frame = CGRectMake(0, 0, self.width, SH(98));
    
    _addAccountButton.frame = CGRectMake(0, 0, SW(250), SH(98));
    
    _addAccountButton.centerX = self.centerX;
    
    
    _lineView.frame = CGRectMake(SW(24), _topBgView.bottom - MGSepLineHeight, _topBgView.width - SW(48),MGSepLineHeight);
    
    
    _contentView.frame = CGRectMake(0, _backgroundView.height - [self getCotnentHeight], _backgroundView.width, [self getCotnentHeight]);
    
    self.tableView.frame = CGRectMake(0, _topBgView.bottom, self.width, _contentView.height - _topBgView.height - SH(98));
    
    _sureButton.frame = CGRectMake(0, self.tableView.bottom, kScreenWidth, SH(98));
    
    
}

- (CGFloat)getCotnentHeight {
    CGFloat height = 0;
    
    if (self.arrayM.count > 4) {
        height = (4 + 2) * SH(98);
    } else {
        height = (self.arrayM.count + 2) * SH(98);
    }
    return height;
}


#pragma mark - UITableViewDelegate  UITableViewDataSource
//sections-tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//rows-section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrayM.count;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SH(98);
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MGSelectCourseCell *cell = (MGSelectCourseCell *)[tableView cellForIndexPath:indexPath cellClass:[MGSelectCourseCell class]];
    cell.dataModel = self.arrayM[indexPath.row];
    
    return cell;
    
}
//select-tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MGResCourseListDataModel *dataModel = self.arrayM[indexPath.row];
    
    for (MGResCourseListDataModel *model in self.arrayM) {
        model.isSelected = NO;
        if (model.id == dataModel.id) {
            model.isSelected = YES;
        }
    }
    [tableView reloadData];
}


- (void)bgTapOnClick {
    [self hideSelectCourseWithAnimated:YES inView:self.superview];
}

- (void)sureButtonOnClick:(id)sender {
    
    MGResCourseListDataModel *selectedModel = nil;
    
    for (MGResCourseListDataModel *model in self.arrayM) {
        if (model.isSelected) {
            selectedModel = model;
            break;
        }
    }
    if (selectedModel) {
        if (_sureBlock) {
            _sureBlock(selectedModel);
        }
    }
    
}

- (void)showSelectCourseWithAnimated:(BOOL)animated inView:(UIView *)view {
    
    
    if (animated && self.hidden) {
        self.hidden = NO;
        
        _contentView.y = _backgroundView.height;
        _backgroundView.alpha = 0;
        [UIView animateWithDuration:0.27 delay:0 options:458752 | UIViewAnimationOptionBeginFromCurrentState animations:^{
            _contentView.y = _backgroundView.height - [self getCotnentHeight];
            _backgroundView.alpha = 0.3;
            
        } completion:nil];
        
    } else {
        _contentView.y = view.frame.size.height - [self getCotnentHeight];
        _backgroundView.alpha = 0;
        
        self.hidden = NO;
    }
}

- (void)hideSelectCourseWithAnimated:(BOOL)animated inView:(UIView *)view {
    if (animated && !self.hidden) {
        [UIView animateWithDuration:0.27 delay:0 options:458752 | UIViewAnimationOptionBeginFromCurrentState animations:^{
            _contentView.y = _backgroundView.height;
            _backgroundView.alpha = 0;
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    } else {
        self.hidden = YES;
    }
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView setShowsVerticalScrollIndicator:YES];
        [_tableView setShowsHorizontalScrollIndicator:NO];
        _tableView.bounces = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_contentView addSubview:_tableView];
        
    }
    return _tableView;
}


@end
