//
//  BaseViewController.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "TDUmengStatisticsManger.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        /// 状态栏默认为白色
        self.statusBarIsWhite = NO;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self configNavigationBar];
    
    [self initData];
    [self setupSubViews];
    [self setupSubViewsFrame];
    [self loadData];
    [self registerNotification];
    
    self.view.backgroundColor = MGBackgroundViewColor;
    
    [self setNavigationBarGrayAndBlackBackButton];
    
    /// 先调完这些方法 才会 调用 子类的 viewDidLoad
    
}
/// 配置导航条
- (void)configNavigationBar {
    
    _navigationBar = [[TDNavigationBar alloc] init];
    _navigationBar.backgroundColor = MGThemeBackgroundColor;
    
    _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 - MGSepLineHeight, kScreenWidth, MGSepLineHeight)];
    _topLineView.backgroundColor = MGSepColor;
    /// 添加底部线条
    [_navigationBar addSubview:_topLineView];
    
    TDNotHighlightButton *btn = [TDNotHighlightButton buttonWithFrame:NavigationLeftViewRect
                                                      imageName:@"application_back"
                                                         target:self
                                                       selector:@selector(backButtonAction:)];
    _backBtn = btn;
    
    [_navigationBar addSubview:btn];
    [self.view addSubview:_navigationBar];
    
}



#pragma mark - Public Function

- (void)initData {};

- (void)setupSubViews {};

- (void)setupSubViewsFrame {};

- (void)loadData {};

- (void)registerNotification {};


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

//    NSString *eventID              = [self getEventID];
//    NSMutableDictionary *plistInfo = [UMENG_MANAGER configPlistInfo];
//    TDDetialLog(@"className - %@ - %@ - %@ - %@",
//                eventID,
//                plistInfo[@"event"][@"event_duration"][eventID],
//                plistInfo[@"event"][@"event_time"][eventID],
//                plistInfo);
//    
//    // 次数统计
//    [TDUmengStatisticsManger numberOfStatistics:plistInfo[@"event"][@"event_time"][eventID]];
//    
//    // 停留时间统计
//    [TDUmengStatisticsManger beginEvent:plistInfo[@"event"][@"event_duration"][eventID]];
    
    /// 保证在最前面
    if (!self.navigationBar.hidden) {
        [self.view bringSubviewToFront:self.navigationBar];
    }
    
    if (self.statusBarIsWhite) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    
    
//    NSString *eventID              = [self getEventID];
//    NSMutableDictionary *plistInfo = [UMENG_MANAGER configPlistInfo];
//    
//    // 停留时间统计
//    [TDUmengStatisticsManger endEvent:plistInfo[@"event"][@"event_duration"][eventID]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.view endEditing:YES];
}




#pragma mark - Private Function
//- (NSString *)getEventID {
//    NSString *className = NSStringFromClass([self class]);
//    
//    // 特殊处理
//    if ([className isEqualToString:@"TDGestureLoginVC"]) {
//        TDGestureLoginVC *vc = (TDGestureLoginVC *)self;
//        TDDetialLog(@"type - %ld", vc.gestureType);
//        
//        if (vc.gestureType == TDGestureTypeFingerprint) {
//            className = [NSString stringWithFormat:@"%@_1", className];
//        } else {
//            className = [NSString stringWithFormat:@"%@_0", className];
//        }
//    }
//    
//    return className;
//}


- (void)dealloc {
    
    NSLog(@"dealloc -> %@",[self class]);
}


#pragma mark - getter setter
- (void)setTitle:(NSString *)title {
    
    self.navigationBar.title = title;
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
- (void)backButtonAction:(UIButton *)button {
    
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIViewController *rootVC = self.navigationController.viewControllers[0];
        [rootVC dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function



- (void)setNavigationBarGrayAndBlackBackButton {
    
    self.statusBarIsWhite = NO;
    self.navigationBar.titleColor = MGThemeColor_Title_Black;
    self.navigationBar.backgroundColor = MGThemeColor_Nav_Black;
    [self.backBtn setImage:[UIImage imageNamed:@"application_back"] forState:UIControlStateNormal];
    
}

- (void)setNavigationBarYellowAndWhiteBackButton {
    
    self.statusBarIsWhite = YES;
    self.navigationBar.titleColor = MGThemeColor_Title_Black;
    self.navigationBar.backgroundColor = MGThemeBackgroundColor;
    [self.backBtn setImage:[UIImage imageNamed:@"application_back"] forState:UIControlStateNormal];
    
    
}

- (UIButton *)setRightButtonWithTitle:(NSString *)title
                         target:(id)target
                       selector:(SEL)selector {
   
        UIButton *button = [MGUITool buttonWithBGColor:nil title:title titleColor:MGThemeColor_Title_Black font:PFSC(28) target:target selector:selector];
        [button sizeToFit];
        [button setTitleColor:MGButtonImportNotEnableColor forState:UIControlStateDisabled];
        button.x = self.navigationBar.width - SW(30) - button.width;
        button.centerY = self.navigationBar.titleLabel.centerY;
        [self.navigationBar addSubview:button];
    return button;
}

#pragma mark - Private Function

#pragma mark - Getter and Setter


@end
