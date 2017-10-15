//
//  YNQRcodeViewController.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/22.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#define notAllowAccessCemera @"请在iPhone的“设置-隐私-相机”选项中，允许应用访问你的相机"

#import "YNQRcodeViewController.h"


@interface YNQRcodeViewController ()<AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate>
{
    AVCaptureSession * session;//输入输出的中间桥梁
    int line_tag;
    UIView *highlightView;
}

@end

@implementation YNQRcodeViewController

/**
 *
 *  viewDidLoad
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self instanceDevice];
}

/**
 *
 *  配置相机属性
 */
- (void)instanceDevice{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    line_tag = 1872637;
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    if (input) {
        [session addInput:input];
    }
    if (output) {
        [session addOutput:output];
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        NSMutableArray *a = [[NSMutableArray alloc] init];
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
            [a addObject:AVMetadataObjectTypeQRCode];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN13Code]) {
            [a addObject:AVMetadataObjectTypeEAN13Code];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN8Code]) {
            [a addObject:AVMetadataObjectTypeEAN8Code];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode128Code]) {
            [a addObject:AVMetadataObjectTypeCode128Code];
        }
        output.metadataObjectTypes=a;
    }
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    
    [self setOverlayPickerView];
    
    [session addObserver:self forKeyPath:@"running" options:NSKeyValueObservingOptionNew context:nil];
    
    //开始捕获
    [session startRunning];
}


/**
 *
 *  监听扫码状态-修改扫描动画
 */
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    if ([object isKindOfClass:[AVCaptureSession class]]) {
        BOOL isRunning = ((AVCaptureSession *)object).isRunning;
        if (isRunning) {
            [self addAnimation];
        }else{
            [self removeAnimation];
        }
    }
}
/**
 *
 *  获取扫码结果
 */
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        [session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex :0];
        NSLog(@"%@->",metadataObject.type);
        //输出扫描字符串
        NSString *data = metadataObject.stringValue;
        if (_didReceiveBlock) {
            //QRCode 是二维码  org.gs1.EAN-13 条形码等
            _didReceiveBlock(data,metadataObject.type);
            [self selfRemoveFromSuperview];
        } else {
            if (IS_VAILABLE_IOS8) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"扫码" message:data preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [session startRunning];
                }]];
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫码" message:data delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
                [alert show];
            }
        }
    }
}

/**
 *
 *  未识别(其他)的二维码提示点击"好",继续扫码
 *
 *  @param alertView
 */
- (void)alertViewCancel:(UIAlertView *)alertView {
    [session startRunning];
}


/**
 *
 *  创建扫码页面
 */
- (void)setOverlayPickerView
{
    //左侧的view
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, self.view.frame.size.height)];
    leftView.alpha = 0.5;
    leftView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:leftView];
    //右侧的view
    UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-30, 0, 30, self.view.frame.size.height)];
    rightView.alpha = 0.5;
    rightView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:rightView];
    
    //最上部view
    UIImageView* upView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, self.view.frame.size.width-60, (self.view.center.y-(self.view.frame.size.width-60)/2))];
    upView.alpha = 0.5;
    upView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:upView];
    
    //底部view
    UIImageView * downView = [[UIImageView alloc] initWithFrame:CGRectMake(30, (self.view.center.y+(self.view.frame.size.width-60)/2), (self.view.frame.size.width-60), (self.view.frame.size.height-(self.view.center.y-(self.view.frame.size.width-60)/2)))];
    downView.alpha = 0.5;
    downView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:downView];
    
    UIImageView *centerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-60, self.view.frame.size.width-60)];
    centerView.center = self.view.center;
    centerView.image = [UIImage imageNamed:@"qrcode_border"];
    centerView.contentMode = UIViewContentModeScaleAspectFit;
    centerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:centerView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(upView.frame), self.view.frame.size.width-60, 2)];
    line.tag = line_tag;
    line.image = [UIImage imageNamed:@"qrcode_line"];
    line.contentMode = UIViewContentModeScaleAspectFill;
    line.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line];
    
    UILabel *msg = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMinY(downView.frame), self.view.frame.size.width-60, 60)];
    msg.backgroundColor = [UIColor clearColor];
    msg.textColor = [UIColor whiteColor];
    msg.textAlignment = NSTextAlignmentCenter;
    msg.font = [UIFont systemFontOfSize:16];
