//
//  HostOrderListVC.m
//  Shopping
//
//  Created by yww on 2020/8/3.
//  Copyright © 2020 klc. All rights reserved.
//

#import "HostOrderListVC.h"
#import "HostOrderTableViewCell.h"
#import "HostOrderListHeaderView.h"
#import "HostOrderListFootView.h"
#import "RefundOrderCheckVc.h"
#import "OrderRefundCommodityCheckView.h"
#import "OrderRefundLogisticsInputView.h"

#import <LibProjModel/AppUserModel.h>
#import <LibProjModel/ShopCarModel.h>
#import <LibProjModel/HttpApiShopOrder.h>
#import <LibProjModel/ShopBusinessOrderModel.h>
#import <LibProjModel/HttpApiShopQuiteOrder.h>

#import <LibProjView/EmptyView.h>
#import <LibProjView/ForceAlertController.h>
#import <LibProjView/PaymentManager.h>

@interface HostOrderListVC ()
<
UITableViewDelegate,
UITableViewDataSource,
HostOrderListFootViewDelegate,
HostOrderListHeaderViewDelegate
>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign)BOOL isRequestingData;
@property (nonatomic, assign)BOOL isPush;
@property (nonatomic, assign)int page;
@property (nonatomic, weak)EmptyView *emptyView;
@end

@implementation HostOrderListVC

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-50-kNavBarHeight-kSafeAreaBottom) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}
-(void)addEmptyView{
    EmptyView *empty = [[EmptyView alloc] init];
    empty.titleL.text = kLocalizationMsg(@"内容为空");
    empty.detailL.text = kLocalizationMsg(@"赶紧去购买吧～");
    [empty showInView:self.tableView];
    _emptyView = empty;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor =  kRGB_COLOR(@"#F6F6F6");
    self.page = 0;
    kWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.page = 0;
        [weakself loadData:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakself.page ++;
        [weakself loadData:NO];
    }];
    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = kSafeAreaBottom;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self addEmptyView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(oderlistNeedRefresh:) name:@"oderlistNeedRefresh" object:nil];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"oderlistNeedRefresh" object:nil];
}
///获取数据
- (void)loadData:(BOOL)isRefresh {
    self.isRequestingData = YES;
    if (isRefresh) {
        self.reloadNumBlick?self.reloadNumBlick():nil;
    }
    if (self.type == OrderTypeForCustomer) {//用户
        [self loadUserOrderListData:isRefresh];
    }else if(self.type == OrderTypeForMerchant){//商家
        [self loadMerchantOrderListData:isRefresh];
    }
}
- (void)oderlistNeedRefresh:(NSNotification *)notice{
    [self loadData:YES];
}
- (void)loadUserOrderListData:(BOOL)isRefresh{
    kWeakSelf(self);
    [HttpApiShopOrder getUserOrderList:self.page pageSize:kPageSize quitStatus:self.status == 4?0:-1 status:self.status == 4?-1:self.status callback:^(int code, NSString *strMsg, NSArray<ShopUserOrderDTOModel *> *arr) {
        weakself.isRequestingData = NO;
        if (isRefresh) {
            [weakself.dataArray removeAllObjects];
        }
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
        if (code == 1) {
            if (arr.count < kPageSize) {
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakself.dataArray addObjectsFromArray:arr];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.tableView reloadData];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        weakself.emptyView.hidden = weakself.dataArray.count;
    }];
}
- (void)loadMerchantOrderListData:(BOOL)isRefresh{
    kWeakSelf(self);
    [HttpApiShopOrder getAnchorOrderList:self.page pageSize:kPageSize quitStatus:self.status == 4?0:-1 status:self.status == 4?-1:self.status callback:^(int code, NSString *strMsg, NSArray<ShopUserOrderDTOModel *> *arr) {
        weakself.isRequestingData = NO;
        if (isRefresh) {
            [weakself.dataArray removeAllObjects];
        }
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
        if (code == 1) {
            if (arr.count < kPageSize) {
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakself.dataArray addObjectsFromArray:arr];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.tableView reloadData];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        weakself.emptyView.hidden = weakself.dataArray.count;
    }];
    
}

