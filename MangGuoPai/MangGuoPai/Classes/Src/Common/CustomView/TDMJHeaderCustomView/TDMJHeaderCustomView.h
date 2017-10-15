//
//  TDMJHeaderCustomView.h
//  TDBeijiaBill
//
//  Created by ZYN on 2017/6/4.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface TDMJHeaderCustomView : MJRefreshHeader
@property (weak, nonatomic, readonly) UIImageView *arrowView;
/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
@end
