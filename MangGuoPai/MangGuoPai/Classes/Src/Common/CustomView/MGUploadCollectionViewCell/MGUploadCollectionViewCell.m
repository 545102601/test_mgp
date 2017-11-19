//
//  MGUploadCollectionViewCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/7.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGUploadCollectionViewCell.h"
#import <UIButton+WebCache.h>

@interface MGUploadCollectionViewCell ()


@property (nonatomic, strong) UIButton *contentButton;

@property (nonatomic, strong) UIButton *deleteButton;


@end

@implementation MGUploadCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = [self.class getItemWidth];
        
        _contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _contentButton.frame = CGRectMake(0, SW(21), width - SW(21), width - SW(21));
        _contentButton.tag = 1001;
        [_contentButton addTarget:self action:@selector(cellButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _deleteButton = [TDExpendClickButtonNotHightLight buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(width - SW(42), 0, SW(42), SW(42));
        [_deleteButton setImage:[UIImage imageNamed:@"mine_icon_del_red"] forState:UIControlStateNormal];
        _deleteButton.tag = 1002;
        [_deleteButton addTarget:self action:@selector(cellButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView sd_addSubviews:@[_contentButton, _deleteButton]];
        
        
    }
    return self;
}

+ (CGFloat)getItemWidth {
    
    return (kScreenWidth - SW(120) - 4*SW(21)) / 5;
}


- (void)setUrl:(NSString *)url {
    _url = url;
    if (![url isEqualToString:@"addButton"]) {
        _deleteButton.hidden = NO;
        [self matchUrlExtension:url];
        
        _deleteButton.hidden = self.hiddenDeleteButton;
    } else {
        _deleteButton.hidden = YES;
        
        NSString *addButtonImageStr = @"found_add_pic";
        if (_addButtonType == CellAddButtonTypeGray) {
            addButtonImageStr = @"mine_icon_add";
        }
    
        [_contentButton setBackgroundImage:[UIImage imageNamed:addButtonImageStr] forState:UIControlStateNormal];
    }
    
    
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
        [_contentButton sd_setBackgroundImageWithURL:[NSURL URLWithString:url scaleWidth:_contentButton.width] forState:UIControlStateNormal placeholderImage:SDWEB_PLACEHODER_IMAGE(_contentButton)];
    }
    
}



@end