//    msg.text = @"将二维码放入框内,即可自动扫描";
    msg.hidden = YES;
    [self.view addSubview:msg];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-100, self.view.frame.size.width, 100)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:24];
    label.text = @"扫一扫,让旅行更轻松";
    label.hidden = YES;
    [self.view addSubview:label];
    
    
    CGRect leftFrame;
    leftFrame = CGRectMake(-2, 10, 60, 64);
    UIButton *leftButton= [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame =leftFrame;
    [leftButton addTarget:self action:@selector(dismissOverlayView:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"qrcode_back"] forState:UIControlStateNormal];
    [self.view addSubview:leftButton];
}

/**
 *
 *  添加扫码动画
 */
- (void)addAnimation{
    UIView *line = [self.view viewWithTag:line_tag];
    line.hidden = NO;
    CABasicAnimation *animation = [self.class moveYTime:2 fromY:[NSNumber numberWithFloat:0] toY:[NSNumber numberWithFloat:self.view.frame.size.width-60-2] rep:OPEN_MAX];
    [line.layer addAnimation:animation forKey:@"LineAnimation"];
}

+ (CABasicAnimation *)moveYTime:(float)time fromY:(NSNumber *)fromY toY:(NSNumber *)toY rep:(int)rep
{
    CABasicAnimation *animationMove = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    [animationMove setFromValue:fromY];
    [animationMove setToValue:toY];
    animationMove.duration = time;
    animationMove.delegate = self;
    animationMove.repeatCount  = rep;
    animationMove.fillMode = kCAFillModeForwards;
    animationMove.removedOnCompletion = NO;
    animationMove.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return animationMove;
}


/**
 *
 *  去除扫码动画
 */
- (void)removeAnimation{
    UIView *line = [self.view viewWithTag:line_tag];
    [line.layer removeAnimationForKey:@"LineAnimation"];
    line.hidden = YES;
}

/**
 *  扫码取消button方法
 */
- (void)dismissOverlayView:(id)sender{
    [self selfRemoveFromSuperview];
}

/**
 *
 *  从父视图中移出
 */
- (void)selfRemoveFromSuperview{
    [session removeObserver:self forKeyPath:@"running" context:nil];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}


- (void)setDidReceiveBlock:(QRCodeDidReceiveBlock)didReceiveBlock {
    _didReceiveBlock = [didReceiveBlock copy];
}

+ (BOOL)isCanShowQRCodeViewController {
    
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"不支持模拟器~~~");
    return NO;
#endif
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusDenied){
        
        DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:@"提示" message:notAllowAccessCemera cancelButtonTitle:@"取消" otherButtonTitle:@"去设置"];
        [alertView setAlertThemeMessageTip_TwoButton];
        alertView.otherButtonAction = ^{
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        };
        
        [alertView show];
        
        return NO;
    }
    return YES;
}


+ (instancetype)showQRCodeVieControllerWithCompletion:(QRCodeDidReceiveBlock)didReceiveBlock {

    if (![YNQRcodeViewController isCanShowQRCodeViewController]) return nil;
    
    YNQRcodeViewController *qrcodeVC = [[YNQRcodeViewController alloc] init];
    qrcodeVC.view.alpha = 0;
    qrcodeVC.didReceiveBlock = didReceiveBlock;
    
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [del.window.rootViewController addChildViewController:qrcodeVC];
    [del.window.rootViewController.view addSubview:qrcodeVC.view];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        qrcodeVC.view.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    return qrcodeVC;
}


@end
