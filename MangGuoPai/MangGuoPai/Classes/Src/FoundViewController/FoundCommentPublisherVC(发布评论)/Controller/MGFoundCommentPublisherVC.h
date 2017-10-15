//
//  MGFoundCommentPublisherVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/10/3.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, CommentPublisherType){
    CommentPublisherTypeFound = 0,   /// 回复动态
    CommentPublisherTypeComment = 1, /// 回复评论
};

@interface MGFoundCommentPublisherVC : BaseViewController
/// 动态id
@property (nonatomic, assign) long trend_id;
/// 评论id
@property (nonatomic, assign) long comment_id;

@property (nonatomic, assign) CommentPublisherType publisherType;

/// 发布成功回调
@property (nonatomic, copy) MGCommomEventBlock publishCompletionBlock;

@end
