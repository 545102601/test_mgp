//
//  MGLevelUpgradeVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/21.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGLevelUpgradeVC.h"
#import "MGLevelUpgradeTableModel.h"
#import "MGLevelUpgradeTableView.h"
#import "MGUpgradeCompanyVC.h"
#import "MGUpgradeStudentVC.h"
#import "MGUpgradeTutorVC.h"
#import "MGUpgradeCommunityVC.h"



@interface MGLevelUpgradeVC ()

@property (nonatomic, strong) NSMutableArray *dataArrayM;

@property (nonatomic, strong) MGLevelUpgradeTableView *tableView;

@end

@implementation MGLevelUpgradeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"身份升级";
    
}

- (void)initData {
    
    
    MGLevelUpgradeTableModel *tableModel1 = [MGLevelUpgradeTableModel new];
    tableModel1.type = UpgradeTypeStudent;
    tableModel1.levelImageNor = @"mine_level_student_nor";
    tableModel1.levelImageSel = @"mine_level_student_sel";
    tableModel1.titleName = @"验证学生身份";
    tableModel1.contentName = @"验证您的学生身份，可以参加芒果树举办的各种校园活动，包括知名企业市场推广兼职活动等。您只需提供学校、专业和学生证照片即可通过验证。";
//    tableModel1.isSelected = YES;
    
    
    MGLevelUpgradeTableModel *tableModel2 = [MGLevelUpgradeTableModel new];
    tableModel2.type = UpgradeTypeTutor;
    tableModel2.levelImageNor = @"mine_level_teach_nor";
    tableModel2.levelImageSel = @"mine_level_teach_sel";
    tableModel2.titleName = @"升级为导师";
    tableModel2.contentName = @"只要您有在知名企业任职、或者拥有一技之长，并且乐于助人，就来加入我们的导师行列吧。在这里您将发现自身的价值、打造个人的品牌，并增值您的财富。";
//    tableModel2.isSelected = YES;
    
    MGLevelUpgradeTableModel *tableModel3 = [MGLevelUpgradeTableModel new];
    tableModel3.type = UpgradeTypeCompany;
    tableModel3.levelImageNor = @"mine_level_qy_nor";
    tableModel3.levelImageSel = @"mine_level_qy_sel";
    tableModel3.titleName = @"注册为企业";
    tableModel3.contentName = @"注册为企业后，您可以发布企业的市场推广项目，比如一场校园营销或者一个品牌的设计，从而实现与芒果树的成员进行互动。";
//    tableModel3.isSelected = YES;
    
    
    MGLevelUpgradeTableModel *tableModel4 = [MGLevelUpgradeTableModel new];
    tableModel4.type = UpgradeTypeCommunity;
    tableModel4.levelImageNor = @"mine_level_st_nor";
    tableModel4.levelImageSel = @"mine_level_st_sel";
    tableModel4.titleName = @"注册为社团";
    tableModel4.contentName = @"芒果树社团组织为校内外的社团组织，可以是全国范围的兴趣爱好聚集地，也可以是同城的社群，注册社团后，您可以通过芒果树发布动态、组织活动。";
//    tableModel4.isSelected = YES;
    
    _dataArrayM = @[tableModel1, tableModel2, tableModel3, tableModel4].mutableCopy;
    
    
}

#pragma mark - 初始化控件
- (void)setupSubViews {
    
    _tableView = [[MGLevelUpgradeTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.dataArrayM = self.dataArrayM;
    
    WEAK
    _tableView.didSelectedRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
        STRONG
        
        MGLevelUpgradeTableModel *model = self.tableView.dataArrayM[indexPath.section];
        
        [MGBussiness loadCouldUpgradeWithType:model.type completion:^(id results) {
            switch (model.type) {
                case UpgradeTypeStudent: /// 学生
                {
                    
                    MGUpgradeStudentVC *vc = [MGUpgradeStudentVC new];
                    PushVC(vc)
                }
                    break;
                case UpgradeTypeTutor: /// 导师
                {
                    MGUpgradeTutorVC *vc = [MGUpgradeTutorVC new];
                    PushVC(vc)
                }
                    break;
                case UpgradeTypeCompany: /// 公司
                {
                    MGUpgradeCompanyVC *vc = [MGUpgradeCompanyVC new];
                    PushVC(vc)
                }
                    break;
                case UpgradeTypeCommunity: /// 社团
                {
                    MGUpgradeCommunityVC *vc = [MGUpgradeCommunityVC new];
                    PushVC(vc)
                }
                    break;
            }
        } error:nil];
        
        
        
    };
    
    
    [self.view addSubview:_tableView];
    
}

#pragma mark - 加载数据
- (void)loadData {

}

@end
