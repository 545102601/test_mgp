//
//  MGFoundCellContentView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/4.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGFoundCellContentView.h"
#import <YYText.h>
#import "MGFoundCellForwardView.h"
#import "MGFoundCellPhotosCotainerView.h"

@interface MGFoundCellContentView ()

@property (nonatomic, strong) YYLabel *cotentLabel;
/// 图片
@property (nonatomic, strong) MGFoundCellPhotosCotainerView *photosContainerView;
/// 转发
@property (nonatomic, strong) MGFoundCellForwardView *forwardView;

@property (nonatomic, strong) UILabel *citiyLabel;


@end


@implementation MGFoundCellContentView

- (void)prepareFrameViewUI:(CGRect)frame {
    
    _cotentLabel = [YYLabel new];
    _cotentLabel.userInteractionEnabled = YES;
    _cotentLabel.numberOfLines = 0;
    _cotentLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _cotentLabel.frame = CGRectMake(SW(30), 0, frame.size.width - SW(60), 0);
    _cotentLabel.font = PFSC(28);
    _cotentLabel.textColor = MGThemeColor_Common_Black;
    
    
    _forwardView = [[MGFoundCellForwardView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    
    
    _photosContainerView = [[MGFoundCellPhotosCotainerView alloc] initWithFrame:CGRectMake(SW(30), 0, 0, 0)];
    
    _citiyLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_subTitle_Black font:PFSC(24)];
    _citiyLabel.frame = CGRectMake(SW(30), 0, SW(200), _citiyLabel.fontLineHeight);
    
    
    [self addSubview:_cotentLabel];
    [self addSubview:_forwardView];
    [self addSubview:_photosContainerView];
    [self addSubview:_citiyLabel];
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

- (void)setDataModel:(MGResTrendListDataModel *)dataModel {
    _dataModel = dataModel;
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:dataModel.content];
    attriStr.yy_font = PFSC(28);
    attriStr.yy_color = MGThemeColor_Common_Black;
    attriStr.yy_lineSpacing = SH(8);
    _photosContainerView.picPathStringsArray = dataModel.pic_rsurls;
    
    _citiyLabel.text = [NSString stringWithFormat:@"来自%@",dataModel.city];
    
    if (dataModel.shouldShowMoreButton) { // 如果文字大于50字

        if (dataModel.isOpening) { /// 是否需要展开
            
            _cotentLabel.attributedText = attriStr;
        } else {
            NSMutableAttributedString *attrM = [attriStr attributedSubstringFromRange:NSMakeRange(0, 50)].mutableCopy;
            NSString *atttt = @"...点开全文";
            [attrM yy_appendString:atttt]; 
        
            
            YYTextHighlight *hi = [YYTextHighlight new];
            [hi setColor:[UIColor colorWithRed:0.578 green:0.790 blue:1.000 alpha:1.000]];
            WEAK
            hi.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                STRONG
                if (self.showAllContentTextBlock) {
                    self.showAllContentTextBlock(self.indexPath);
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
    
    CGFloat viewBottom = _photosContainerView.bottom;
    
    /// 有转发就没有图片
    if (dataModel.forward_trend) {
        _forwardView.hidden = NO;
        _forwardView.y = _cotentLabel.bottom + SH(20);
        _forwardView.showAllContentTextForwardBlock = _showAllContentTextForwardBlock;
        _forwardView.forwardBgViewTapBlock = _forwardBgViewTapBlock;
        _forwardView.dataModel = dataModel.forward_trend;
        _forwardView.indexPath = self.indexPath;
        viewBottom = _forwardView.bottom;
    } else {
        _forwardView.hidden = YES;
        _forwardView.y = 0;
        _forwardView.height = 0;
    }
    
    
    
    /// 城市
    CGFloat cityMargin = 0;
    if (dataModel.city.length > 0) {
        cityMargin = SH(20);
        _citiyLabel.height = _citiyLabel.fontLineHeight;
    } else {
        _citiyLabel.height = 0;
    }
    _citiyLabel.y = viewBottom + cityMargin;
    
    if (dataModel.city.length > 0) {
        self.height = _citiyLabel.bottom + SH(30);
    } else {
        self.height = viewBottom + SH(30);
    }
    
}
@end
