//
//  LogisticsDetailVC.m
//  Shopping
//
//  Created by yww on 2020/8/5.
//  Copyright © 2020 klc. All rights reserved.
//  物流详情

#import "LogisticsDetailVC.h"
#import "LogisticListTable.h"
#import <LibProjModel/HttpApiShopOrder.h>
#import <LibProjModel/ApiShopLogisticsDTOModel.h>
 
@interface LogisticsDetailVC ()

@property (nonatomic, strong)UILabel *logisticsHeaderL;
@property (nonatomic, strong)ApiShopLogisticsDTOModel *logisticsModel;

@end

@implementation LogisticsDetailVC

- (UILabel *)logisticsHeaderL{
    if (!_logisticsHeaderL) {
        _logisticsHeaderL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        _logisticsHeaderL.backgroundColor = kRGB_COLOR(@"#F8F8F8");
        _logisticsHeaderL.textColor = kRGB_COLOR(@"#444444");
        _logisticsHeaderL.font = [UIFont systemFontOfSize:12];
    }
    return _logisticsHeaderL;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = kLocalizationMsg(@"物流详情");
    [self.view addSubview:self.logisticsHeaderL];
    [self getLogisticsData];
}

- (void)getLogisticsData{
    kWeakSelf(self);
    [HttpApiShopOrder getLogistics:self.logistics_num orderNo:self.order_code callback:^(int code, NSString *strMsg, ApiShopLogisticsDTOModel *model) {
        if (code == 1) {
            weakself.logisticsModel = model;
            weakself.logisticsHeaderL.text = [NSString stringWithFormat:@" %@  %@",model.expName,model.number];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself addCategoryView];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)addCategoryView{

    LogisticListTable *list = [[LogisticListTable alloc]initWithFrame:CGRectMake(0, self.logisticsHeaderL.height, kScreenWidth, kScreenHeight-kNavBarHeight-self.logisticsHeaderL.height) style:UITableViewStylePlain];
    list.separatorStyle = UITableViewCellSeparatorStyleNone;
    list.logisticsModel = self.logisticsModel;
    [self.view addSubview:list];
    list.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    list.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    
}

 
@end
