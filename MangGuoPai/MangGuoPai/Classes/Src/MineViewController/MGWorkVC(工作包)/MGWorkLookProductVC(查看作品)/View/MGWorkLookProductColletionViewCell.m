//
//  MGWorkLookProductColletionViewCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/15.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkLookProductColletionViewCell.h"

@interface MGWorkLookProductColletionViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation MGWorkLookProductColletionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(75), SH(20), kScreenWidth - SW(150), kMGWorkLookProductColletionViewCellHeight - SH(40))];
    _iconImageView.clipsToBounds = YES;
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_iconImageView];
    
}

- (void)setUrl:(NSString *)url {
    _url = url;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:url scaleWidth:_iconImageView.width] placeholderImage:SDWEB_PLACEHODER_IMAGE(_iconImageView)];
}


@end
