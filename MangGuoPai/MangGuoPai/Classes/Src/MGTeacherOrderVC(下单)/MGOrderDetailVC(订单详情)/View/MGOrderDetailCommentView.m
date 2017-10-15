//
//  MGOrderDetailCommentView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/7.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGOrderDetailCommentView.h"

@interface MGOrderDetailCommentView ()

@property (nonatomic, strong) UILabel *commentTipLabel;

@property (nonatomic, strong) UILabel *commentLabal;

@property (nonatomic, strong) UILabel *replyLabel;


@end

@implementation MGOrderDetailCommentView


- (void)prepareFrameViewUI:(CGRect)frame {
    
    
    _commentTipLabel = [MGUITool labelWithText:@"点评信息 : " textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _commentTipLabel.frame = CGRectMake(SW(30), SH(30), kScreenWidth - SH(60), _commentTipLabel.fontLineHeight);
    
    
    _commentLabal = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _commentLabal.frame = CGRectMake(SW(30), _commentTipLabel.bottom + SH(30), kScreenWidth - SH(60), 0);
    
    _replyLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _replyLabel.frame = CGRectMake(SW(100), 0, kScreenWidth - SH(130), 0);
    
    
    [self sd_addSubviews:@[_commentTipLabel, _commentLabal, _replyLabel]];
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter 
- (void)setDetailDataModel:(MGResOrderDetailDataModel *)detailDataModel {
    _detailDataModel = detailDataModel;

    if (detailDataModel.comments.count > 0) {
        MGResOrderDetailCommentModel *dataModel = detailDataModel.comments[0];
        _commentLabal.text = dataModel.content;
        _replyLabel.text = dataModel.reply;
        
        CGFloat commentHeight = [_commentLabal.text heightForFont:PFSC(28) width:_commentLabal.width];

        CGFloat replyHeight = [_replyLabel.text heightForFont:PFSC(28) width:_replyLabel.width];
        _commentLabal.height = commentHeight;
        
        _replyLabel.height = replyHeight;
        
        _replyLabel.top = _commentLabal.bottom + SH(30);
        
        self.hidden = NO;
        self.height = _replyLabel.bottom + SH(60);
        
    } else {
        self.height = 0;
        self.hidden = YES;
        
    }
    
}



@end
