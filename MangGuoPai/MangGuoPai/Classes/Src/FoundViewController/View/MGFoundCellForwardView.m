//
//  MGFoundCellForwardView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/3.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGFoundCellForwardView.h"
#import <YYText.h>
#import "MGFoundCellPhotosCotainerView.h"

@interface MGFoundCellForwardView ()

@property (nonatomic, strong) YYLabel *cotentLabel;

@property (nonatomic, strong) MGFoundCellPhotosCotainerView *photosContainerView;

@end

@implementation MGFoundCellForwardView

- (void)prepareFrameViewUI:(CGRect)frame {
    
    self.backgroundColor = RGB(247, 247, 247);
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forwardBgTap)]];
    
    _cotentLabel = [YYLabel new];
    _cotentLabel.userInteractionEnabled = YES;
    _cotentLabel.numberOfLines = 0;
    _cotentLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _cotentLabel.frame = CGRectMake(SW(30), SH(28), frame.size.width - SW(60), 0);
    _cotentLabel.font = PFSC(28);
    _cotentLabel.textColor = MGThemeColor_Common_Black;
    
    _photosContainerView = [[MGFoundCellPhotosCotainerView alloc] initWithFrame:CGRectMake(SW(30), 0, 0, 0)];
    
    
    [self addSubview:_cotentLabel];
    [self addSubview:_photosContainerView];

}


#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

- (void)forwardBgTap {
    
    if (_forwardBgViewTapBlock) {
        _forwardBgViewTapBlock(self.dataModel);
    }
}

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

- (void)setDataModel:(MGResTrendListDataModel *)dataModel {
    if (!dataModel) return;
    _dataModel = dataModel;
    
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ : %@",dataModel.publisher_name,dataModel.content]];
    attriStr.yy_font = PFSC(28);
    attriStr.yy_color = MGThemeColor_Common_Black;
    attriStr.yy_lineSpacing = SH(8);
    
    _photosContainerView.picPathStringsArray = dataModel.pic_rsurls;
    /// 昵称颜色
    [attriStr yy_setColor:MGThemeColor_Title_Black range:NSMakeRange(0, dataModel.publisher_name.length + 3)];
    
    if (dataModel.shouldShowMoreButton) { // 如果文字大于50字
        
        if (dataModel.isOpening) { /// 是否需要展开
            
            _cotentLabel.attributedText = attriStr;
        } else {
            NSMutableAttributedString *attrM = [attriStr attributedSubstringFromRange:NSMakeRange(0, 50 + dataModel.publisher_name.length + 3)].mutableCopy;
            NSString *atttt = @"...点开全文";
            [attrM yy_appendString:atttt];
            
            
            YYTextHighlight *hi = [YYTextHighlight new];
            [hi setColor:[UIColor colorWithRed:0.578 green:0.790 blue:1.000 alpha:1.000]];
            WEAK
            hi.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                STRONG
                if (self.showAllContentTextForwardBlock) {
                    self.showAllContentTextForwardBlock(self.indexPath);
                }
            };
            
            [attrM yy_setColor:MGThemeBackgroundColor range:NSMakeRange(attrM.length - 4, 4)];
            [attrM yy_setTextHighlight:hi range:NSMakeRange(attrM.length - 4, 4)];
            
            
            
            _cotentLabel.attributedText = attrM;
        }
        
    } else {
        
        _cotentLabel.attributedText = attriStr;
    }
    
    _cotentLabel.height = [YYTextLayout layoutWithContainerSize:CGSizeMake(kScreenWidth - SW(60), HUGE) text:_cotentLabel.attributedText].textBoundingSize.height;
    
    
    CGFloat picContainerTopMargin = 0;
    if (dataModel.pic_rsurls.count) {
        picContainerTopMargin = SH(20);
    }
    _photosContainerView.y = _cotentLabel.bottom + picContainerTopMargin;
    
    self.height = _photosContainerView.bottom + SH(30);
    
}


@end
