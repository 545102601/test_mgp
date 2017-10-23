//
//  MGScheduleCalendarCell.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/28.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "FSCalendarCell.h"
#import "MGResScheduleCalendarModel.h"

@interface MGScheduleCalendarCell : FSCalendarCell

@property (weak, nonatomic) CAShapeLayer *selectionLayer;

@property (nonatomic, strong) UIImageView *keImageView;

@end
