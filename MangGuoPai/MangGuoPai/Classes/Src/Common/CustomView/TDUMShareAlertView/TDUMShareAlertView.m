//
//  TDUMShareAlertView.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/26.
//  Copyright © 2017年 梦创. All rights reserved.
//

#import "TDUMShareAlertView.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "TDUMengShowItem.h"
#import "PPShareManager.h"

@interface TDUMShareAlertView ()

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, copy) NSString *url;


/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
//背景
@property (nonatomic, weak) UIButton *backgroundButton;
//内容view
@property (nonatomic, weak) UIView *containerView;
//取消
@property (nonatomic, weak) UIButton *cancelButton;

@property (nonatomic, assign) BOOL animation;

@property (nonatomic, weak) UIViewController *vc;

@property (nonatomic, copy) ShareCompleteBlock compeleteBlock;

@property (nonatomic, copy) ShareFailBlock failBlock;

@property (nonatomic, copy) ShareCompleteBlock shareBlock;

@end


@implementation TDUMShareAlertView


#pragma mark - Public Method

+ (instancetype)showUMengShareViewWithTitle:(NSString *)title shareContent:(NSString *)content shareImage:(UIImage *)image imageUrl:(NSString *)imageUrl shareUrl:(NSString *)url vc:(id)vc{
    
    return [[TDUMShareAlertView alloc] initUMengShareViewWithTitle:title shareContent:content shareImage:image imageUrl:imageUrl shareUrl:url vc:vc] ;
    
}

+ (instancetype)showUMengShareViewWithTitle:(NSString *)title shareContent:(NSString *)content shareImage:(UIImage *)image imageUrl:(NSString *)imageUrl shareUrl:(NSString *)url {
    return [[TDUMShareAlertView alloc] initUMengShareViewWithTitle:title shareContent:content shareImage:image imageUrl:imageUrl shareUrl:url vc:nil];
}

+ (instancetype)showUMengShareViewWithTitle:(NSString *)title shareContent:(NSString *)content shareImage:(UIImage *)image imageUrl:(NSString *)imageUrl shareUrl:(NSString *)url  clickShare:(ShareCompleteBlock)share complete:(ShareCompleteBlock)complete fail:(ShareFailBlock)fail {
    return [[TDUMShareAlertView alloc] initUMengShareViewWithTitle:title shareContent:content shareImage:image imageUrl:imageUrl shareUrl:url vc:nil clickShare:share complete:complete fail:fail];
}

- (void)show{
    
    [self showWithAnimation:YES];
    
}

- (void)dismiss{
    
    [self dismissWithAnimation:YES];
    
}

- (void)showWithAnimation:(BOOL)animation{
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    [window addSubview:self];
    
    if (animation) {
        self.animation = animation;
        [self startAnimation];
    }
}

- (void)dismissWithAnimation:(BOOL)animation{
    
    if (animation) {
        [self endAnimation];
    }else{
        [self removeFromSuperview];
    }
    
}


#pragma Mark - Private Method

//动画
- (void)startAnimation{
    
    //初始值
    self.backgroundButton.alpha = 0;
    self.containerView.alpha = 0;
    self.containerView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, self.containerView.frame.size.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundButton.alpha = 0.3;
        self.containerView.alpha = 1;
        self.containerView.transform = CGAffineTransformMakeTranslation(0,  -self.containerView.frame.size.height );//需要-取消按钮的高度
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}

- (void)endAnimation{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backgroundButton.alpha = 0;
        
        self.containerView.transform = CGAffineTransformIdentity;
        self.containerView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (instancetype)initUMengShareViewWithTitle:(NSString *)title shareContent:(NSString *)content shareImage:(UIImage *)image imageUrl:(NSString *)imageUrl shareUrl:(NSString *)url vc:(id)vc{
    
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _title = title;
        _content = content;
        _image = image;
        _imageUrl = imageUrl;
        _url = url;
        _vc = vc;
        [self configUI];
    }
    return self;
}
- (instancetype)initUMengShareViewWithTitle:(NSString *)title shareContent:(NSString *)content shareImage:(UIImage *)image imageUrl:(NSString *)imageUrl shareUrl:(NSString *)url vc:(id)vc clickShare:(ShareCompleteBlock)shareBlock
                                   complete:(ShareCompleteBlock)completeBlock fail:(ShareFailBlock)failBlcok {
    
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _title = title;
        _content = content;
        _image = image;
        _imageUrl = imageUrl;
        _url = url;
        _vc = vc;
        if (shareBlock) {
            _shareBlock = shareBlock;
        }
        if (completeBlock) {
            _compeleteBlock = completeBlock;
        }
        if (failBlcok) {
            _failBlock = failBlcok;
        }
        [self configUI];
    }
    return self;
}

