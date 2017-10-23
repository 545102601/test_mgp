//
//  MGSplashView.m
//  TDBeijiaBill
//
//  Created by zhenyong on 2017/5/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//
#define MGSplashNumberOfPages 4

#import "MGSplashView.h"
#import "YNPageControl.h"

@interface MGSplashView ()
/**内容*/
@property (nonatomic, strong) UIScrollView *contentView;
/**底部点*/
@property (nonatomic, strong) YNPageControl *pageControl;

@end

@implementation MGSplashView

-(instancetype)init{
    self = [super initWithFrame:KeyWindow.frame];
    [self initSubViews];
    return self;
}

- (void)initSubViews{
    //内容视图
    _contentView = [[UIScrollView alloc]initWithFrame:KeyWindow.frame];
    _contentView.contentSize = CGSizeMake(Screen_Width * MGSplashNumberOfPages, Screen_Height);
    _contentView.pagingEnabled = YES;
    _contentView.bounces = NO;
    _contentView.delegate = self;
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_contentView];
    //滚动视图
    for (int i = 1; i <= MGSplashNumberOfPages; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"splash%d",i]];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width*(i-1), 0, Screen_Width, Screen_Height)];
        imageView.image = image;
        [_contentView addSubview:imageView];
        if (i == MGSplashNumberOfPages) { 
            UIButton *nextButton = [MGUITool buttonWithBGColor:nil title:@"立即进入" titleColor: MGThemeColor_Title_Black font:MGThemeFont_36 target:self selector:@selector(nextButtonOnClick:)];
            [nextButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
            [nextButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
             nextButton.frame = CGRectMake(imageView.x+SW(50), Screen_Height-SH(240), SW(650), SH(88));
            
            [_contentView addSubview:nextButton];
        }
    }
    
    YNPageControl * pageControl = [[YNPageControl alloc] init];
    [pageControl setCenter: CGPointMake(self.center.x, self.height - SH(134))];
    [pageControl setNumberOfPages: MGSplashNumberOfPages];
    [pageControl setCurrentPage: 0];
    [pageControl setPageType:YNPageControlTypeOnFullOffEmpty];
    
    [pageControl setOnColor: MGThemeShenYellowColor];
    [pageControl setOffColor: MGThemeShenYellowColor];
     pageControl.insetColor = [UIColor whiteColor];
    [pageControl setIndicatorDiameter: SH(16.0f)];
    [pageControl setIndicatorSpace: SW(22.0f)];

    
    [self addSubview:pageControl];
    _pageControl = pageControl;
}
#pragma mark--event
-(void)show{
    [KeyWindow addSubview:self];
}
-(void)hide{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)nextButtonOnClick:(UIButton *)button{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [SESSION_MANAGER setLastAppVersion:currentVersion];
    [self hide];
}

#pragma mark--delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x / Screen_Width;
    _pageControl.currentPage = page;
}
@end
