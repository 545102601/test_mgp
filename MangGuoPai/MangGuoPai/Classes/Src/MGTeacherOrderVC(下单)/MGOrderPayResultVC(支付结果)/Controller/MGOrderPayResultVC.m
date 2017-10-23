//
//  MGOrderPayResultVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/17.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGOrderPayResultVC.h"
#import "MGOrderPayResultView.h"
#import "MGMyOrderVC.h"
#import "MGTeacherClassDetailVC.h"

@interface MGOrderPayResultVC ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *resultImageView;

@property (nonatomic, strong) UILabel *resultLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, copy) NSArray *leftArray;

@end

@implementation MGOrderPayResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    /// self取得的navigationControler 为nil
    UINavigationController *nav = ApplicationDelegate.mainTabbarVC.selectedViewController;
    nav.interactivePopGestureRecognizer.enabled = YES;
    
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    
    _leftArray = @[@"商品名称",
                   @"订单号",
                   @"支付方式",
                   @"交易时间"];
    
    NSString *time = [[NSDate date] formattedStringWithFormat:@"yyyy年MM月dd日"];
    
    NSArray *rightArray = @[self.listDataModel.order_name, self.listDataModel.order_no, self.payWay, time];
    
    
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight - 64);
    
    BOOL result = self.isPaySuccess;
    
    NSString *resultImage = result ? @"order_pay_success" : @"order_pay_fail";
    NSString *resultText = result ? @"支付成功 ! " : @"支付失败 ! ";
    
    
    _resultImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SH(34), SW(178), SW(178))];
    _resultImageView.image = [UIImage imageNamed:resultImage];
    _resultImageView.centerX = self.view.centerX;
    
    _resultLabel = [MGUITool labelWithText:resultText textColor:MGThemeColor_Black font:PFSC(30) textAlignment:NSTextAlignmentCenter];
    _resultLabel.frame = CGRectMake(0, _resultImageView.bottom + SH(16), kScreenWidth, _resultLabel.fontLineHeight);
    
    
    NSString *money = [NSString stringWithFormat:@"%@元", [TDCommonTool formatPriceWithDoublePrice:100]];
    
    _moneyLabel = [MGUITool labelWithText:money textColor:MGThemeColor_Black font:PFSC(42) textAlignment:NSTextAlignmentCenter];
    _moneyLabel.frame = CGRectMake(0, _resultLabel.bottom + SH(56), kScreenWidth, _resultLabel.fontLineHeight);
    
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _moneyLabel.bottom + SH(58), kScreenWidth, MGSepLineHeight)];
    _lineView.backgroundColor = MGSepColor;
    
    [_scrollView sd_addSubviews:@[_resultImageView, _resultLabel, _moneyLabel, _lineView]];
    
    CGFloat top = _lineView.bottom + SH(20);
    for (int i = 0; i < _leftArray.count; i++) {
        MGOrderPayResultView *resultView = [[MGOrderPayResultView alloc] initWithFrame:CGRectMake(0, top + i * SH(50), kScreenWidth, kScreenHeight)];
        resultView.leftLabel.text = _leftArray[i];
        resultView.rightLabel.text = rightArray[i];
        [_scrollView addSubview:resultView];
    }
    
    [self.view addSubview:_scrollView];
}

#pragma mark - 加载数据
- (void)loadData {

}



- (void)backButtonAction:(UIButton *)button {

    UIViewController *resultVC;
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[MGTeacherClassDetailVC class]]) {
            resultVC = vc;
            break;
        }
    }
    if (!resultVC) {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[MGMyOrderVC class]]) {
                resultVC = vc;
                break;
            }
        }
    }
    
    if (resultVC) {
        [self.navigationController popToViewController:resultVC animated:YES];
    } else {
        PopVC
    }
    

}

@end
