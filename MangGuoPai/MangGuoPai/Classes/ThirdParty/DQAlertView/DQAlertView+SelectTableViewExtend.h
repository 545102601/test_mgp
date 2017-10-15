//
//  DQAlertView+SelectTableViewExtend.h
//  MangGuoPai
//
//  Created by ZYN on 2017/9/4.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "DQAlertView.h"

@interface DQAlertSelectedModel : BaseModel
/// 附加
@property (nonatomic, assign) long id;
/// 附加
@property (nonatomic, assign) CGFloat price;
/// 附加
@property (nonatomic, assign) long parentId;

@property (nonatomic, copy) NSArray *subArray;


@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL isSelected;

@end

@interface DQAlertView (SelectTableViewExtend)

- (NSMutableArray *)setThemeTableViewToSelectedItemWithTitle:(NSString *)title
                                                   dataArray:(NSArray *)array;


- (void)scrollToSelectedItem;


@end
