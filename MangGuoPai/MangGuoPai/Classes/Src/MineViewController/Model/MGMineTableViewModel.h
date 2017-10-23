//
//  MGMineTableViewModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/7/16.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseLogModel.h"
#import "MGResMemberModel.h"

typedef NS_ENUM(NSInteger, TableViewModelType) {
    TableViewModelTypeID = 0,
    TableViewModelTypeOrder = 1,
    TableViewModelTypeWork = 2,
    TableViewModelTypeClass = 3,
    TableViewModelTypeAccount = 4,
    TableViewModelTypeSetting = 5,
    TableViewModelTypeCoupon = 6,
    TableViewModelTypeClassSchedule = 7,
};

@interface MGMineTableViewModel : BaseLogModel
///
@property (nonatomic, assign) TableViewModelType type;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTtile;


+ (NSArray *)getTableViewModelWithModel:(MGResMemberDataModel *)model;

+ (instancetype)modelWithTitle:(NSString *)title
                          icon:(NSString *)icon
                      subTitle:(NSString *)subTitle;


@end
