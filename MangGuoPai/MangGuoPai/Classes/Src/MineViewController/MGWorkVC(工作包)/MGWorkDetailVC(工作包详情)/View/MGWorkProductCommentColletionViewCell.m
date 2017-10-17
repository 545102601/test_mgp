//
//  MGWorkProductCommentColletionViewCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/16.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkProductCommentColletionViewCell.h"

@interface MGWorkProductCommentColletionViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation MGWorkProductCommentColletionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(75), SH(20), kScreenWidth - SW(150), kMGWorkProductCommentColletionViewCellHeight - SH(40))];
    _iconImageView.clipsToBounds = YES;
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_iconImageView];
    
}

- (void)setUrl:(NSString *)url {
    _url = url;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:SDWEB_PLACEHODER_IMAGE(_iconImageView)];
}



@end
