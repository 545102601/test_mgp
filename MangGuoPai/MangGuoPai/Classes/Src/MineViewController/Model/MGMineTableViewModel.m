//
//  MGMineTableViewModel.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/16.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGMineTableViewModel.h"
#import "MGResMemberModel.h"

@implementation MGMineTableViewModel

+ (NSArray *)getTableViewModelWithModel:(MGResMemberDataModel *)model {
    
    
    NSMutableArray *dataArrayM = @[].mutableCopy;
    NSMutableArray *one_dataArrayM = @[].mutableCopy;
    NSMutableArray *two_dataArrayM = @[].mutableCopy;
    
    NSArray *array = model.user_identitys;
    
    NSString *identityStr = model.user_identity_label ?: @"自由人";
    
    MGMineTableViewModel *viewModel_row_1 = [MGMineTableViewModel modelWithTitle:[NSString stringWithFormat:@"身份:%@",identityStr] icon:@"mine_icon_id" subTitle:@"点击查看"];
    viewModel_row_1.type = TableViewModelTypeID;
    
    NSString *order_count = model.order_count > 0 ? [NSString stringWithFormat:@"%zd",model.order_count] : @"";
    
    MGMineTableViewModel *viewModel_row_2 = [MGMineTableViewModel modelWithTitle:@"我的订单" icon:@"mine_icon_dingdan" subTitle:order_count];
    viewModel_row_2.type = TableViewModelTypeOrder;
    
    [one_dataArrayM addObject:viewModel_row_1];
    [one_dataArrayM addObject:viewModel_row_2];
    
    if ((array.count == 1 && [array containsObject:@"self"]) || (array.count == 1 && [array containsObject:@"community"])) { /// 自由人 - 社团没有这个
    } else {
        NSString *project_count = model.project_count > 0 ? [NSString stringWithFormat:@"%zd",model.project_count] : @"";
        MGMineTableViewModel *viewModel_row_3 = [MGMineTableViewModel modelWithTitle:@"我的工作包" icon:@"mine_icon_gongzuobao" subTitle:project_count];
        viewModel_row_3.type = TableViewModelTypeWork;
        [one_dataArrayM addObject:viewModel_row_3];
    }
    
    
    if ([array containsObject:@"tutor"]) { /// 有导师就有这个
        NSString *course_count = model.course_count > 0 ? [NSString stringWithFormat:@"%zd",model.course_count] : @"";
        MGMineTableViewModel *viewModel_row_4 = [MGMineTableViewModel modelWithTitle:@"我的授课" icon:@"mine_icon_shouke" subTitle:course_count];
        viewModel_row_4.type = TableViewModelTypeClass;

        [one_dataArrayM addObject:viewModel_row_4];

        MGMineTableViewModel *viewModel_row_4_1 = [MGMineTableViewModel modelWithTitle:@"我的授课安排" icon:@"mine_icon_shouke" subTitle:nil];
        viewModel_row_4_1.type = TableViewModelTypeClassSchedule;
        [one_dataArrayM addObject:viewModel_row_4_1];
        
        
//        MGMineTableViewModel *viewModel_row_5 = [MGMineTableViewModel modelWithTitle:@"我的账户" icon:@"mine_icon_zhanghu" subTitle:[NSString stringWithFormat:@"%0.2f",0.00]];
//        viewModel_row_5.type = TableViewModelTypeAccount;
//        [one_dataArrayM addObject:viewModel_row_5];
//        
    }
    
    
    
    
    MGMineTableViewModel *viewModel_row_6 = [MGMineTableViewModel modelWithTitle:@"我的优惠卷" icon:@"mine_icon_coupon" subTitle:nil];
    viewModel_row_6.type = TableViewModelTypeCoupon;
    
    [one_dataArrayM addObject:viewModel_row_6];
    
    
    
    
    MGMineTableViewModel *viewModel = [MGMineTableViewModel new];
    viewModel.title = @"设置";
    viewModel.icon = @"mine_icon_shezhi";
    viewModel.type = TableViewModelTypeSetting;
    [two_dataArrayM addObject:viewModel];
    
    [dataArrayM addObject:one_dataArrayM];
    [dataArrayM addObject:two_dataArrayM];
    return dataArrayM;
}


+ (instancetype)modelWithTitle:(NSString *)title
                          icon:(NSString *)icon
                      subTitle:(NSString *)subTitle {
    MGMineTableViewModel *viewModel = [MGMineTableViewModel new];
    viewModel.title = title;
    viewModel.icon = icon;
    viewModel.subTtile = subTitle;
    return viewModel;
}

@end
