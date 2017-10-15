//
//  MGWorkDetailCommentCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/30.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkDetailCommentCell.h"

@interface MGWorkDetailCommentCell ()

@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) UIView *commentContentView;
@property (nonatomic, strong) UIView *awardsBgView;
@property (nonatomic, strong) UILabel *awardsLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *membersLabel;

@property (nonatomic, strong) NSMutableArray *imageViews;

@property (nonatomic, strong) UIButton *expendButton;

@end

@implementation MGWorkDetailCommentCell

- (void)preapreCellUI {

    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _commentLabel = [MGUITool labelWithText:@"获奖作品与评价" textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _commentLabel.frame = CGRectMake(SW(30), SH(20), kScreenWidth * 0.5, _commentLabel.fontLineHeight);
    
    _commentContentView = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _commentContentView.frame = CGRectMake(SW(40), _commentLabel.bottom + SH(20), kScreenWidth - SW(80), 0);
    
    
    _imageViews = @[].mutableCopy;
    CGFloat leftMargin = (kScreenWidth - SW(800))/2;
    
    for (int i = 0 ; i < 9; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftMargin, i * SW(400), SW(400), SW(400))];
        imageView.hidden = YES;
        [self.contentView addSubview:imageView];
    }
    
    
    _expendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _expendButton.titleLabel.font = PFSC(28);
    [_expendButton setTitle:@"展开" forState:UIControlStateNormal];
    [_expendButton setTitle:@"收回" forState:UIControlStateSelected];
    [_expendButton setTitleColor:MGThemeColor_Common_Black forState:UIControlStateNormal];
    [_expendButton setTitleColor:MGThemeColor_Common_Black forState:UIControlStateSelected];
    
    [_expendButton addTarget:self action:@selector(expendButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    [_expendButton sizeToFit];
    _expendButton.right = kScreenWidth - SW(30);
    _expendButton.centerY = _commentLabel.centerY;
    
    [self.contentView sd_addSubviews:@[_commentLabel, _commentContentView, _expendButton]];
    
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

- (void)expendButtonOnClick {
    _expendButton.selected = !_expendButton.isSelected;
//    self.dataModel.entryIsExpend = _expendButton.isSelected;
    if (_expendButtonBlock) {
        _expendButtonBlock(self.indexPath);
    }
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter
- (void)setDataModel:(MGResProjectActorDataModel *)dataModel {
    _dataModel = dataModel;
}

@end