- (void)configUI{
    
    //创建背景
    UIButton *backgroundButton = [[UIButton alloc]initWithFrame:self.bounds];
    backgroundButton.backgroundColor = [UIColor blackColor];
    backgroundButton.alpha = 0.5;
    [backgroundButton addTarget:self action:@selector(backgroundButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backgroundButton];
    self.backgroundButton = backgroundButton;
    //创建容器
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self addSubview:containerView];
    self.containerView = containerView;
    
    
//    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(100))];
//    _titleLabel.text = @"分享给朋友";
//    _titleLabel.textColor = MGThemeColor_Common_Black;
//    _titleLabel.textAlignment = NSTextAlignmentCenter;
//    
//    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _titleLabel.bottom, kScreenWidth, MGSepLineHeight)];
//    _lineView.backgroundColor = MGSepColor;
    
    self.containerView.backgroundColor = [UIColor whiteColor];
//    [self.containerView addSubview:_titleLabel];
    
//    [self.containerView addSubview:_lineView];
    //图片
    NSMutableArray *imageArray = [[NSMutableArray alloc]initWithCapacity:5];
    NSMutableArray *titleArray = [[NSMutableArray alloc]initWithCapacity:5];
    NSMutableArray *tagArray =   [[NSMutableArray alloc]initWithCapacity:5];
    int count = 4;
    
    if (![WXApi isWXAppInstalled]) {
        count -= 2;
        
    }else{
        [imageArray addObject:@"share_wechat"];
        [titleArray addObject:@"微信好友"];
        [tagArray addObject:@"100861"];
        
        [imageArray addObject:@"share_F_wechat"];
        [titleArray addObject:@"朋友圈"];
        [tagArray addObject:@"100862"];
    }
    
    
    [imageArray addObject:@"share_QQ"];
    [titleArray addObject:@"QQ好友"];
    [tagArray addObject:@"100863"];
    
    [imageArray addObject:@"share_kzone_icon"];
    [titleArray addObject:@"QQ空间"];
    [tagArray addObject:@"100864"];
    
    
//    [imageArray addObject:@"share_weibo_icon"];
//    [titleArray addObject:@"微博"];
//    [tagArray addObject:@"100865"];
//   
//    
//    [imageArray addObject:@"share_msn_icon"];
//    [titleArray addObject:@"短信"];
//    [tagArray addObject:@"100866"];
//    
//    
//    [imageArray addObject:@"share_link_icon"];
//    [titleArray addObject:@"链接"];
//    [tagArray addObject:@"100867"];
    
    
    
    //创建分享按钮
    int maxCols = 5;
    
    NSUInteger tempCount = count > 5 ? 5 : count;
    
    CGFloat UMShareContentWidht;
    CGFloat UMShareContentHeight;
    
    UMShareContentHeight = UMShareContentWidht = SW(120);
    
    CGFloat margin = (kScreenWidth -  tempCount* UMShareContentWidht)/(tempCount + 1);
    
    CGFloat maxHeight = 0;
    
    for (int i = 0; i < count; i++) {
        TDUMengShowItem *item = [[TDUMengShowItem alloc]init];
        item.tag = [tagArray[i] integerValue];
        
        //设置资源
        [item setItemTtile:titleArray[i]];
        [item setItemImage:[UIImage imageNamed:imageArray[i]]];
        
        CGFloat x = margin + (i%maxCols)*( UMShareContentWidht + margin);
        
        CGFloat y = SH(10) + (i/maxCols)*( UMShareContentHeight + margin);
        
        /// 留间距
        y += _lineView.bottom;
        
        if (i > 4) {
            y += SH(20);
        }
        
        item.frame = CGRectMake(x, y, UMShareContentWidht, UMShareContentHeight);
        
        __weak TDUMShareAlertView* weakSelf = self;
        
        item.itemTapBlock = ^(TDUMengShowItem *item){
            
            [weakSelf shareWithIndex:item.tag];
            
        };
        
        [containerView addSubview:item];
        
        if (i == count - 1) {
            maxHeight = CGRectGetMaxY(item.frame) + SH(60);
        }
    }
    
    containerView.frame = CGRectMake(0, kScreenHeight - maxHeight, kScreenWidth, maxHeight + SH(106));
    
    
    //创建线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, MGSepLineHeight)];
    lineView.backgroundColor = MGSepColor;
    
    
    
    //创建取消按钮
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, maxHeight , kScreenWidth, SH(106))];
    
    cancelButton.titleLabel.font = PFSC(32);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:MGThemeColor_Common_Black forState:UIControlStateNormal];
    [cancelButton setBackgroundColor:[UIColor whiteColor]];
    [cancelButton addTarget:self action:@selector(cancelButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [cancelButton addSubview:lineView];
    [containerView addSubview:cancelButton];
    self.cancelButton = cancelButton;
    
    
}

#pragma mark - Actions
//分享方法  需要一一对应
- (void)shareWithIndex:(NSUInteger)index{
    if (index <= 100862) {//判断是否安装微信
        if (![PPShareManager isWXAppInstalled]) {
            [self showMBText:@"请先安装微信"];
            return;
        }
    }
    else if (index <= 100864) {//判断是否安装qq
        if (![PPShareManager isQQInstalled]) {
            [self showMBText:@"请先安装qq"];
            return;
        }
    }
    else if (index <= 100865) {//判断是否安装微博
        if (![PPShareManager isWeiboInstalled]) {
            [self showMBText:@"请先安装微博"];
            return;
        }
    }

    switch (index) {
        case 100861://微信好友
            [self shareWithType:UMSocialPlatformType_WechatSession];
            break;
            
        case 100862://微信朋友圈
            [self shareWithType:UMSocialPlatformType_WechatTimeLine];
            break;
        case 100863://QQ好友
            [self shareWithType:UMSocialPlatformType_QQ];
            break;
        case 100864://QQ空间
            [self shareWithType:UMSocialPlatformType_Qzone];
            break;
        case 100865://新浪微博
            [self shareWithType:UMSocialPlatformType_Sina];
            break;
        case 100866://短信
        {
            [self shareWithType:UMSocialPlatformType_Sms];
        }
            break;
        case 100867://复制
        {
            //
            if (_shareBlock) {//回调点击类型，因为获取积分类型特殊处理
                _shareBlock(@(100867));
            }
            //
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = _url;
            [self dismissWithAnimation:YES];
            [self showMBText:@"已复制链接到粘贴板"];
            
        }
            break;
            
    }
}

//分享
- (void)shareWithType:(UMSocialPlatformType)type{
    
    
    id image = nil;
    if (_image) {
        image = _image;
    } else {
        image = _imageUrl;
    }
    
    if (type == UMSocialPlatformType_Sms) {//短信
        if (_shareBlock) {//回调点击类型，因为获取积分类型特殊处理
            _shareBlock(@(100866));
        }
    }else{
        if (_shareBlock) {//回调点击类型，因为获取积分类型特殊处理
            _shareBlock(@(1));
        }
    }
    

    
    if (UMSocialPlatformType_Sina == type) {//微博分享特殊处理
        NSString *tempContent = _content;
        if (_url && ![_url isEqualToString:@""]) {
            tempContent = [_content stringByAppendingFormat:@"  %@",_url];
        }
        [[PPShareManager shareInstance] shareTitle:_title shareContent:_content shareImage:image shareUrl:_url platformType:type onCompletion:^(id statusInfo) {
            if (_compeleteBlock) {
                _compeleteBlock(nil);
            }
        } onError:^(id error) {
            if (_failBlock) {
                _failBlock(error);
            }

        }];
        
    }else{

        [[PPShareManager shareInstance] shareTitle:_title shareContent:_content shareImage:image shareUrl:_url platformType:type onCompletion:^(id statusInfo) {
            if (_compeleteBlock) {
                _compeleteBlock(nil);
            }
        } onError:^(id error) {
            if(type == UMSocialPlatformType_Sms){//回调点击类型，因为获取积分类型特殊处理
                if (_failBlock) {
                    _failBlock(@(100866));
                }

            }
            else{
                if (_failBlock) {
                    _failBlock(error);
                }
            }
        }];
        
    }
    
    [self dismissWithAnimation:NO];
    
    
}


- (void)backgroundButtonOnClick{
    
    [self cancelButtonOnClick];
    
}

- (void)cancelButtonOnClick{
    
    if (self.animation) {
        [self dismiss];
    }else{
        [self dismissWithAnimation:NO];
    }
    
}



@end
