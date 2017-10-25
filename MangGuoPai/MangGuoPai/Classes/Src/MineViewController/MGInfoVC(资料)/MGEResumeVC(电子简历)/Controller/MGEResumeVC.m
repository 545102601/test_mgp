//
//  MGEResumeVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/19.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGEResumeVC.h"
#import <YYText.h>
#import <UIButton+WebCache.h>
#import "MGCommonWKWebViewVC.h"

@interface MGEResumeVC ()
@property (nonatomic, strong) UIView *resumeBgView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *resumeButton;

/// 底部提示
@property (nonatomic, strong) UILabel *bottomTipLabel;

@end

@implementation MGEResumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"电子版简历";
    
}

#pragma mark - 初始化数据
- (void)initData {

}

#pragma mark - 初始化控件
- (void)setupSubViews {

    _resumeBgView = [[UIView alloc] initWithFrame:CGRectMake(0, SH(30) + 64, SW(500), SH(200))];
    _resumeBgView.centerX = self.view.centerX;
    [_resumeBgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resumeButtonOnClick)]];
    
    _resumeButton = [TDNotHighlightButton buttonWithType:UIButtonTypeCustom];
    [_resumeButton setTitleColor:MGThemeColor_Common_Black forState:UIControlStateNormal];
    _resumeButton.frame = CGRectMake(SW(30), 0, SW(90), SH(90));
    _resumeButton.centerY = _resumeBgView.height * 0.5;
    
    _timeLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(26)];
    _timeLabel.frame = CGRectMake(_resumeButton.right + SW(30), 0, SW(450), _timeLabel.fontLineHeight);
    _timeLabel.centerY = _resumeBgView.height * 0.5;
    
    
    
    _bottomTipLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28) textAlignment:NSTextAlignmentCenter];
    _bottomTipLabel.frame = CGRectMake(SW(30), _resumeBgView.bottom + SH(40), kScreenWidth - SW(60), _bottomTipLabel.fontLineHeight * 2 + SH(20));
    NSString *bottomTipText = @"您可以在PC端登录www.enjoymangopi.com , 使用\r\n电脑上传照片、Word、PPT等文件";
    NSMutableAttributedString *ATTRS = [bottomTipText addLineSpaceWithfont:PFSC(28) lineSpace:SH(20) color:MGThemeColor_Common_Black];
    [ATTRS setYy_alignment:NSTextAlignmentCenter];
    _bottomTipLabel.attributedText = ATTRS;
    
    
    [_resumeBgView sd_addSubviews:@[_resumeButton, _timeLabel]];
    
    [self.view addSubview:_resumeBgView];
    
    [self.view addSubview:_bottomTipLabel];
    
    
    if (self.resumeUrl.length == 0) {
        
        _timeLabel.text = @"还未上传文件";
        
        _timeLabel.x = _resumeButton.right + SH(55);
        
    } else {
        _resumeButton.centerX = _resumeBgView.width * 0.5;
        [self matchUrlExtension:self.resumeUrl];
        
//        _timeLabel.text = @"还未上传文件";
        
    }
    
}

- (void)resumeButtonOnClick {
    if (self.resumeUrl.length == 0) return;
    
    MGCommonWKWebViewVC *vc = [MGCommonWKWebViewVC new];
    vc.titleString = @"预览文件";
    vc.urlString = self.resumeUrl;
    PushVC(vc)
}

- (void)matchUrlExtension:(NSString *)url {
    
    NSString *extension = url.pathExtension;
    
    if ([extension isEqualToString:@"excel"]) {
        [_resumeButton setBackgroundImage:[UIImage imageNamed:@"order_icon_excel"] forState:UIControlStateNormal];
        
    } else if ([extension isEqualToString:@"word"]) {
        
        [_resumeButton setBackgroundImage:[UIImage imageNamed:@"order_icon_word"] forState:UIControlStateNormal];
    } else if ([extension isEqualToString:@"ppt"]) {
        
        [_resumeButton setBackgroundImage:[UIImage imageNamed:@"order_icon_ppt"] forState:UIControlStateNormal];
    } else if ([extension isEqualToString:@"pdf"]) {
        
        [_resumeButton setBackgroundImage:[UIImage imageNamed:@"order_icon_pdf"] forState:UIControlStateNormal];
    } else {
        

        [_resumeButton sd_setImageWithURL:[NSURL URLWithString:url scaleWidth:_resumeButton.width] forState:UIControlStateNormal placeholderImage:SDWEB_PLACEHODER_IMAGE(_resumeButton)];
    }
    
}


@end
