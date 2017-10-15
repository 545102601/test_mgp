//
//  MGWorkApplyVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkApplyVC.h"
#import "UIButton+NYImageLocation.h"
#import "MGWorkApplyNewGroupView.h"
#import "MGWorkApplyJoinGroupView.h"
#import <YYText.h>
#import "MGCommonWebViewVC.h"
#import "MGResProjectListTeamModel.h"

@interface MGWorkApplyVC ()
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *titleBottomLine;

/// 选择
@property (nonatomic, strong) UIButton *oneButton;
@property (nonatomic, strong) UIButton *twoButton;
@property (nonatomic, strong) UIButton *threeButton;
@property (nonatomic, strong) UIButton *preSelectedButton;

/// 创建团队
@property (nonatomic, strong) MGWorkApplyNewGroupView *newsGroupView;
/// 加入团队
@property (nonatomic, strong) MGWorkApplyJoinGroupView *joinGroupView;
/// 活动规则提示
@property (nonatomic, strong) UIButton *checkButton;
@property (nonatomic, strong) YYLabel *serviceLabel;

/// 报名
@property (nonatomic, strong) UIButton *applyButton;

@end

@implementation MGWorkApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"报名";
    self.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - 初始化控件
- (void)setupSubViews {

    [self setupTopView];
    [self setupBottomView];
    [self setupCenterView];
    
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

- (void)selectButtonOnClick:(UIButton *)button {
    
    if (button.selected) return;
    if (!self.preSelectedButton) {
        _oneButton.selected = NO;
    }
    self.preSelectedButton.selected = NO;
    button.selected = YES;
    self.preSelectedButton = button;
    
    _newsGroupView.hidden = YES;
    
    _joinGroupView.hidden = YES;
    
    _applyButton.hidden = NO;
    
    switch (button.tag) {
        case 100: /// 个人
            
            break;
        case 101 : /// 创建团队
            _newsGroupView.hidden = NO;
            break;
        case 102:  /// 加入团队
        {
            _applyButton.hidden = YES;
            _joinGroupView.hidden = NO;
            if (!_joinGroupView.dataArrayM) {
                [self loadJoinTeamData];
            }
        }
            break;
    }
    

}
/// 规则打钩
- (void)checkOnClick {
    
    _checkButton.selected = !_checkButton.selected;
    
}
/// 立即报名
- (void)applyButtonOnClick {
    
    [self applyMethod];
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate


#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function
- (void)setupTopView {
    
    _titleLabel = [MGUITool labelWithText:self.dataModel.project_name textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _titleLabel.frame = CGRectMake(SW(28), 64 + SH(36), kScreenWidth - SW(56), 0);
    _titleLabel.height = [self.dataModel.project_name heightForFont:_titleLabel.font width:_titleLabel.width];
    
    _titleBottomLine = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _titleLabel.bottom + SH(54), kScreenWidth - SW(48), MGSepLineHeight)];
    _titleBottomLine.backgroundColor = MGSepColor;
    
    
    _oneButton = [TDNotHighlightButton buttonWithType:UIButtonTypeCustom];
    _oneButton.tag = 100;
    _oneButton.titleLabel.font = PFSC(30);
    [_oneButton setTitle:@"个人" forState:UIControlStateNormal];
    [_oneButton setTitleColor:MGThemeColor_Common_Black forState:UIControlStateNormal];
    [_oneButton setImage:[UIImage imageNamed:@"mine_work_unselected"] forState:UIControlStateNormal];
    [_oneButton setImage:[UIImage imageNamed:@"mine_work_select"] forState:UIControlStateSelected];
    _oneButton.selected = YES;
    _oneButton.frame = CGRectMake(SW(14), _titleBottomLine.bottom + SH(30), SW(160), SH(50));
    _oneButton.titleEdgeInsets = UIEdgeInsetsMake(0, SW(20), 0, 0);
    [_oneButton addTarget:self action:@selector(selectButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _twoButton = [TDNotHighlightButton buttonWithType:UIButtonTypeCustom];
    _twoButton.tag = 101;
    _twoButton.titleLabel.font = PFSC(30);
    [_twoButton setTitle:@"我来组团队" forState:UIControlStateNormal];
    [_twoButton setTitleColor:MGThemeColor_Common_Black forState:UIControlStateNormal];
    [_twoButton setImage:[UIImage imageNamed:@"mine_work_unselected"] forState:UIControlStateNormal];
    [_twoButton setImage:[UIImage imageNamed:@"mine_work_select"] forState:UIControlStateSelected];
    _twoButton.frame = CGRectMake(SW(200), _titleBottomLine.bottom + SH(30), SW(250), SH(50));
    _twoButton.titleEdgeInsets = UIEdgeInsetsMake(0, SW(20), 0, 0);
    [_twoButton addTarget:self action:@selector(selectButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _threeButton = [TDNotHighlightButton buttonWithType:UIButtonTypeCustom];
    _threeButton.tag = 102;
    _threeButton.titleLabel.font = PFSC(30);
    [_threeButton setTitle:@"加入已有团队" forState:UIControlStateNormal];
    [_threeButton setTitleColor:MGThemeColor_Common_Black forState:UIControlStateNormal];
    [_threeButton setImage:[UIImage imageNamed:@"mine_work_unselected"] forState:UIControlStateNormal];
    [_threeButton setImage:[UIImage imageNamed:@"mine_work_select"] forState:UIControlStateSelected];
    _threeButton.frame = CGRectMake(SW(450), _titleBottomLine.bottom + SH(30), SW(270), SH(50));
    _threeButton.titleEdgeInsets = UIEdgeInsetsMake(0, SW(20), 0, 0);
    [_threeButton addTarget:self action:@selector(selectButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view sd_addSubviews:@[_titleLabel, _titleBottomLine, _oneButton, _twoButton, _threeButton]];
    
}

- (void)setupBottomView {
    
    _applyButton = [MGUITool buttonWithBGColor:nil title:@"立即报名" titleColor:MGThemeColor_Title_Black font:MGThemeFont_30 target:self selector:@selector(applyButtonOnClick)];
    _applyButton.frame = CGRectMake(SW(75), kScreenHeight - SH(90) - SH(80), kScreenWidth - SW(150), SH(80));
    [_applyButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_applyButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    _applyButton.layer.cornerRadius = MGButtonLayerCorner;
    _applyButton.layer.masksToBounds = YES;
    
    
    _checkButton = [MGUITool buttonWithNorBgImage:nil selBgImage:nil norImage:[UIImage imageNamed:@"mine_icon_unselected"] selImage:[UIImage imageNamed:@"mine_icon_selected"] target:self selector:@selector(checkOnClick)];
    _checkButton.selected = YES;
    _checkButton.frame = CGRectMake(SW(70), 0, SW(40), SW(40));
    
    _serviceLabel = [[YYLabel alloc] init];
    _serviceLabel.frame = CGRectMake(_checkButton.right + SW(10), _applyButton.top - SH(60) - SH(40), SW(600), SH(40));
    
    _checkButton.centerY = _serviceLabel.centerY;
    
    [self setLabelAttr];
    
    [self.view sd_addSubviews:@[_applyButton, _checkButton, _serviceLabel]];
    
    
}
- (void)setupCenterView {
    
    _newsGroupView = [[MGWorkApplyNewGroupView alloc] initWithFrame:CGRectMake(0, _oneButton.bottom + SH(30), kScreenWidth, 0)];
    _newsGroupView.hidden = YES;
    [self.view addSubview:_newsGroupView];
    
    _joinGroupView = [[MGWorkApplyJoinGroupView alloc] initWithFrame:CGRectMake(0, _oneButton.bottom + SH(30), kScreenWidth, _serviceLabel.top - _oneButton.bottom - SH(30)) style:UITableViewStyleGrouped];
    _joinGroupView.hidden = YES;
    WEAK
    _joinGroupView.joinBlock = ^(MGResProjectListTeamDataModel *dataModel){
        STRONG
        [self joinTeamWithDataModel:dataModel];
    };
    
    [self.view addSubview:_joinGroupView];
}
#pragma mark - Getter and Setter
- (void)setLabelAttr {
    
    NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc] initWithString:@"我已阅读活动规则，并将遵守活动相关规定"];
    attrM.yy_color = MGThemeColor_Common_Black;
    
//    YYTextHighlight *highlight = [YYTextHighlight new];
//    [highlight setColor:colorHex(@"#000036")];
//    
//    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"贝甲记账用户协议"];
//    one.yy_font = PingFangSC(getScaleWidth(12));
//    one.yy_color = colorHex(@"#000036");
//    
//    [one yy_setTextHighlight:highlight range:one.yy_rangeOfAll];
//    [attrM appendAttributedString:one];
//#pragma mark - 服务协议Label点击
//    WEAK
//    _serviceLabel.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//        STRONG
//        MGCommonWebViewVC *vc = [MGCommonWebViewVC new];
//        vc.titleString = @"用户协议";
//        vc.urlString = [NSString stringWithFormat:@"%@/static/about/agreement.html",BaseURL];
//        PushVC(vc);
//        
//    };
    
//    NSMutableAttributedString *two = [[NSMutableAttributedString alloc] initWithString:@" 》"];
//    two.yy_color = TDThemeColor_Shen_Gray;
//    [attrM appendAttributedString:two];
    
    attrM.yy_font = PingFangSC(getScaleWidth(28));;
    attrM.yy_alignment = NSTextAlignmentLeft;
    
    _serviceLabel.attributedText = attrM;
    
}

/// 加载团队列表信息
- (void)loadJoinTeamData {
    
    [MGBussiness loadProject_Teams:@{@"id" : @(self.dataModel.id)} completion:^(NSArray *results) {
        self.joinGroupView.dataArrayM = results.mutableCopy;
        [self.joinGroupView reloadData];
    } error:nil];
}

/// 报名
- (void)applyMethod {
    
    if (!_checkButton.isSelected) {
        [self showMBText:@"请阅读活动规则"];
        return;
    }
    
    if (self.oneButton.isSelected) {
        /// 个人
        [self applyForPerson];
    }
    
    if (self.twoButton.isSelected) {
     
        if(![_newsGroupView checkCondition]) {
            return;
        };
        /// 组团
        [self applyForNewTeam];
    }
    
}
/// 个人报名
- (void)applyForPerson {
    
    [MGBussiness loadProject_Join:@{@"id" : @(self.dataModel.id), @"type" : @(1)} completion:^(id results) {
        if ([results boolValue]) {
            [self showMBText:@"报名成功"];
            
            if (self.applyCompletion) {
                self.applyCompletion();
            }
            
        }
    } error:nil];
}
/// 组团
- (void)applyForNewTeam {
    [self.view endEditing:YES];
    [MGBussiness loadProject_Join:@{@"id" : @(self.dataModel.id), @"type" : @(3), @"team_name" : _newsGroupView.teamName, @"cipher" : _newsGroupView.ciperName, @"bulletin" : _newsGroupView.bluttingName, @"role" : _newsGroupView.roleName} completion:^(id results) {
        if ([results boolValue]) {
            [self showMBText:@"报名成功"];
            
            if (self.applyCompletion) {
                self.applyCompletion();
            }
        }
    } error:nil];
    
}
/// 加入团队
- (void)joinTeamWithDataModel:(MGResProjectListTeamDataModel *)dataModel {
    
    WEAK
    DQAlertView *alert = [[DQAlertView alloc] initWithTitle:@"" message:@"" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    [alert setAlertThemeMessageTip_TwoButton];
    [alert setAlertThemeWithTextFieldForApplyWork];
    __weak typeof(DQAlertView *)weakAlert = alert;
    alert.otherButtonAction = ^{
        STRONG
        UITextField *filed = [weakAlert.contentView viewWithTag:100001];
        
        if (filed.text.length == 0) {
            [self showMBText:@"请输入集结暗号"];
            return;
        }

        [self.view endEditing:YES];
        
        [weakAlert dismiss];
        
        [MGBussiness loadProject_Join:@{@"id" : @(self.dataModel.id), @"type" : @(2), @"team_id" : @(dataModel.id), @"cipher" : filed.text} completion:^(id results) {
            if ([results boolValue]) {
                [self showMBText:@"报名成功"];
                if (self.applyCompletion) {
                    self.applyCompletion();
                }
            }
        } error:nil];
        
    };
    [alert showInView:self.view];
    
    
    
    
}

@end
