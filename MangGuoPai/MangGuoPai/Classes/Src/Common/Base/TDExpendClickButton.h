//
//  TDExpendClickButton.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/6/3.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDExpendClickButton : UIButton

@end

@interface TDExpendClickButtonNotHightLight : UIButton

@end

@interface TDNotHighlightButton : UIButton

+ (TDNotHighlightButton *)buttonWithFrame:(CGRect)rect
                                imageName:(NSString *)name
                                   target:(id)target
                                 selector:(SEL)selector;

@end
