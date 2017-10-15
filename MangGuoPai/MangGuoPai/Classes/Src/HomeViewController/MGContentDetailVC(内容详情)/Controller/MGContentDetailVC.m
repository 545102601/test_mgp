//
//  MGContentDetailVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGContentDetailVC.h"
#import "MGResContentModel.h"
#import "NSString+HTMLImageAdapt.h"

static  NSString *js_NotAlert = @"document.documentElement.style.webkitTouchCallout='none';";

static  NSString *js_NotSelect = @"document.documentElement.style.webkitUserSelect='none';";

static NSString *webCellID = @"webCell";


@interface MGContentDetailVC () <UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate, UIGestureRecognizerDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UIWebView * webView;

@property (weak, nonatomic)  UITableView *tableView;

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, strong) MGResContentDataModel *dataModel;

@end

@implementation MGContentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarYellowAndWhiteBackButton];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth , kScreenHeight - 64) style:UITableViewStylePlain];
    tableView.backgroundColor = MGBackgroundViewColor;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = NO;
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:webCellID];
    
    [self.tableView reloadData];
    
}


#pragma mark - 初始化控件
- (void)setupSubViews {
    

}

#pragma mark - 加载数据
- (void)loadData {

    
    if (self.type == ContentDetailSouceTypeCommon) {
        
        [MGBussiness loadContentDetailData:@{@"id" : @(self.id)} completion:^(MGResContentDataModel *dataModel) {
            self.title = dataModel.title;
            self.dataModel = dataModel;
            [self.tableView reloadData];
        } error:nil];
        
    } else {
        [MGBussiness loadHomeBulletinDetailDataWithId:self.id completion:^(MGResContentDataModel *dataModel) {
            self.title = dataModel.title;
            self.dataModel = dataModel;
            [self.tableView reloadData];
        } error:nil];
    }
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!self.dataModel) {
        return 0;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:webCellID];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    if (!self.webView) {
        UIWebView * webView = [[UIWebView alloc] initWithFrame:cell.contentView.bounds];
        webView.tag              = 100030;
        webView.scalesPageToFit = YES;
        webView.delegate         = self;
        webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        webView.opaque = NO; //不设置这个值 页面背景始终是白色
//        webView.scrollView.scrollEnabled = NO;
        cell.contentView.backgroundColor = MGBackgroundViewColor;
        webView.backgroundColor = MGBackgroundViewColor;
        NSString *basePath = [[NSBundle mainBundle] resourcePath];
        NSURL *   baseURL  = [NSURL fileURLWithPath:basePath];
        NSString *html = [self generateHtml];
        
//        html = [self reSizeImageWithHTMLHadHead:html];
        [webView loadHTMLString:html baseURL:baseURL];
        [cell addSubview:webView];
        webView.frame = cell.contentView.bounds;
        self.webView = webView;
        //长按手势
        UILongPressGestureRecognizer* longPressed = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
        longPressed.delegate = self;
        [self.webView addGestureRecognizer:longPressed];
    }
    return cell;
}
#pragma mark - 长按手势
- (void)longPressed:(UILongPressGestureRecognizer*)recognizer{
    
    if (recognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    CGPoint touchPoint = [recognizer locationInView:self.webView];
    
    NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
    NSString *urlToSave = [self.webView stringByEvaluatingJavaScriptFromString:imgURL];
    
    if (urlToSave.length == 0) {
        return;
    }
    
    [self showImageOptionsWithUrl:urlToSave];
    
}

- (void)showImageOptionsWithUrl:(NSString *)imageUrl
{
    self.imageUrl = imageUrl;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片", nil];
    
    [actionSheet showInView:self.view];
    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        [self saveImageToDiskWithUrl:self.imageUrl];
    }else{
        self.imageUrl = nil;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight - 64;
    return [self cellHeightForWebView:self.webView] + SH(100);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    
//    self.webView.frame = CGRectMake(0, 0, webView.scrollView.frame.size.width, webView.scrollView.contentSize.height);
    self.webView.height = kScreenHeight - 64;
    
    [self.tableView reloadData];
    
}

#pragma mark - 商品列表加载
-(NSString* )generateHtml{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    
    [html appendString:@"<meta name=\"viewport\" content=\"width=device-width; minimum-scale=1.0; maximum-scale=1.0; user-scalable=0;\"/>"];
    
    [html appendString:@"<link rel=\"stylesheet\" type=\"text/css\" href=\"content.css\" media=\"screen\" /> "];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body style=\"background-color: transparent\" >"];
    
    
    NSString *productmessage = self.dataModel.content;
    
    
//    NSString *string=[productmessage htmlImageAdaptWith:(long)self.view.frame.size.width-16];
    
    [html appendFormat:@"%@",productmessage?productmessage:@""];
    [html appendString:@"<div id=\"footer\"></div>"];
    [html appendString:@"</body></html>"];
    return html;
    
}


/**
 *  セルの高さ計算
 *
 *  @param webView 計算対象のUIWebView
 *
 *  @return WebViewの高さ
 */
- (NSInteger)cellHeightForWebView:(UIWebView *)webView
{
    //    NSString *javascript = @"document.documentElement.scrollHeight;";
    //    NSInteger height = [[webView stringByEvaluatingJavaScriptFromString:javascript] integerValue];
    
    return webView.scrollView.contentSize.height;
}

#pragma mark - Private Method

- (NSString *)reSizeImageWithHTMLHadHead:(NSString *)html {
    
    NSString *str = [NSString stringWithFormat:@"<head><style>img{width:%fpx !important;}</style>",self.view.frame.size.width-16];
    
    return [html stringByReplacingOccurrencesOfString:@"<head>" withString:str];
}

//保存图片
- (void)saveImageToDiskWithUrl:(NSString *)imageUrl
{
    
    [TDLoading showViewInKeyWindow];
    
    NSURL *url = [NSURL URLWithString:imageUrl];
    
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue new]];
    
    NSURLRequest *imgRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0];
    
    NSURLSessionDownloadTask  *task = [session downloadTaskWithRequest:imgRequest completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [TDLoading hideViewInKeyWindow];
        if (error) {
            return ;
        }
        
        NSData * imageData = [NSData dataWithContentsOfURL:location];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIImage * image = [UIImage imageWithData:imageData];
            
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        });
    }];
    
    [task resume];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (error) {
            [self showMBText:@"保存失败"];
        }else{
            [self showMBText:@"保存成功"];
        }
    });
}


@end
