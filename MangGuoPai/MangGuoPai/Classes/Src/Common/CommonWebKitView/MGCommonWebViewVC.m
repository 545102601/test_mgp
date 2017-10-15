//
//  MGCommonWebViewVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGCommonWebViewVC.h"
#import "YHWebViewProgress.h"
#import "YHWebViewProgressView.h"

@interface MGCommonWebViewVC ()<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;

@property (strong, nonatomic) UIView <YHWebViewProgressViewProtocol> *progressView;

@property (strong, nonatomic) YHWebViewProgress *progressProxy;

@end


@implementation MGCommonWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarYellowAndWhiteBackButton];
}

- (void)setupSubViews {
    
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    [self.view addSubview:webView];
    self.webView = webView;
    
    self.webView.backgroundColor = [UIColor whiteColor];
    
    
    // 创建进度条
    // 创建进度条代理，用于处理进度控制
    _progressProxy = [[YHWebViewProgress alloc] init];
    
    // 创建进度条
    YHWebViewProgressView *progressView = [[YHWebViewProgressView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 2)];
    progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
    
    // 设置进度条
    self.progressProxy.progressView = progressView;
    // 将UIWebView代理指向YHWebViewProgress
    self.webView.delegate = self.progressProxy;
    // 设置webview代理转发到self（可选）
    self.progressProxy.webViewProxy = self;
    progressView.progressBarColor = MGThemeShenYellowColor;
    // 添加到视图
    [self.view addSubview:progressView];
    self.progressView = progressView;
    
    
     [self requestHttp];
}


- (void)requestHttp{
    
    //请求url
    if (self.urlString) {
        NSMutableString* paramstr = [[NSMutableString alloc] init];
        
        if (self.params) {
            for (NSString* key in self.params.allKeys) {
                [paramstr appendFormat:@"%@=%@&",key,[self.params[key] stringByURLEncode]];
            }
        }
        NSString* finalParam = nil;
        if ([paramstr hasSuffix:@"&"]) {
            finalParam = [paramstr substringToIndex:(paramstr.length-1)];
        }
        if (finalParam) {
            self.urlString = [NSString stringWithFormat:@"%@?%@",self.urlString,finalParam];
        }
        
        
        BOOL isContainHanZi = NO;
        for (int i = 0; i < self.urlString.length; ++i)
        {
            NSRange range = NSMakeRange(i, 1);
            NSString *subString = [self.urlString substringWithRange:range];
            const char *cString = [subString UTF8String];
            if (strlen(cString) == 3)
            {
                isContainHanZi = YES;
                break;
            }
        }
        if (isContainHanZi) {// URLEncode编码
            self.urlString = [self.urlString stringByURLEncode];
        }
        
        NSMutableURLRequest *request  = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
        
        [self.webView loadRequest:request];
    }
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.webView.scrollView scrollToTopAnimated:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [self.webView.scrollView scrollToTopAnimated:NO];
    
    //    NSLog(@"==============================webViewDidFinishLoad");
    
    //禁止用户选择
//    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
//    //禁止长按弹出选择框
//    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    if (self.titleString.length == 0) {
        //获取标题
        self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
    
}


@end
