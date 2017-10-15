//
//  MGWorkLookOtherVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/15.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkLookOtherVC.h"
#import "MGOrderDetailFileView.h"

@interface MGWorkLookOtherVC ()

@property (nonatomic, strong) MGOrderDetailFileView *fileView;

@end

@implementation MGWorkLookOtherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@的方案文档", self.actorModel.actor_name];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 初始化控件
- (void)setupSubViews {

    _fileView = [[MGOrderDetailFileView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 0)];
    _fileView.tipTitleText = @"方案文档 : ";
    _fileView.dataArrayM = self.actorModel.scheme_doc_rsurls.mutableCopy;
    
    [self.view addSubview:_fileView];
    
    if (self.actorModel.scheme_doc_rsurls.count == 0) {
        MGCommonEmptyView *emtpyView = [[MGCommonEmptyView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
        emtpyView.iconImageView.image = [UIImage imageNamed:@"empty_page_icon_07"];
        emtpyView.contentLabel.text = @"暂无方案文档";
        
        [self.view addSubview:emtpyView];
    }
    
    
}

#pragma mark - 加载数据
- (void)loadData {
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

@end
