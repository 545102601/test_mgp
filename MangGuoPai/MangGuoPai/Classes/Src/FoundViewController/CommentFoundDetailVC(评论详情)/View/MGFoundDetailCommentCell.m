//
//  MGFoundDetailCommentCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/3.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGFoundDetailCommentCell.h"
#import <YYText.h>

@interface MGFoundDetailCommentCell ()
/// icon
@property (nonatomic, strong) UIImageView *iconImageView;
/// username
@property (nonatomic, strong) UILabel *userNameLabel;
/// 时间
@property (nonatomic, strong) UILabel *timeLabel;
/// 内容
@property (nonatomic, strong) YYLabel *cotentLabel;
/// 回复
@property (nonatomic, strong) YYLabel *replyLabel;

@property (nonatomic, strong) UIView *topLineView;
/// 线条
@property (nonatomic, strong) UIImageView *lineImageView;

/// 收藏按钮
@property (nonatomic, strong) UIButton *commentButton;



@end

@implementation MGFoundDetailCommentCell

- (void)preapreCellUI {

    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(28), SH(40), SW(80), SW(80))];
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.layer.cornerRadius = SW(40);
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    _userNameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _userNameLabel.frame = CGRectMake(_iconImageView.right + SW(20), SH(42), SW(480), _userNameLabel.fontLineHeight);
    
    
    _timeLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_subTitle_Black font:PFSC(24)];
    _timeLabel.frame = CGRectMake(_userNameLabel.left, _userNameLabel.bottom + SH(10), SW(200), _timeLabel.fontLineHeight);
    
    
    _commentButton = [TDExpendClickButtonNotHightLight buttonWithType:UIButtonTypeCustom];
    [_commentButton setImage:[UIImage imageNamed:@"found_mine_icon_pinglun"] forState:UIControlStateNormal];
    _commentButton.frame = CGRectMake(kScreenWidth - SW(26) - SW(44), 0, SW(44), SW(44));
    _commentButton.centerY = _userNameLabel.centerY;
    [_commentButton addTarget:self action:@selector(commentButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    _commentButton.hidden = YES;
    
    [self.contentView sd_addSubviews:@[_iconImageView,_commentButton,  _userNameLabel, _timeLabel]];
 
    
    _cotentLabel = [YYLabel new];
    _cotentLabel.userInteractionEnabled = YES;
    _cotentLabel.numberOfLines = 0;
    _cotentLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _cotentLabel.frame = CGRectMake(_userNameLabel.left, _timeLabel.bottom + SH(30), kScreenWidth - 2 * _userNameLabel.left, 0);
    _cotentLabel.font = PFSC(28);
    _cotentLabel.textColor = MGThemeColor_Common_Black;

    _replyLabel = [YYLabel new];
    _replyLabel.userInteractionEnabled = YES;
    _replyLabel.numberOfLines = 0;
    _replyLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _replyLabel.frame = CGRectMake(_userNameLabel.left, 0, kScreenWidth - 2 * _userNameLabel.left, 0);
    _replyLabel.font = PFSC(24);
    _replyLabel.textColor = MGThemeColor_Common_Black;
    
    
    
    _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, MGSepLineHeight)];
    _topLineView.backgroundColor = MGSepColor;
    
    _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, MGSepLineHeight)];
    
    [self.contentView sd_addSubviews:@[_topLineView, _cotentLabel, _replyLabel, _lineImageView]];
    
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 评论回复
- (void)commentButtonOnClick {
    
    if (_replyCommentBlock) {
        _replyCommentBlock(self.indexPath, self.dataModel);
    }
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _lineImageView.bottom = self.contentView.bottom;
}

#pragma mark - Getter and Setter
- (void)setDataModel:(MGResFoundDetailCommentDataModel *)dataModel {
    _dataModel = dataModel;

    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.avatar_rsurl] placeholderImage:SDWEB_PLACEHODER_IMAGE_ICON];
    
    _userNameLabel.text = dataModel.member_name;
    
    _timeLabel.text = dataModel.comment_time_str;
    
    
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:dataModel.content];
    attriStr.yy_font = PFSC(28);
    attriStr.yy_color = MGThemeColor_Common_Black;
    attriStr.yy_lineSpacing = SH(8);
    _cotentLabel.attributedText = attriStr;
    
    _cotentLabel.height = [YYTextLayout layoutWithContainerSize:CGSizeMake(kScreenWidth - _userNameLabel.left * 2, HUGE) text:_cotentLabel.attributedText].textBoundingSize.height;
    
    if (dataModel.reply.length > 0) {
        _replyLabel.hidden = NO;
        _replyLabel.top = _cotentLabel.bottom + SH(10);
        NSMutableAttributedString *replyStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"回复 : %@",dataModel.reply]];
        replyStr.yy_font = PFSC(28);
        replyStr.yy_color = MGThemeColor_Common_Black;
        replyStr.yy_lineSpacing = SH(8);
        _replyLabel.attributedText = replyStr;
        _replyLabel.height = [YYTextLayout layoutWithContainerSize:CGSizeMake(kScreenWidth - _userNameLabel.left * 2, HUGE) text:_replyLabel.attributedText].textBoundingSize.height;
        
    } else {
        _replyLabel.hidden = YES;
        _replyLabel.top = _cotentLabel.bottom;
        _replyLabel.height = 0;
    }
    
    _commentButton.hidden = !(self.isSelfTrend && dataModel.reply.length == 0);
    
    _topLineView.hidden = !self.showTopLine;
    
    _lineImageView.hidden = !self.showBottomLine;
    
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (_lineImageView.layer.sublayers.count == 0) {
        [MGUITool drawDashLine:_lineImageView lineLength:5 lineSpacing:3 lineColor:MGSepColor];
    }
}
@end
