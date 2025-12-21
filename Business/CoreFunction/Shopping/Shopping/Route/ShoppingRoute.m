//
//  ShoppingRoute.m
//  Shopping
//
//  Created by klc_sl on 2021/7/29.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "ShoppingRoute.h"
#import "LiveTradePreviewFrameVC.h"
#import "StoreHomeViewController.h"
#import "OrderDetailInfoVC.h"
#import "OfficialShopVC.h"
#import "SubmitShopInfoVC.h"
#import "AddingGoodsVC.h"
#import "myShopWithdrawVC.h"
#import "MyShopIncomeVC.h"
#import "CommodityDetailVC.h"
#import "ShopOrderConfirmVc.h"
#import "OrderFormCrustVC.h"
#import "LogisticsDetailVC.h"
#import "OrderDeliverVC.h"
#import "ShippingAddressListVC.h"
#import "PurchaseCarListVC.h"
#import "MyCommodityManageVC.h"

@implementation ShoppingRoute

+ (void)registeRoute{
    
    //官方小店
    [RouteManager addRouteForName:RN_Shopping_OfficialShopVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        OfficialShopVC *shopVC = [[OfficialShopVC alloc] init];
        shopVC.idStr = parameters[@"id"];
        shopVC.postExcerpt = parameters[@"postExcerpt"];
        shopVC.postTitle = parameters[@"postExcerpt"];
        return shopVC;
    }];
    
    ///商家简介
    [RouteManager addRouteForName:RN_Shopping_SubmitShopInfoVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        SubmitShopInfoVC *submitShopInfoVC = [[SubmitShopInfoVC alloc] init];
        submitShopInfoVC.vcType = parameters[@"vcType"];
        return submitShopInfoVC;
    }];
    
    //添加商品
    [RouteManager addRouteForName:RN_Shopping_AddingGoodsVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        BOOL isModify = [parameters[@"isModify"] boolValue];
        AddingGoodsVC *contentVC = [[AddingGoodsVC alloc] init];
        contentVC.isModify = parameters[@"isModify"];
        if (isModify) {
            contentVC.model = parameters[@"model"];
        }
        return contentVC;
    }];
    //官方小店
    [RouteManager addRouteForName:RN_Shopping_ShopContentVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        UIViewController *contentVC = [[NSClassFromString(@"ShopContentVC") alloc] init];
        [contentVC setValue:parameters[@"status"] forKey:@"shStatus"];
        [contentVC setValue:parameters[@"remake"] forKey:@"remake"];
        return contentVC;
    }];
    
    //我的商品管理
    [RouteManager addRouteForName:RN_Shopping_Commodity_ManagerVC vcClass:MyCommodityManageVC.class];
    
    //商品详情
    [RouteManager addRouteForName:RN_Shopping_Commodity_DetailVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        CommodityDetailVC *commodityDetailVC = [[CommodityDetailVC alloc] init];
        commodityDetailVC.goodId = parameters[@"goodId"];
        return commodityDetailVC;
    }];
    
    //购物车
    [RouteManager addRouteForName:RN_Shopping_PurchaseCar_ListVC vcClass:PurchaseCarListVC.class];
    
    //确认订单
    [RouteManager addRouteForName:RN_Shopping_ShopOrder_ConfirmVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        ShopOrderConfirmVc *confirmVC = [[ShopOrderConfirmVc alloc] init];
        confirmVC.dataArray = parameters[@"orderList"];
        return confirmVC;
    }];
    
    //地址编辑与增加
    [RouteManager addRouteForName:RN_Shopping_Address_EditeVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        UIViewController *addressVc = [[NSClassFromString(@"AddOrModifyShippingAddressVC") alloc]init];
        BOOL isModify = [parameters[@"isModify"] boolValue];
        if (isModify) {
            [addressVc setValue:parameters[@"model"] forKey:@"modifyAddressModel"];
        }
        [addressVc setValue:parameters[@"isModify"] forKey:@"isModify"];
        return addressVc;
    }];
    
    //地址列表
    [RouteManager addRouteForName:RN_Shopping_Address_ListVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        ShippingAddressListVC *listVc = [[ShippingAddressListVC alloc]init];
        listVc.selectedAddressId = parameters[@"addressId"];
        return listVc;
    }];
    
    //商家主页
    [RouteManager addRouteForName:RN_Store_Home_DetailVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        StoreHomeViewController *storeVc = [[StoreHomeViewController alloc]init];
        storeVc.shopId = parameters[@"businessId"];
        return storeVc;
    }];
    
    //订单列表
    [RouteManager addRouteForName:RN_Shopping_Order_ListVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        OrderFormCrustVC *orderListVc = [[OrderFormCrustVC alloc]init];
        orderListVc.shop_id = [parameters[@"businessId"] longLongValue] ; //商家id
        orderListVc.type = [parameters[@"type"] intValue];//是商家还是用户
        orderListVc.selectedStatus = [parameters[@"status"] intValue];//选中状态
        orderListVc.navTitle = parameters[@"title"];//标题
        return orderListVc;
    }];
    
    //订单详情
    [RouteManager addRouteForName:RN_Shopping_Order_DetailInfoVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        OrderDetailInfoVC *orderDetailVc = [[OrderDetailInfoVC alloc]init];
        orderDetailVc.order_id = parameters[@"id"];
        orderDetailVc.odType = parameters[@"type"];
        return orderDetailVc;
    }];
    
    //立即发货
    [RouteManager addRouteForName:RN_Shopping_Order_DeliverVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        OrderDeliverVC *deliverVc = [[OrderDeliverVC alloc]init];
        deliverVc.order_id = parameters[@"id"];//订单id
        return deliverVc;
        
    }];
    
    //物流详情
    [RouteManager addRouteForName:RN_Shopping_Order_LogisticDetailVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        
        LogisticsDetailVC *logisticsVc = [[LogisticsDetailVC alloc]init];
        logisticsVc.order_code = parameters[@"busness_code"]; //订单编号
        logisticsVc.logistics_num = parameters[@"logistics_num"]; //运单号
        return logisticsVc;
        
    }];
    
    //我的小店收入
    [RouteManager addRouteForName:RN_Shopping_Order_MyShopIncomeVC vcClass:MyShopIncomeVC.class];
    
    //商家提现
    [RouteManager addRouteForName:RN_Shopping_Order_myShopWithdrawVC vcClass:myShopWithdrawVC.class];
    
    ///直播预告
    [RouteManager addRouteForName:RN_Shopping_LiveTradePreviewFrameVC vcClass:LiveTradePreviewFrameVC.class];
    
}

@end