#pragma mark - tableview delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ShopUserOrderDTOModel *shopModel;
    if (section < self.dataArray.count) {
        shopModel = self.dataArray[section];
    }
    return shopModel.subOrderList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    HostOrderTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    HostOrderTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"HostOrderTableViewCell"];
    if (!cell) {
        cell = [[HostOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HostOrderTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    cell.indexPath = indexPath;
    ShopUserOrderDTOModel *shopModel;
    if (indexPath.section < self.dataArray.count) {
        shopModel = self.dataArray[indexPath.section];
    }
    
    ShopSubOrderModel *model ;
    if (indexPath.row < shopModel.subOrderList.count) {
        model = shopModel.subOrderList[indexPath.row];
    }
    if (indexPath.row == shopModel.subOrderList.count-1) {
        cell.lastOne = YES;
    }else{
        cell.lastOne = NO;
    }
    cell.model = model;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HostOrderListHeaderView *header = [[HostOrderListHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 54) type:self.type];
    header.section = section;
    header.delegate = self;
    ShopUserOrderDTOModel *shopModel;
    if (section < self.dataArray.count) {
        shopModel = self.dataArray[section];
    }
    header.shopModel = shopModel;
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    HostOrderListFootView *footer = [[HostOrderListFootView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, [self getFooterHeight:section]) type:self.type];
    footer.section = section;
    footer.delegate = self;
    ShopUserOrderDTOModel *shopModel;
    if (section < self.dataArray.count) {
        shopModel = self.dataArray[section];
    }
    footer.shopModel = shopModel;
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44+10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [self getFooterHeight:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopUserOrderDTOModel *shopModel;
    if (indexPath.section < self.dataArray.count) {
        shopModel = self.dataArray[indexPath.section];
    }
    if (shopModel.businessOrder.id_field  > 0) {
        self.isPush = YES;
        [RouteManager routeForName:RN_Shopping_Order_DetailInfoVC currentC:self parameters:@{@"id":@(shopModel.businessOrder.id_field),@"type":@(self.type)}];
    }
}
- (CGFloat)getFooterHeight:(NSInteger)section{
    ShopUserOrderDTOModel *shopModel;
    if (section < self.dataArray.count) {
        shopModel = self.dataArray[section];
    }
    BOOL haveButton = NO;
    if (self.type == OrderTypeForCustomer) {///买家
        if ([self getOrderStatusIsRefundingNeed:shopModel]) {//退款流程
            switch (shopModel.businessOrder.quitStatus) {
                case QuitOrderStatusWaittingCheck://待审核
                    haveButton = YES;
                    break;
                case QuitOrderStatusWaittingForDeliver://待发货
                    haveButton = YES;
                    break;
                case QuitOrderStatusWaittingForReceive://待收货
                    haveButton = YES;
                    break;
                case QuitOrderStatusForComplete://退款完成
                    break;
                default:
                    haveButton = YES;
                    break;
            }
        }else{
            switch (shopModel.businessOrder.status) {//正常
                case HostOrderStatusWaittingForPay://待付款
                    haveButton = YES;
                    break;
                case HostOrderStatusWaittingForDeliver://待发货
                    haveButton = YES;
                    break;
                case HostOrderStatusWaittingForReceive://待收货
                    haveButton = YES;
                    break;
                case HostOrderStatusForComplete://完成
                    haveButton = YES;
                    break;
                default:
                    break;
            }
        }
       }else{///卖家
           if ([self getOrderStatusIsRefundingNeed:shopModel]) {//退款流程
               switch (shopModel.businessOrder.quitStatus) {
                   case QuitOrderStatusWaittingCheck://待审核
                       haveButton = YES;
                       break;
                   case QuitOrderStatusWaittingForReceive://待收货
                       haveButton = YES;
                   default:
                       break;
               }
           }else{
               switch (shopModel.businessOrder.status) {
                   case HostOrderStatusWaittingForDeliver:
                       haveButton = YES;
                       break;
                   case HostOrderStatusWaittingForReceive:
                       haveButton = YES;
                       break;
                   default:
                       break;
               }
           }
            
       }
    if (haveButton) {
        return 97.0;
    }else{
        return 57.0;
    }
}
///判断是否退货订单的特殊处理
- (BOOL)getOrderStatusIsRefundingNeed:(ShopUserOrderDTOModel *)shopModel{
    BOOL isRefunding = NO;
    if (shopModel.businessOrder.refundType > 0) {
        if (shopModel.businessOrder.quitStatus > 0 && shopModel.businessOrder.quitStatus != 7) {
            isRefunding = YES;
        }
    }
    return isRefunding;
}
#pragma mark - HostOrderListFootViewDelegate
- (void)HostOrderListFootView:(HostOrderListFootView *)footer withModel:(ShopUserOrderDTOModel *)model index:(NSInteger)index{
    switch (index) {
            ///正常流程
        case 101://买家取消订单
            [self orderCancelDo:model];
            break;
        case 102://买家立即付款
            [self payNow:model];
            break;
        case 103:{//买家提醒发货
            if ([ProjConfig userId] == model.anchorId) {
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"不能提醒自己发货")];
                return;
            }
            [HttpApiShopOrder remindMerchantsOfDelivery:model.businessOrder.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
                [SVProgressHUD showInfoWithStatus:strMsg];
            }];
        }
            break;
        case 104://买家查看正常物流
            self.isPush = YES;
            if (model.businessOrder.orderNum.length > 0 && model.logisticsNum.length > 0) {
                [RouteManager routeForName:RN_Shopping_Order_LogisticDetailVC currentC:self parameters:@{@"title":kLocalizationMsg(@"物流详情"),@"busness_code":model.businessOrder.orderNum,@"logistics_num":model.logisticsNum}];
            }else{
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"物流不存在")];
                return;
            }
             
            break;
        case 105://买家确认收货
            [self confirmReceiptGoods:model];
            break;
        case 106://买家再次购买
            [self buyAgain:model];
           // NSLog(@"过滤文字再次购买"));
            break;
        case 107:{//卖家联系买家
            kWeakSelf(self);
            if ([ProjConfig userId] == model.buyUser.userid) {
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"不能与自己聊天")];
                return;
            }
            [RouteManager routeForName:RN_Message_ConversationChatVC currentC:[ProjConfig currentVC] parameters:@{@"chatType":@"0",@"msgSendId":@(model.buyUser.userid)}];
            weakself.isPush = YES;
        }
            break;
        case 108://卖家立即发货
            [RouteManager routeForName:RN_Shopping_Order_DeliverVC currentC:self parameters:@{@"id":@(model.businessOrder.id_field)}];
            break;
        case 109://卖家查看正常物流
            self.isPush = YES;
            if (model.businessOrder.orderNum.length > 0 && model.logisticsNum.length > 0) {
                [RouteManager routeForName:RN_Shopping_Order_LogisticDetailVC currentC:self parameters:@{@"title":kLocalizationMsg(@"物流详情"),@"busness_code":model.businessOrder.orderNum,@"logistics_num":model.logisticsNum}];
            }else{
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"物流不存在")];
                return;
            }
            break;
            ///退款流程
        case 200://买家撤销退款申请
            [self cancelOrderRefund:model];
            break;
        case 201:{//买家填写物流单号
            kWeakSelf(self);
            kWeakSelf(model);
            [OrderRefundLogisticsInputView showOrderLogisticsRefundViewCallBack:^(BOOL isLogistics, NSString * _Nonnull name, NSString * _Nonnull num_NO, OrderRefundLogisticsInputView * _Nonnull inputView) {
                if (isLogistics) {
                    [weakself inputRefundLogistics:name logisticsNum:num_NO model:weakmodel];
                }else{
                    inputView = nil;
                }
            }];
        }
            break;
        case 202:{//买家联系客服
            kWeakSelf(self);
            if ([ProjConfig userId] == model.anchorId) {
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"不能与自己聊天")];
                return;
            }
            [RouteManager routeForName:RN_Message_ConversationChatVC currentC:[ProjConfig currentVC] parameters:@{@"chatType":@"0",@"msgSendId":@(model.anchorId)}];
            weakself.isPush = YES;
        }
            break;
        case 203:{//卖家审核退款申请
            if (model) {
                self.isPush = YES;
                RefundOrderCheckVc *redundVc = [[RefundOrderCheckVc alloc]initWithModel:model.businessOrder];
                [self.navigationController pushViewController:redundVc animated:YES];
            }
        }
            break;
        case 204://卖家查看退货物流
            self.isPush = YES;
            if (model.businessOrder.orderNum.length > 0 && model.refundLogisticsNum.length > 0) {
                [RouteManager routeForName:RN_Shopping_Order_LogisticDetailVC currentC:self parameters:@{@"title":kLocalizationMsg(@"物流详情"),@"busness_code":model.businessOrder.orderNum,@"logistics_num":model.refundLogisticsNum}];
            }else{
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"物流不存在")];
                return;
            }
             
            break;
        case 205:{//卖家货物审核
            kWeakSelf(self);
            [OrderRefundCommodityCheckView showOrderLogisticsRefundViewCallBack:^(BOOL isClose, BOOL isAgree, NSString * _Nonnull reason, OrderRefundCommodityCheckView * _Nonnull inputView) {
                if (!isClose) {
                    [weakself checkRefundCommodity:isAgree reason:reason model:model];
                }
                inputView = nil;
            }];
        }
            break;
        default:
            break;
    }
}
//再次购买
- (void)buyAgain:(ShopUserOrderDTOModel *)model{
    self.isPush = YES;
    NSDictionary *params = @{@"businessId":@(model.businessOrder.businessId)};
    [RouteManager routeForName:RN_Store_Home_DetailVC currentC:self parameters:params];
}
 
