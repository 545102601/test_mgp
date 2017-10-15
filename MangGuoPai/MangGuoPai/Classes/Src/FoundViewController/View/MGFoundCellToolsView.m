//
//  MGFoundCellToolsView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/4.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGFoundCellToolsView.h"

@interface MGFoundCellToolsView ()

@property (nonatomic, strong) UIView *topLineView;

@property (nonatomic, strong) UIView *shareBgView;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UILabel *shareLabel;

@property (nonatomic, strong) UIView *leftLineView;

/// 评论
@property (nonatomic, strong) UIView *commentBgView;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) UIView *rightLineView;

/// 赞
@property (nonatomic, strong) UIView *praiseBgView;
@property (nonatomic, strong) UIButton *praiseButton;
@property (nonatomic, strong) UILabel *praiseLabel;


@end

@implementation MGFoundCellToolsView


- (void)prepareFrameViewUI:(CGRect)frame {

    _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, MGSepLineHeight)];
    _topLineView.backgroundColor = MGSepColor;
    
    CGFloat width = frame.size.width / 3;
    CGFloat height = frame.size.height;
    /// 分享
    _shareBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    _shareButton = [TDExpendClickButtonNotHightLight buttonWithType:UIButtonTypeCustom];
    [_shareButton setImage:[UIImage imageNamed:@"found_icon_share"] forState:UIControlStateNormal];
    _shareButton.frame = CGRectMake(0, 0, SW(44), SW(44));
    _shareButton.centerX = width * 0.5 - SW(22);
    _shareButton.centerY = height * 0.5;
    [_shareButton addTarget:self action:@selector(shareOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _shareLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24)];
    _shareLabel.frame = CGRectMake(_shareButton.right + SW(10), 0, width * 0.5, _shareLabel.fontLineHeight);
    _shareLabel.centerY = _shareButton.centerY;
    _shareLabel.userInteractionEnabled = YES;
    [_shareLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareOnClick)]];
    
    
    [_shareBgView sd_addSubviews:@[_shareButton, _shareLabel]];
    
    
    
    _leftLineView = [[UIView alloc] initWithFrame:CGRectMake(_shareBgView.right, SH(6), MGSepLineHeight, frame.size.height - SH(12))];
    _leftLineView.backgroundColor = MGSepColor;
    
    /// 评论
    _commentBgView = [[UIView alloc] initWithFrame:CGRectMake(_shareBgView.right, 0, width, height)];
    
    _commentButton = [TDExpendClickButtonNotHightLight buttonWithType:UIButtonTypeCustom];
    [_commentButton setImage:[UIImage imageNamed:@"found_mine_icon_pinglun"] forState:UIControlStateNormal];
    _commentButton.frame = CGRectMake(0, 0, SW(44), SW(44));
    _commentButton.centerX = width * 0.5 - SW(22);
    _commentButton.centerY = height * 0.5;
    
    [_commentButton addTarget:self action:@selector(commentOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _commentLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24)];
    _commentLabel.frame = CGRectMake(_commentButton.right + SW(10), 0, width * 0.5, _commentLabel.fontLineHeight);
    _commentLabel.centerY = _commentButton.centerY;
    
    _commentLabel.userInteractionEnabled = YES;
    [_commentLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentOnClick)]];
    
    [_commentBgView sd_addSubviews:@[_commentButton, _commentLabel]];
    
    
    
    _rightLineView = [[UIView alloc] initWithFrame:CGRectMake(_commentBgView.right, SH(6), MGSepLineHeight, frame.size.height - SH(12))];
    _rightLineView.backgroundColor = MGSepColor;
    
    /// 点赞
    _praiseBgView = [[UIView alloc] initWithFrame:CGRectMake(_commentBgView.right, 0, width, height)];
    
    _praiseButton = [TDExpendClickButtonNotHightLight buttonWithType:UIButtonTypeCustom];
    [_praiseButton setImage:[UIImage imageNamed:@"found_icon_like_nor"] forState:UIControlStateNormal];
    
    _praiseButton.frame = CGRectMake(0, 0, SW(44), SW(44));
    _praiseButton.centerX = width * 0.5 - SW(22);
    _praiseButton.centerY = height * 0.5;
    
    [_praiseButton addTarget:self action:@selector(praiseOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _praiseLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24)];
    _praiseLabel.frame = CGRectMake(_praiseButton.right + SW(10), 0, width * 0.5, _praiseLabel.fontLineHeight);
    _praiseLabel.centerY = _praiseButton.centerY;
    _praiseLabel.userInteractionEnabled = YES;
    [_praiseLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(praiseOnClick)]];
    
    [_praiseBgView sd_addSubviews:@[_praiseButton, _praiseLabel]];
    
    [self sd_addSubviews:@[_shareBgView, _commentBgView, _praiseBgView, _topLineView, _leftLineView, _rightLineView]];
    
    
}


#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

- (void)shareOnClick {
    if (_tapButtonBlock) {
        _tapButtonBlock(0, self.dataModel, _indexPath);
    }
    
}
- (void)commentOnClick {
    
    if (_tapButtonBlock) {
        _tapButtonBlock(1, self.dataModel, _indexPath);
    }
    
    
}
- (void)praiseOnClick {
    
    if (_tapButtonBlock) {
        _tapButtonBlock(2, self.dataModel, _indexPath);
    }
    
    
}

- (void)setLiked:(BOOL)liked withAnimation:(BOOL)animation {
#warning todo 点赞控制
//    WBStatusLayout *layout = _cell.statusView.layout;
//    if (self.dataModel. == liked) return;
    
//    UIImage *image = liked ? [UIImage imageNamed:@"found_icon_like_pressed"] : [UIImage imageNamed:@"found_icon_like_nor"];
    
    UIImage *image = [UIImage imageNamed:@"found_icon_like_nor"];
    NSInteger newCount = self.dataModel.praise_count;
    newCount += 1;
    
//    newCount = liked ? newCount + 1 : newCount - 1;
    if (newCount < 0) newCount = 0;
    if (liked && newCount < 1) newCount = 1;
    NSString *newCountDesc = newCount > 0 ? [NSString stringWithFormat:@"%zd", newCount] : @"0";
    
    _praiseLabel.text = newCountDesc;
    
    /// 设置 为 yes
//    layout.status.attitudesStatus = liked;
    self.dataModel.praise_count = newCount;
    
    
//    if (!animation) {
        [_praiseButton setImage:image forState:UIControlStateNormal];
//        return;
//    }
    
//    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
//        _praiseButton.layer.transformScale = 1.7;
//    } completion:^(BOOL finished) {
//        [_praiseButton setImage:image forState:UIControlStateNormal];
//        
//        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
//            _praiseButton.layer.transformScale = 0.9;
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
//                _praiseButton.layer.transformScale = 1;
//            } completion:^(BOOL finished) {
//            }];
//        }];
//    }];
}

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

- (void)setDataModel:(MGResTrendListDataModel *)dataModel {
    
    _dataModel = dataModel;
    
#warning todo 点赞控制    
//    UIImage *image = liked ? [UIImage imageNamed:@"found_icon_like_pressed"] : [UIImage imageNamed:@"found_icon_like_nor"];
//    [_praiseButton setImage:image forState:UIControlStateNormal];
    
    
    _shareLabel.text = [NSString stringWithFormat:@"%zd",dataModel.faword_count];
    
    _commentLabel.text = [NSString stringWithFormat:@"%zd",dataModel.comment_count];
    
    _praiseLabel.text = [NSString stringWithFormat:@"%zd",dataModel.praise_count];
    
    
}


@end
