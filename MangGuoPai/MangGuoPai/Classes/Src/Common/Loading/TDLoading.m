//
//  TDLoading.m
//  TDQianxiaoer
//
//  Created by zhenyong on 2017/3/31.
//  Copyright © 2017年 TDMarket. All rights reserved.
//

#import "TDLoading.h"

@implementation TDLoading

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init{
    self = [super init];
    self.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
    [self setUpSubView];
    return self;
}
-(void)setUpSubView{
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    self.bgView.alpha = 0.3;
    
    self.bgView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.bgView];
    [self addSubview:self.indicatorView];
    
}

#pragma mark--lazy
- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _indicatorView.center = CGPointMake(kScreenWidth * 0.5, kScreenHeight * 0.5);
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        _indicatorView.hidesWhenStopped = YES;
    }
    return _indicatorView;
}

//-(UIImageView *)loadingImageView{
//    if (_loadingImageView == nil) {
//        _loadingImageView = [[UIImageView alloc]initWithFrame:CGRectMake((Screen_Width-getScaleWidth(150))/2, 0, getScaleWidth(150) * 1.5, getScaleWidth(100) * 1.5)];
//        _loadingImageView.center = self.center;
//        NSMutableArray *imageArr = [NSMutableArray array];
//        for (int i = 0; i < 30; i++) {
//            if (i < 10) {
//                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_0000%d",i]];
//                [imageArr addObject:image];
//            }else{
//                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_000%d",i]];
//                [imageArr addObject:image];
//
//            }
//            
//        }
//        _loadingImageView.animationImages = imageArr;
//        _loadingImageView.animationRepeatCount = 0;
//        
//    
//        
//        // 设置动画的时间
//        _loadingImageView.animationDuration = imageArr.count * 0.08;
//    }
//    return _loadingImageView;
//}
- (void)show{
    
    self.bgView.alpha = 0;
    [self.indicatorView startAnimating];
    __weak TDLoading *weakSelf = self;
    [UIView animateWithDuration:0.1 animations:^{
        weakSelf.bgView.alpha = 0.3;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)hide{
    self.bgView.alpha = 0.3;
    __weak TDLoading *weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf.indicatorView stopAnimating];
        [weakSelf removeFromSuperview];
    }];
}


/// 显示在对应的View
+ (instancetype)showViewInView:(UIView *)inView {
    TDLoading *loadingView = [KeyWindow viewWithTag:1000001];
    if (loadingView) {
        /// 已经存在了
        return loadingView;
    }
    loadingView = [[TDLoading alloc]init];
    loadingView.tag = 1000001;
    [inView addSubview:loadingView];
    [loadingView show];
    return loadingView;
}
+ (void)hideViewInView:(UIView *)inView {
    TDLoading *loadingView = [inView viewWithTag:1000001];
    if (loadingView) {
        [loadingView hide];
    }
}


/// 显示在主窗体
+ (instancetype)showViewInKeyWindow {
    return [self showViewInView:KeyWindow];
}
+ (void)hideViewInKeyWindow {
    [self hideViewInView:KeyWindow];
}

@end
