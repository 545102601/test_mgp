//
//  MGHomeCouponView.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/12.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseView.h"
#import "MGResSettingModel.h"

@interface MGHomeCouponView : BaseView

@property (nonatomic, strong) MGResSettingDataDetailModel *detaiModel;

@property (nonatomic, copy) MGCommomEventBlock iconImageViewBlock;

- (void)showCouponViewWithAnimated:(BOOL)animated inView:(UIView *)inView;

- (void)dismissCouponViewWithAnimated:(BOOL)animated;

@end
