//
//  MGWorkProductionVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/14.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkProductionVC.h"
#import "MGWorkProductionView.h"
#import <YYText.h>
#import "MGResProjectActorModel.h"

@interface MGWorkProductionVC ()

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *titleLineView;

/// 作品照片
@property (nonatomic, strong) MGWorkProductionView *productionPhotoView;
/// 团队照片
@property (nonatomic, strong) MGWorkProductionView *teamPhotoView;
/// 文件
@property (nonatomic, strong) MGWorkProductionView *filesView;
/// 底部提示
@property (nonatomic, strong) UILabel *bottomTipLabel;

@end

@implementation MGWorkProductionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"作品";
    [self setNavigationBarGrayAndBlackBackButton];
}

#pragma mark - 初始化控件
- (void)setupSubViews {

    
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    _contentScrollView.backgroundColor = [UIColor whiteColor];
    _contentScrollView.showsVerticalScrollIndicator = NO;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    
    
    _titleLabel = [MGUITool labelWithText:self.dataModel.project_name textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _titleLabel.frame = CGRectMake(SW(30), SH(30), kScreenWidth - SW(60), 0);
    _titleLabel.height = [_titleLabel.text heightForFont:_titleLabel.font width:_titleLabel.width];
    _titleLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _titleLabel.bottom + SH(30), kScreenWidth - SW(48), MGSepLineHeight)];
    _titleLineView.backgroundColor = MGSepColor;
    
    _productionPhotoView = [[MGWorkProductionView alloc] initWithFrame:CGRectMake(0, _titleLineView.bottom, kScreenWidth, 0)];
    _productionPhotoView.type = 0;
    
    _filesView = [[MGWorkProductionView alloc] initWithFrame:CGRectMake(0, _productionPhotoView.bottom, kScreenWidth, 0)];
    _filesView.type = 1;
    
    _teamPhotoView = [[MGWorkProductionView alloc] initWithFrame:CGRectMake(0, _filesView.bottom, kScreenWidth, 0)];
    _teamPhotoView.type = 2;
    
    _bottomTipLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28) textAlignment:NSTextAlignmentCenter];
    _bottomTipLabel.frame = CGRectMake(SW(30), _teamPhotoView.bottom + SH(30), kScreenWidth - SW(60), _bottomTipLabel.fontLineHeight * 2 + SH(20));
    NSString *bottomTipText = @"您可以在PC端登录www.enjoymangopi.com , 使用\r\n电脑上传照片、Word、PPT等文件";
    NSMutableAttributedString *ATTRS = [bottomTipText addLineSpaceWithfont:PFSC(28) lineSpace:SH(20) color:MGThemeColor_Common_Black];
    [ATTRS setYy_alignment:NSTextAlignmentCenter];
    _bottomTipLabel.attributedText = ATTRS;
    
    
    _contentScrollView.contentSize = CGSizeMake(kScreenWidth, _bottomTipLabel.bottom + SH(30));
    
    [_contentScrollView sd_addSubviews:@[_titleLabel,
                                         _titleLineView,
                                         _productionPhotoView,
                                         _teamPhotoView,
                                         _filesView,
                                         _bottomTipLabel]];
    
    [self.view addSubview:_contentScrollView];
    
}

#pragma mark - 加载数据
- (void)loadData {
    
    [TDLoading showViewInKeyWindow];
    
    _contentScrollView.hidden = YES;
    
    [MGBussiness loadProject_Actor_Get:@{@"id" : @(self.dataModel.actor_id)} completion:^(MGResProjectActorDataModel *dataModel) {
        _contentScrollView.hidden = NO;
        
        _titleLabel.text = dataModel.project_name;
        
        _productionPhotoView.dataArrayM = dataModel.works_phote_rsurls.mutableCopy;
        _filesView.dataArrayM = dataModel.scheme_doc_rsurls.mutableCopy;
        _teamPhotoView.dataArrayM = dataModel.team_photo_rsurls.mutableCopy;

        [TDLoading hideViewInKeyWindow];
       
    } error:nil];
    
}

@end

