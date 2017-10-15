//
//  MGLevelUpgradeTableModel.h
//  MangGuoPai
//
//  Created by ZYN on 2017/8/21.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(NSInteger, UpgradeType) {
    UpgradeTypeStudent = 0,
    UpgradeTypeTutor = 1,
    UpgradeTypeCompany = 2,
    UpgradeTypeCommunity = 3,
};

@interface MGLevelUpgradeTableModel : BaseModel


@property (nonatomic, assign) UpgradeType type;

@property (nonatomic, copy) NSString *levelImageNor;

@property (nonatomic, copy) NSString *levelImageSel;

@property (nonatomic, copy) NSString *titleName;

@property (nonatomic, copy) NSString *contentName;

@property (nonatomic, assign) BOOL isSelected;

@end
