//
//  ShopOrderConfirmVc.m
//  Shopping
//
//  Created by klc on 2020/7/20.
//  Copyright © 2020 klc. All rights reserved.
//

#import "ShopOrderConfirmVc.h"
#import "ShopOrderListCell.h"
#import "ShopOrderListHeaderView.h"
#import "ShopOrderListFooterView.h"
#import "ShopOrderSubmitView.h"
#import "ShopOrderTableHeaderView.h"
#import <LibProjModel/HttpApiShopCar.h>
#import <LibProjModel/ShopAddressModel.h>
#import <LibProjModel/ShopCarAskDTOModel.h>
#import <LibProjModel/ShopParentOrderModel.h>
#import <LibProjView/PaymentManager.h>
 
 
@interface ShopOrderConfirmVc ()<
UITableViewDelegate,
UITableViewDataSource,
ShopOrderSubmitViewDelegate,
ShopOrderTableHeaderViewDelgate
>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)ShopOrderSubmitView *orderSubmitView;
@property (nonatomic, strong)ShopOrderTableHeaderView *headerV;
@property (nonatomic, strong)ShopAddressModel *selectedAddressModel;
@end

@implementation ShopOrderConfirmVc

- (ShopOrderTableHeaderView *)headerV{
    if (!_headerV) {
        _headerV = [[ShopOrderTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        _headerV.delegate = self;
    }
    return _headerV;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-60-kNavBarHeight-kSafeAreaBottom) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kRGB_COLOR(@"#F6F6F6");
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ShopOrderListCell class] forCellReuseIdentifier:@"ShopOrderListCellID"];
    }
    return _tableView;
}
- (ShopOrderSubmitView *)orderSubmitView{
    if (!_orderSubmitView) {
        _orderSubmitView = [[ShopOrderSubmitView alloc]initWithFrame:CGRectMake(0, kScreenHeight-60-kSafeAreaBottom-kNavBarHeight, kScreenWidth, 60+kSafeAreaBottom)];
        _orderSubmitView.dataArr = self.dataArray;
        _orderSubmitView.delegate = self;
    }
    return _orderSubmitView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getMyAddress];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"确认订单");
    self.view.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.orderSubmitView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shopAddressSelected:) name:@"shopAddressSelected" object:nil];
    //页面设置
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    [self.tableView setTableHeaderView:self.headerV];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"shopAddressSelected" object:nil];
}

///notification
- (void)shopAddressSelected:(NSNotification *)notice{
    ShopAddressModel *addressModel = [notice object];
    [self reloadTableViewHeaderView:addressModel];
}

///刷新头部试图
- (void)reloadTableViewHeaderView:(ShopAddressModel *)addressModel{
    self.selectedAddressModel = addressModel;
    self.headerV.addressModel = addressModel;
    self.tableView.tableHeaderView = self.headerV;
}

- (void)getMyAddress{
    kWeakSelf(self);
    [HttpApiShopCar getShopAddrList:^(int code, NSString *strMsg, NSArray<ShopAddressModel *> *arr) {
        if (code >= 1) {
            ///选择的地址 默认空
            __block ShopAddressModel *model = [[ShopAddressModel alloc] init];
            if (arr.count > 0) {//有地址先默认选第一个
                model = arr.firstObject;
            }
            [arr enumerateObjectsUsingBlock:^(ShopAddressModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.isDefault) {
                    model = obj;
                    *stop = YES;
                }
            }];
            [weakself reloadTableViewHeaderView:model];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
 
#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dict = self.dataArray[section];
    NSArray *commodityList = dict[@"commodityList"];
    return commodityList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopOrderListCellID" forIndexPath:indexPath];
    NSDictionary *dict = self.dataArray[indexPath.section];
    NSArray *commodityList = dict[@"commodityList"];
    ShopCarModel *model;
    if (indexPath.row < commodityList.count) {
        model = commodityList[indexPath.row];
    }
    cell.indexPath = indexPath;
    if (model) {
        cell.model = model;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ShopOrderListHeaderView *header = [[ShopOrderListHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 54)];
    NSDictionary *dict = self.dataArray[section];
    header.dic = dict;
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    ShopOrderListFooterView *footer = [[ShopOrderListFooterView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 54)];
    NSDictionary *dict = self.dataArray[section];
    footer.dic = dict;
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44+10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 54;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94;
}
#pragma mark - ShopOrderSubmitViewDelegate
- (void)ShopOrderSubmitViewSubmitBtnClick{
    if (self.selectedAddressModel.id_field == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择一个收货地址")];
        return;
    }
    NSMutableArray *shopAsks = [NSMutableArray array];
    for (NSDictionary *dict in self.dataArray) {
        NSArray *commodityList = dict[@"commodityList"];
        for (ShopCarModel *model in commodityList) {
            ShopCarAskDTOModel *askModel = [[ShopCarAskDTOModel alloc]init];
            askModel.goodsId = model.goodsId;
            askModel.goodsNum = model.goodsNum;
            askModel.skuId = model.composeId>0?model.composeId:0;
            askModel.carId = model.id_field>0?model.id_field:0;
            [shopAsks addObject:askModel];
        }
    }
    if (shopAsks.count > 0) {
        kWeakSelf(self);
        [HttpApiShopCar purchaseGoods:self.selectedAddressModel.id_field shopCarDTOS:shopAsks callback:^(int code, NSString *strMsg, ShopParentOrderModel *model) {
            if (code == 1) {
                [SVProgressHUD showSuccessWithStatus:strMsg];
                PaymentParamModel *param = [[PaymentParamModel alloc] init];
                param.payId = model.id_field;
                param.price = model.nhrAmount;
                [PaymentManager startPay:param businType:BusinessTypeShop result:^(BOOL success, NSString * _Nullable msg) {
                    if (success) {
                        [weakself.navigationController popViewControllerAnimated:YES];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"shoppingPaySuccess" object:nil];
                    }
                } cancel:^{
                    [weakself.navigationController popViewControllerAnimated:YES];
                }];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }else{
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"无任何商品购买")];
    }
     
    
    
    
}
#pragma mark - ShopOrderTableHeaderViewDelgate
- (void)ShopOrderTableHeaderViewAddressBtnClick:(ShopOrderTableHeaderView *)headerV{
    if (self.selectedAddressModel) {
        [RouteManager routeForName:RN_Shopping_Address_ListVC currentC:self parameters:@{@"addressId":@(self.selectedAddressModel.id_field)}];
    }else{
        [RouteManager routeForName:RN_Shopping_Address_EditeVC currentC:self parameters:@{@"isModify":@(NO)}];
    }
}


@end
