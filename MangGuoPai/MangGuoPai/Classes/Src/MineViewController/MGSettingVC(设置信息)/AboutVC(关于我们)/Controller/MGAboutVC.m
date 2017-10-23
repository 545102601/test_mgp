//
//  MGAboutVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/19.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGAboutVC.h"

@interface MGAboutVC ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UILabel *introLabel;

@property (nonatomic, strong) UILabel *bottomLabel;

@end

@implementation MGAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于我们";
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupSubViews {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - SH(90))];
    
    _scrollView.backgroundColor = [UIColor clearColor];
    
    _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(208))];
    _logoImageView.image = [UIImage imageNamed:@"mine_about_banner"];
    _logoImageView.centerX = self.view.centerX;
    
    _introLabel = [MGUITool labelWithText:@"       芒果派是广州互原电子商务公司旗下百分百控股项目。作为一个新型大学生服务平台，芒果派结合助力企业，发起多类传统行业与互联网相结合的专案项目。\r\n       大学生自发组队，可同时通过芒果派平台上职场实操导师团的技能及经验指导，按企业运营标准来开展项目，完成项目工作包。\r\n       在电商平台建设运营、人力资源及市场推广方面，团队骨干成员均具有10年以上工作经验。在创新项目包模式运营实操方面，团队亦屡创佳绩！项目投资诸如广交会电商大学生实践项目，卡奔跨境购物平台微店长项目等，均由芒果团队与行业大咖联合出品。\r\n        而在校企合作方面，芒果派团队亦是行业翘楚。坐拥广东、湖南、江苏、青岛、广西五省的百所高校资源并动态更新，依仗昔日校企合作丰富的项目案例和实践阅历，团队带着芒果派在放飞自我的路上越走越远~" textColor:MGThemeColor_Common_Black font:PFSC(30)];
    
    _introLabel.frame = CGRectMake(SW(46), _logoImageView.bottom + SH(16), kScreenWidth - SW(92), 0);
    _introLabel.height = [_introLabel.text heightForFont:_introLabel.font width:_introLabel.width];
    
    _scrollView.contentSize = CGSizeMake(kScreenWidth, _introLabel.bottom + SH(50));
    
    
    [_scrollView sd_addSubviews:@[_logoImageView, _introLabel]];

    
    _bottomLabel = [MGUITool labelWithText:nil textColor:nil font:nil];
    _bottomLabel.frame = CGRectMake(0, kScreenHeight - SH(90) - SH(70), kScreenWidth, SH(90));
    _bottomLabel.centerX = self.view.centerX;
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:SH(14)];
    
    
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:@"copyright © 2017-2018 \r\n 广州市互原电子商务有限公司" attributes:@{
                                                                                                                                   NSFontAttributeName : PFSC(28), NSForegroundColorAttributeName : [UIColor hexColorWithString:@"#cccccc"], NSParagraphStyleAttributeName : paragraphStyle}];
    _bottomLabel.attributedText = attr;
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [self.view sd_addSubviews:@[_scrollView, _bottomLabel]];
    
}

@end
