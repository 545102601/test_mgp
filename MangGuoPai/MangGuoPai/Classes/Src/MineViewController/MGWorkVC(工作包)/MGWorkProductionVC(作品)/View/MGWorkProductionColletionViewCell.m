//
//  MGWorkProductionColletionViewCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/14.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkProductionColletionViewCell.h"
#import <UIButton+WebCache.h>


@interface MGWorkProductionColletionViewCell ()

@property (nonatomic, strong) UIButton *contentButton;

@end

@implementation MGWorkProductionColletionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = [self.class getItemWidth];
        
        _contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _contentButton.frame = CGRectMake(0, 0, width , width);
        _contentButton.tag = 1001;
        [_contentButton addTarget:self action:@selector(cellButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView sd_addSubviews:@[_contentButton]];
        
        
    }
    return self;
}

+ (CGFloat)getItemWidth {
    
    return (kScreenWidth - SW(120) - 3*SW(75)) / 4;
}


- (void)setUrl:(NSString *)url {
    _url = url;
    
    [self matchUrlExtension:url];
    
}
/// 按钮
- (void)cellButtonOnClick:(UIButton *)btn {
    
    if (_buttonEventBlock) {
        _buttonEventBlock(self.item, btn.tag);
    }
}


- (void)matchUrlExtension:(NSString *)url {
    
    NSString *extension = url.pathExtension;
    
    if ([extension isEqualToString:@"excel"]) {
        [_contentButton setBackgroundImage:[UIImage imageNamed:@"order_icon_excel"] forState:UIControlStateNormal];
        
    } else if ([extension isEqualToString:@"word"]) {
        
        [_contentButton setBackgroundImage:[UIImage imageNamed:@"order_icon_word"] forState:UIControlStateNormal];
    } else if ([extension isEqualToString:@"ppt"]) {
        
        [_contentButton setBackgroundImage:[UIImage imageNamed:@"order_icon_ppt"] forState:UIControlStateNormal];
    } else if ([extension isEqualToString:@"pdf"]) {
        
        [_contentButton setBackgroundImage:[UIImage imageNamed:@"order_icon_pdf"] forState:UIControlStateNormal];
    } else {
        [_contentButton sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:SDWEB_PLACEHODER_IMAGE(_contentButton)];
    }
    
}


@end