//卖家货物审核
- (void)checkRefundCommodity:(BOOL)isAgree reason:(NSString *)reason model:(ShopUserOrderDTOModel *)model{
    kWeakSelf(self);
    [HttpApiShopQuiteOrder sellerReceipt:model.businessOrder.id_field reason:isAgree?@"":reason state:isAgree?1:2 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [weakself loadData:YES];
            [SVProgressHUD showSuccessWithStatus:strMsg];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

//填写退款物流单号
- (void)inputRefundLogistics:(NSString *)name logisticsNum:(NSString *)num  model:(ShopUserOrderDTOModel *)model{
    kWeakSelf(self);
    [HttpApiShopQuiteOrder buyerDeliver:model.businessOrder.id_field logisticsName:name logisticsNum:num callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [weakself loadData:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

//撤销退款申请
- (void)cancelOrderRefund:(ShopUserOrderDTOModel *)model{
    kWeakSelf(self);
    ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"撤销退款申请") message:kLocalizationMsg(@"确认撤销退款申请?")];
    [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alertVC addOptions:kLocalizationMsg(@"确定") textColor:ForceAlert_OrangeColor clickHandle:^{
       // NSLog(@"过滤文字撤销申请退款"));
        [HttpApiShopQuiteOrder cancelApplyRefund:model.businessOrder.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [weakself loadData:YES];
                [SVProgressHUD showSuccessWithStatus:strMsg];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }];
    [self presentViewController:alertVC animated:YES completion:nil];
}
//取消订单
- (void)orderCancelDo:(ShopUserOrderDTOModel *)model{
    kWeakSelf(self);
    ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"取消订单") message:kLocalizationMsg(@"确认取消订单吗")];
    [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alertVC addOptions:kLocalizationMsg(@"确定") textUIColor:kRGB_COLOR(@"#FF5500") clickHandle:^{
       // NSLog(@"过滤文字取消订单"));
        [HttpApiShopOrder cancelOrder:model.businessOrder.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [weakself loadData:YES];
                [SVProgressHUD showSuccessWithStatus:strMsg];
            }else{
              [SVProgressHUD showInfoWithStatus:strMsg];
            }
            
        }];
    }];
    [self presentViewController:alertVC animated:YES completion:nil];
}
//确认收货
- (void)confirmReceiptGoods:(ShopUserOrderDTOModel *)model{
    kWeakSelf(self);
    ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"确认收货") message:kLocalizationMsg(@"确认已收到货并完成订单")];
    [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alertVC addOptions:kLocalizationMsg(@"确定") textUIColor:kRGB_COLOR(@"#FF5500") clickHandle:^{
        [HttpApiShopOrder confirmReceipt:model.businessOrder.id_field  callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [weakself loadData:YES];
                [SVProgressHUD showSuccessWithStatus:strMsg];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }];
    [self presentViewController:alertVC animated:YES completion:nil];
}
//立即付款
- (void)payNow:(ShopUserOrderDTOModel *)model{
    PaymentParamModel *param = [[PaymentParamModel alloc] init];
    param.payId = model.businessOrder.payId;
    param.price = model.businessOrder.transactionAmount;
    kWeakSelf(self);
    [PaymentManager startPay:param businType:BusinessTypeShop result:^(BOOL success, NSString * _Nullable msg) {
        if (success) {
            [weakself loadData:YES];
        }
    } cancel:^{
        
    }];
}
#pragma mark - HostOrderListHeaderViewDelegate
- (void)HostOrderListHeaderView:(HostOrderListHeaderView *)header coversationBtnClickWith:(ShopUserOrderDTOModel *)shopModel{
    int64_t to_uid;
    NSString *name;
    if (self.type == OrderTypeForCustomer) {
        to_uid = shopModel.anchorId;
        name = shopModel.businessOrder.businessName;
    }else{
         to_uid = shopModel.buyUser.userid;
         name = shopModel.buyUser.username;
    }
    if ([ProjConfig userId] == to_uid) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"不能与自己聊天")];
        return;
    }
    [RouteManager routeForName:RN_Message_ConversationChatVC currentC:[ProjConfig currentVC] parameters:@{@"chatType":@"0",@"msgSendId":@(to_uid)}];
}

- (void)HostOrderListHeaderView:(HostOrderListHeaderView *)header shopBtnClickWith:(ShopUserOrderDTOModel *)shopModel{
    self.isPush = YES;
    if (self.type == OrderTypeForMerchant) {
        [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(shopModel.buyUser.userid)}];
    }else{
        NSDictionary *params = @{@"businessId":@(shopModel.businessOrder.businessId)};
        [RouteManager routeForName:RN_Store_Home_DetailVC currentC:self parameters:params];
    }
     
}
#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}
- (void)listWillAppear{
    if (!self.isPush) {
        [self loadData:YES];
    }
    self.isPush = NO;
}

@end
