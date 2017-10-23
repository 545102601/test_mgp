//
//  MGLoginVC.h
//  MangGuoPai
//
//  Created by ZYN on 2017/6/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MGLoginModel.h"

@interface MGLoginVC : BaseViewController

- (void)requestLoginWithModal:(MGLoginModel *)loginModel;

- (void)requestLoginWithModal:(MGLoginModel *)loginModel
                 sendMsgBlock:(MGCommomEventBlock)msgBlock;

@end
