//
//  MGPayOrderWayVC.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/31.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGPayOrderWayVC.h"
#import "MGPayOrderWayTableView.h"
#import "MGPayOrderWayModel.h"
#import "YNPay.h"

@interface MGPayOrderWayVC ()
/// 列表
@property (nonatomic, strong) MGPayOrderWayTableView *tableView;

/// 支付
@property (nonatomic, strong) UIButton *payButton;

@end

@implementation MGPayOrderWayVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"支付订单";
    
    
    MGPayOrderWayModel *model1 = [MGPayOrderWayModel new];
    model1.iconName = @"order_icon_bankcard";
    model1.titleName = @"银行卡支付";
    model1.isSelected = YES;
    model1.type = 0;
    
    MGPayOrderWayModel *model2 = [MGPayOrderWayModel new];
    model2.iconName = @"order_icon_alipay";
    model2.titleName = @"支付宝支付";
    model2.isSelected = NO;
    model2.type = 1;
    
    
    MGPayOrderWayModel *model3 = [MGPayOrderWayModel new];
    model3.iconName = @"order_icon_wechat";
    model3.titleName = @"微信支付";
    model3.isSelected = NO;
    model3.type = 2;
    
    
    self.tableView.dataArrayM = @[model1, model2, model3].mutableCopy;
    [self.tableView reloadData];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
}




#pragma mark - 初始化控件
- (void)setupSubViews {

    _tableView = [[MGPayOrderWayTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    
    _payButton = [MGUITool buttonWithBGColor:nil title:@"立即支付" titleColor:MGThemeColor_Black font:MGThemeFont_36 target:self selector:@selector(payButtonOnClick)];
    [_payButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_payButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    _payButton.frame = CGRectMake(0, kScreenHeight - SH(90) - SH(84), SW(600), SH(84));
    _payButton.centerX = kScreenWidth * 0.5;
    _payButton.layer.cornerRadius = MGButtonLayerCorner;
    _payButton.layer.masksToBounds = YES;
    
    
    [self.view sd_addSubviews:@[_tableView, _payButton]];
    
    WEAK
    _tableView.didOnClickSelectedBlock = ^(NSIndexPath *indexPath) {
      STRONG
        MGPayOrderWayModel *model = self.tableView.dataArrayM[indexPath.row];
        
        for (MGPayOrderWayModel *tempModel in self.tableView.dataArrayM) {
            if ([model.iconName isEqualToString:tempModel.iconName]) {
                tempModel.isSelected = YES;
            } else {
                tempModel.isSelected = NO;
            }
        }
        [self.tableView reloadData];
    };
    
    
    
    
    
}

#pragma mark - 加载数据
- (void)loadData {

}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
/// 立即支付
- (void)payButtonOnClick {
    
    MGPayOrderWayModel *model = nil;
    
    for (MGPayOrderWayModel *tempModel in self.tableView.dataArrayM) {
        if (tempModel.isSelected) {
            model = tempModel;
            break;
        }
    }
    if (self.payOrderId == 0) {
        [self showMBText:@"订单号不存在"];
        return ;
    }
    
    NSString *channel = @"";
    switch (model.type) {
        case 0:
        
            break;
        case 1:
            
            break;
        case 2:
            channel = @"wechatpay";
            break;
            
    }
    
    [MGBussiness loadOrderPayWithParams:@{@"id" : @(self.payOrderId), @"channel" : channel} completion:^(NSString * payData) {
        
        switch (model.type) {
            case 0: /// 银联
            {
            
            }
                break;
            case 1: /// 支付宝
            {
                [YNPay payAliWithOrderStrng:payData completeClosure:^(NSString *errorMsg) {
                    if (errorMsg.length > 0) {
                        [self showMBText:@"支付失败"];
                    } else {
                        
                        [self showMBText:@"支付成功！"];
                    }
                    
                    
                }];
            }
                break;
            case 2: /// 微信
            {
                
            
            }
                break;
        }
        
        
        
    } error:nil];
    
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

- (void)setDataModel:(MGResOrderAddDataModel *)dataModel {
    _dataModel = dataModel;
    
    self.payOrderId = dataModel.id;
    
}

- (void)setListDataModel:(MGResOrderListDataModel *)listDataModel {

    _listDataModel = listDataModel;
    
    self.payOrderId = listDataModel.id;
    
}

@end
