//
//  MGCommonWKWebViewVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGCommonWKWebViewVC.h"

#import<WebKit/WebKit.h>

@interface MGCommonWKWebViewVC ()<WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *contentWebview;

@end

@implementation MGCommonWKWebViewVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标题
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.titleString;
    
    // 取消黑色背景
    self.contentWebview                                     = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64)];
    self.contentWebview.opaque                              = NO;
    self.contentWebview.backgroundColor                     = [UIColor hexColorWithString:@"#edeff3"];
    self.contentWebview.navigationDelegate                  = self;
    self.contentWebview.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.contentWebview];
    
    // HUD
    [TDLoading showViewInView:self.view];
    
    // 加载地址
    NSURL *url          = [NSURL URLWithString:self.urlString];
    NSURLRequest *req   = [NSURLRequest requestWithURL:url];
    [self.contentWebview loadRequest:req];
}

#pragma mark - Event Response
#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate
#pragma mark - --WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //    self.navigationItem.title = webView.title;
    [TDLoading hideViewInView:self.view];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [TDLoading hideViewInView:self.view];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    // 解决WKwebview H5不能调用拨打电话问题。
    NSURL *URL       = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    
    if ([scheme isEqualToString:@"tel"]) {
        NSString *resourceSpecifier = [URL resourceSpecifier];
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", resourceSpecifier];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter


- (void)dealloc {
    /// 删除缓存
    NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                               NSUserDomainMask, YES)[0];
    NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]
                            objectForKey:@"CFBundleIdentifier"];
    NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
    NSString *webKitFolderInCaches = [NSString
                                      stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
    NSString *webKitFolderInCachesfs = [NSString
                                        stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
    
    NSError *error;
    /* iOS8.0 WebView Cache的存放路径 */
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
    [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
    
    /* iOS7.0 WebView Cache的存放路径 */
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCachesfs error:&error];
}

@end
