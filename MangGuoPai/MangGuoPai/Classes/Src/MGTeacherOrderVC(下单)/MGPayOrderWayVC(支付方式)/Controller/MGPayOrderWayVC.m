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
#import "MGOrderPayResultVC.h"
#import "WXApi.h"

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
    
    NSMutableArray *dataArrayM = @[].mutableCopy;
    
//    MGPayOrderWayModel *model1 = [MGPayOrderWayModel new];
//    model1.iconName = @"order_icon_bankcard";
//    model1.titleName = @"银行卡支付";
//    model1.isSelected = YES;
//    model1.type = 0;
//    
    MGPayOrderWayModel *model2 = [MGPayOrderWayModel new];
    model2.iconName = @"order_icon_alipay";
    model2.titleName = @"支付宝支付";
    model2.type = 1;
    
    
    if ([PPShareManager isWXAppInstalled]) {
        
        MGPayOrderWayModel *model3 = [MGPayOrderWayModel new];
        model3.iconName = @"order_icon_wechat";
        model3.titleName = @"微信支付";
        model3.isSelected = YES;
        model3.type = 2;
        
        [dataArrayM addObject:model3];
        
    } else {
        /// 选中支付宝
        model2.isSelected = YES;

    }
    
    [dataArrayM addObject:model2];
    
    
    self.tableView.dataArrayM = dataArrayM;
    [self.tableView reloadData];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
}




#pragma mark - 初始化控件
- (void)setupSubViews {

    _tableView = [[MGPayOrderWayTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    
    _payButton = [MGUITool buttonWithBGColor:nil title:@"立即支付" titleColor:MGThemeColor_Title_Black font:MGThemeFont_36 target:self selector:@selector(payButtonOnClick)];
    [_payButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportDefaultColor] forState:UIControlStateNormal];
    [_payButton setBackgroundImage:[UIImage imageWithColor:MGButtonImportHighLightedColor] forState:UIControlStateHighlighted];
    _payButton.frame = CGRectMake(0, kScreenHeight - SH(90) - SH(84), SW(600), SH(84));
    _payButton.centerX = kScreenWidth * 0.5;
    _payButton.layer.cornerRadius = MGButtonLayerCorner;
    _payButton.layer.masksToBounds = YES;
    
    
    [self.view sd_addSubviews:@[_tableView, _payButton]];
    
    WEAK
    _tableView.didSelectedRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
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
            channel = @"alipay";
            break;
        case 2:
            channel = @"wechatpay";
            break;
            
    }
    
    /// 测试环境 走直通接口
    [MGBussiness loadOrderPayWithParams:@{@"id" : @(self.payOrderId), @"channel" : channel} completion:^(NSString * payData) {
        
        switch (model.type) {
            case 0: /// 银联
            {
            
            }
                break;
            case 1: /// 支付宝
            {
                
                [YNPay payAliWithOrderStrng:payData completeClosure:^(NSString *errorMsg) {
                    if ([errorMsg isEqualToString:@"用户中途取消"]) {
                        [self showMBText:@"取消支付"];
                        return;
                    }
                    
                    MGOrderPayResultVC *vc = [MGOrderPayResultVC new];
                    vc.listDataModel = self.listDataModel;
                    vc.payWay = model.titleName;
                    vc.isPaySuccess = errorMsg.length == 0 ? YES : NO;
                    PushVC(vc);
                    
                    if (vc.isPaySuccess) {
                        /// 发送支付完成通知
                        [[NSNotificationCenter defaultCenter] postNotificationName:OrderPayFinishRefreshView object:nil];
                    }
                }];
            }
                break;
            case 2: /// 微信
            {
                if (!(PROD_CONFIG)) {
                    MGOrderPayResultVC *vc = [MGOrderPayResultVC new];
                    vc.listDataModel = self.listDataModel;
                    vc.payWay = model.titleName;
                    vc.isPaySuccess = YES;
                    PushVC(vc);
                    if (vc.isPaySuccess) {
                        /// 发送支付完成通知
                        [[NSNotificationCenter defaultCenter] postNotificationName:OrderPayFinishRefreshView object:nil];
                    }
                    return;
                }
                
                if(![WXApi isWXAppInstalled]) {
                    [self showMBText:@"请先安装微信客户端"];
                    return;
                };
                NSData *jsonData = [payData dataUsingEncoding:NSUTF8StringEncoding];
                NSError *err;
                NSDictionary *payDataDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                            options:NSJSONReadingMutableContainers
                                                                              error:&err];
                
                if(err) {
                    [self showMBText:@"后台支付数据解析异常"];
                    return;
                }
                [YNPay payWxWithPayDataDict:payDataDict completeClosure:^(NSString *errorMsg) {
                    
                    if ([errorMsg isEqualToString:@"取消支付"]) {
                        [self showMBText:errorMsg];
                        return;
                    }
                    
                    MGOrderPayResultVC *vc = [MGOrderPayResultVC new];
                    vc.listDataModel = self.listDataModel;
                    vc.payWay = model.titleName;
                    vc.isPaySuccess = errorMsg.length == 0 ? YES : NO;
                    PushVC(vc);
                    
                    if (vc.isPaySuccess) {
                        /// 发送支付完成通知
                        [[NSNotificationCenter defaultCenter] postNotificationName:OrderPayFinishRefreshView object:nil];
                        
                    }
                    
                }];
            
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

- (void)setListDataModel:(MGResOrderListDataModel *)listDataModel {

    _listDataModel = listDataModel;
    
    self.payOrderId = listDataModel.id;
    
}

@end
