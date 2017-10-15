//
//  BaseTableViewCell.m
//  TDBeijiaBill
//
//  Created by ZYN on 2017/4/10.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self preapreCellUI];
    
    [self preapreCellFrame];
    return self;
}


- (void)preapreCellUI {}

- (void)preapreCellFrame {}

@end


@implementation UITableView (identifierCell)

- (BaseTableViewCell *)cellWithCellClass:(Class)cellClass {
    
   return [self cellForIndexPath:nil cellClass:cellClass];
}

- (BaseTableViewCell *)cellForIndexPath:(NSIndexPath *)indexPath cellClass:(Class)cellClass {
    if ([cellClass isSubclassOfClass:BaseTableViewCell.class]){
        NSString *identifier = [NSString stringWithFormat:@"%@ID", NSStringFromClass(cellClass)];
        BaseTableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(cellClass) ofType:@"nib"];
            if (path) {
                [self registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:identifier];
            } else {
                
                [self registerClass:cellClass forCellReuseIdentifier:identifier];
            }
            cell = [self dequeueReusableCellWithIdentifier:identifier];
        }
        return cell;
    }
    return [BaseTableViewCell new];
}

@end
