//
//  BaseLogModel.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/5/17.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseLogModel.h"

@implementation BaseLogModel


- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@ -- %p",[self mj_keyValues], self];
}


- (NSString *)debugDescription {
    
    return [NSString stringWithFormat:@"%@ -- %p",[self mj_keyValues], self];
}



@end
