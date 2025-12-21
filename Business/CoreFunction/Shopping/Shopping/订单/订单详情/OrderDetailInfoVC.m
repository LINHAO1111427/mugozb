//
//  OrderDetailInfoVC.m
//  Shopping
//
//  Created by yww on 2020/8/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import "OrderDetailInfoVC.h"

#import "OrderRefundView.h"
#import "OrderStatusHeader.h"
#import "RefundOrderCheckVc.h"
#import "OrderDetailHeaderView.h"
#import "OrderDetailFooterView.h"
#import "OrderDetailSectionHeader.h"
#import "OrderDetailSectionFooter.h"
#import "OrderDetailTableViewCell.h"
#import "OrderRefundLogisticsInputView.h"
#import "OrderRefundCommodityCheckView.h"

#import <LibProjModel/AppUserModel.h>
#import <LibProjModel/ShopAddressModel.h>
#import <LibProjModel/HttpApiShopOrder.h>
#import <LibProjModel/ShopSubOrderModel.h>
#import <LibProjModel/ShopParentOrderModel.h>
#import <LibProjModel/HttpApiShopQuiteOrder.h>
#import <LibProjModel/ShopBusinessOrderModel.h>
#import <LibProjModel/ShopUserOrderDetailDTOModel.h>
 
#import <LibProjView/ForceAlertController.h>
#import <LibProjView/PaymentManager.h>


@interface OrderDetailInfoVC ()
<
UITableViewDelegate,
UITableViewDataSource,
OrderDetailHeaderViewDeleagte,
OrderDetailSectionHeaderDelegate,
OrderDetailSectionFooterDelegate,
OrderDetailFooterViewDelegate
>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)OrderStatusHeader *statusHeaderView;
@property (nonatomic, strong)OrderDetailHeaderView *TableHeaderView;
@property (nonatomic, strong)OrderDetailFooterView *TableFooterView;
@property (nonatomic, strong)ShopUserOrderDetailDTOModel *detailModel;
@property (nonatomic, strong)UIButton *refuseResonBtn;
@property (nonatomic, assign)BOOL superVcNeedRefresh;//由于订单详情的状态改变 上一级页面订单列表需要跟新 操作记录
@property (nonatomic, assign)BOOL isPush;//是否进行了push到下一个页面的操作
@property (nonatomic, assign)int type;//订单类型 卖家还是买家
@end

@implementation OrderDetailInfoVC

#pragma mark - lazy
- (UIButton *)refuseResonBtn{
    if (!_refuseResonBtn) {
        _refuseResonBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-90, 7, 80, 30)];
        _refuseResonBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _refuseResonBtn.hidden = YES;
        [_refuseResonBtn addTarget:self action:@selector(refuseResonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_refuseResonBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:kLocalizationMsg(@"未通过原因")];
        NSRange contentRange = {0, [content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        _refuseResonBtn.titleLabel.attributedText = content;
    }
    return _refuseResonBtn;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (OrderStatusHeader *)statusHeaderView{
    if (!_statusHeaderView) {
        CGFloat scale = 280/750.0;
        CGFloat height = kScreenWidth*scale;
        _statusHeaderView = [[OrderStatusHeader alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    }
    return _statusHeaderView;
}
- (OrderDetailHeaderView *)TableHeaderView{
    if (!_TableHeaderView) {
        _TableHeaderView = [[OrderDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        _TableHeaderView.delegate = self;
        _TableHeaderView.backgroundColor = [UIColor clearColor];
        _TableHeaderView.type = self.type;
    }
    return _TableHeaderView;
}
- (OrderDetailFooterView *)TableFooterView{
    if (!_TableFooterView) {
        _TableFooterView = [[OrderDetailFooterView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
        _TableFooterView.type = self.type;
        _TableFooterView.delegate = self;
    }
    return _TableFooterView;
}
#pragma mark - 初始化
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.isPush) {
        [self getDetailData];
    }
    self.superVcNeedRefresh = NO;
    self.isPush = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (!self.isPush) {
        [self.statusHeaderView stopTimer];
    }
    if (!self.isPush && self.superVcNeedRefresh) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"oderlistNeedRefresh" object:nil];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    self.navigationController.navigationBar.translucent = YES;
//    self.navigationItem.title = kLocalizationMsg(@"订单详情");
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.navigationController.navigationBar addSubview:self.refuseResonBtn];//拒绝原因按钮
    [self.view addSubview:self.statusHeaderView];
    [self.view addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adressupdate:) name:@"shopAddressSelected" object:nil];
    [self getDetailData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:@"shopAddressSelected" object:nil];
}

- (void)setOdType:(NSNumber *)odType {
    _odType = odType;
    self.type = [_odType intValue];
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    [BaseNavBarItem navBarBgClear:self foregroundColor:nil];
    return [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navBackBtnImage:[UIImage imageNamed:@"main_navbar_back"] target:target action:action]];
}

#pragma mark - 获取数据
- (void)getDetailData{
    kWeakSelf(self);
    [HttpApiShopOrder getUserOrderDetail:[self.order_id intValue] callback:^(int code, NSString *strMsg, ShopUserOrderDetailDTOModel *model) {
        if (code == 1) {
            weakself.detailModel = model;
            //按钮显示
            BOOL isQuiteOrder = [weakself isQuitOrderWithRefresh:weakself.detailModel];
            
            //stattusHeader
            weakself.statusHeaderView.isQuiterOrder = isQuiteOrder;
            weakself.statusHeaderView.type = weakself.type;
            weakself.statusHeaderView.detailModel = model;
            
            weakself.TableHeaderView.model = weakself.detailModel;
            weakself.TableFooterView.model = weakself.detailModel;
            
            weakself.refuseResonBtn.hidden = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //header
                {
                    [weakself.tableView setTableHeaderView:weakself.TableHeaderView];
                }
                
                //footer
                {
                    CGFloat footerH = 300;
                    if (weakself.detailModel.refundLogisticsNum.length > 0) {//退货物流地址
                        footerH = 380;
                    }
                    weakself.TableFooterView.frame = CGRectMake(0, 0, kScreenWidth, footerH);
                    [weakself.tableView setTableFooterView:weakself.TableFooterView];
                }
                
                //刷新
                [weakself.tableView reloadData];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (BOOL)isQuitOrderWithRefresh:(ShopUserOrderDetailDTOModel *)model{
    BOOL isQuitOrder = NO;
    if ([self getOrderStatusIsRefundingNeed:model]) {//退货退款
        isQuitOrder = YES;
    }else{
        if (model.businessOrder.status == 2 || model.businessOrder.status == 3)  {//代发货待收货
            if (model.businessOrder.quitStatus == 7) {//被拒绝退款
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (model.businessOrder.status == 2) {
                        [self.refuseResonBtn setTitle:kLocalizationMsg(@"未通过原因") forState:UIControlStateNormal];
                    }else{
                        [self.refuseResonBtn setTitle:kLocalizationMsg(@"未收货原因") forState:UIControlStateNormal];
                    }
                    self.refuseResonBtn.hidden = NO;
                });
                isQuitOrder = YES;
            }
        }
    }
    return isQuitOrder;
}
 
#pragma mark - 按钮 通知
- (void)refuseResonBtnClick:(UIButton *)btn{//拒绝原因
    NSString *title;
    if (self.detailModel.businessOrder.quitStatus < 3) {
        title = kLocalizationMsg(@"审核未通过原因");
    }else{
        title = kLocalizationMsg(@"收货未成功原因");
    }
    ForceAlertController *alert = [ForceAlertController alertTitle:title message:self.detailModel.businessOrder.auditFailureReason];
    [alert addOptions:kLocalizationMsg(@"我知道了") textColor:ForceAlert_OrangeColor clickHandle:^{
         
    }];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    
}
#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailModel.subOrderList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    OrderDetailTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    OrderDetailTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailTableViewCell"];
    if (!cell) {
        cell = [[OrderDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderDetailTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ShopSubOrderModel *model;
    cell.type = self.type;
    if (indexPath.row < self.detailModel.subOrderList.count) {
        model = self.detailModel.subOrderList[indexPath.row];
        cell.model = model;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopSubOrderModel *model;
    if (indexPath.row < self.detailModel.subOrderList.count) {
        model = self.detailModel.subOrderList[indexPath.row];
    }
    
    if (model.goodsId > 0) {
        NSDictionary *params = @{@"goodId":@(model.goodsId)};
        self.isPush = YES;
        [RouteManager routeForName:RN_Shopping_Commodity_DetailVC currentC:self parameters:params];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.detailModel) {
        return 100;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.detailModel) {
        return 54;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat footerH = 54;
    if (self.type == OrderTypeForCustomer) {
        if (self.detailModel.businessOrder.status == 2 || self.detailModel.businessOrder.status == 3)  {//代发货待收货
            if (self.detailModel.businessOrder.quitStatus == 7) {//被拒绝退款
                footerH = 114;
            }
        }
        if (self.detailModel.businessOrder.status < 4 && self.detailModel.businessOrder.quitStatus < 4) {
            footerH = 114;
        }
    }else{
        if ([self getOrderStatusIsRefundingNeed:self.detailModel]) {//退款流程
            if (self.detailModel.businessOrder.quitStatus == 1 || self.detailModel.businessOrder.quitStatus == 3) {
                footerH = 114;
            }
        }else{
            if (self.detailModel.businessOrder.status == 2) {
                footerH = 114;
            }
        }
    }
    if (self.detailModel) {
        return footerH;
    }
    return 0;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OrderDetailSectionHeader *header = [[OrderDetailSectionHeader alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 54)];
    header.delegate = self;
    header.type = self.type;
    header.model = self.detailModel;
    return header;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    CGFloat footerH = 54;
    if (self.type == OrderTypeForCustomer) {
        if (self.detailModel.businessOrder.status == 2 || self.detailModel.businessOrder.status == 3)  {//代发货待收货
            if (self.detailModel.businessOrder.quitStatus == 7) {//被拒绝退款
                footerH = 114;
            }
        }
        if (self.detailModel.businessOrder.status < 4 && self.detailModel.businessOrder.quitStatus < 4) {
            footerH = 114;
        }
    }else{
        if ([self getOrderStatusIsRefundingNeed:self.detailModel]) {//退款流程
            if (self.detailModel.businessOrder.quitStatus == 1 || self.detailModel.businessOrder.quitStatus == 3) {
                footerH = 114;
            }
        }else{
            if (self.detailModel.businessOrder.status == 2) {
                footerH = 114;
            }
        }
    }
    OrderDetailSectionFooter *footer = [[OrderDetailSectionFooter alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, footerH) type:self.type];
    footer.delegate = self;
    footer.model = self.detailModel;
    return footer;
}


///判断是否退货订单的特殊处理
- (BOOL)getOrderStatusIsRefundingNeed:(ShopUserOrderDetailDTOModel *)model{
    BOOL isRefunding = NO;
    if (model.businessOrder.refundType > 0) {
        if (model.businessOrder.quitStatus > 0 && model.businessOrder.quitStatus != 7) {
            isRefunding = YES;
        }
    }
    return isRefunding;
}


#pragma mark - OrderDetailSectionHeaderDelegate
- (void)OrderDetailSectionHeader:(OrderDetailSectionHeader *)header shopBtnClickWith:(ShopUserOrderDetailDTOModel *)model{
    self.isPush = YES;
    if (self.type == OrderTypeForMerchant) {
        [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(model.buyUserId)}];
    }else{
        NSDictionary *params = @{@"businessId":@(model.businessOrder.businessId)};
        [RouteManager routeForName:RN_Store_Home_DetailVC currentC:self parameters:params];
    }
     
}

- (void)OrderDetailSectionHeader:(OrderDetailSectionHeader *)header coversationBtnClickWith:(ShopUserOrderDetailDTOModel *)model{
    int64_t to_uid;
    NSString *name;
    if (self.type == OrderTypeForCustomer) {
        to_uid = model.anchorId;
        name = model.businessOrder.businessName;
    }else{
        to_uid = model.buyUserId;
        name = model.buyUserName;
    }
    if ([ProjConfig userId] == to_uid) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"不能与自己聊天")];
        return;
    }
    self.isPush = YES;
    [RouteManager routeForName:RN_Message_ConversationChatVC currentC:[ProjConfig currentVC] parameters:@{@"chatType":@"0",@"msgSendId":@(to_uid)}];
}


#pragma mark - OrderDetailHeaderView
 
- (void)OrderDetailHeaderView:(OrderDetailHeaderView *)header logisticTapWith:(ShopUserOrderDetailDTOModel *)model{
    self.isPush = YES;
    if (model.businessOrder.orderNum.length > 0 && model.logisticsNum.length > 0) {
        [RouteManager routeForName:RN_Shopping_Order_LogisticDetailVC currentC:self parameters:@{@"busness_code":model.businessOrder.orderNum,@"logistics_num":model.logisticsNum}];
    }else{
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"物流不存在")];
        return;
    }
}
#pragma mark - OrderDetailSectionFooterDelegate
- (void)OrderDetailSectionFooter:(OrderDetailSectionFooter *)footer btnClickWith:(NSInteger)tag model:(ShopUserOrderDetailDTOModel *)model{
    switch (tag) {
        case 101://修改收货地址
            self.isPush = YES;
            [RouteManager routeForName:RN_Shopping_Address_ListVC currentC:self parameters:@{@"addressId":@(self.detailModel.businessOrder.addressId)}];
            break;
        case 102://取消订单
            [self orderCancelDo:model];
            break;
        case 103://支付订单
            [self payNow:model];
            break;
        case 104:{//提醒发货
            [HttpApiShopOrder remindMerchantsOfDelivery:model.businessOrder.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
                [SVProgressHUD showInfoWithStatus:strMsg];
            }];
        }
            break;
        case 105:{//申请退款
            kWeakSelf(self);
            [OrderRefundView showOrderRefundViewWith:model andCallBack:^(BOOL isSubmitRefundSuccess) {
                if (isSubmitRefundSuccess) {
                    weakself.superVcNeedRefresh = YES;
                    [weakself getDetailData];
                }
            }];
        }
            break;
        case 106://确认收货
            [self confirmReceiptGoods:model];
            break;
        case 107://立即发货
            self.isPush = YES;
            self.superVcNeedRefresh = YES;
            [RouteManager routeForName:RN_Shopping_Order_DeliverVC currentC:self parameters:@{@"id":@(model.businessOrder.id_field)}];
            break;
            
        case 108:{//撤销退款
            [self cancelOrderRefund];
        }
            break;
        case 109:{//发退货物流
            kWeakSelf(self);
            [OrderRefundLogisticsInputView showOrderLogisticsRefundViewCallBack:^(BOOL isLogistics, NSString * _Nonnull name, NSString * _Nonnull num_NO, OrderRefundLogisticsInputView * _Nonnull inputView) {
                if (isLogistics) {
                    [weakself inputRefundLogistics:name logisticsNum:num_NO];
                }else{
                    inputView = nil;
                }
            }];
        }
            break;
        case 110:{//审核退款申请
            if (model) {
                self.isPush = YES;
                RefundOrderCheckVc *redundVc = [[RefundOrderCheckVc alloc]initWithModel:model.businessOrder];
                [self.navigationController pushViewController:redundVc animated:YES];
            }
        }
            break;
        case 111:{//货物审核
            kWeakSelf(self);
            [OrderRefundCommodityCheckView showOrderLogisticsRefundViewCallBack:^(BOOL isClose, BOOL isAgree, NSString * _Nonnull reason, OrderRefundCommodityCheckView * _Nonnull inputView) {
                if (!isClose) {
                    [weakself checkRefundCommodity:isAgree reason:reason];
                }
                inputView = nil;
            }];
            
        }
            break;
        default:
            break;
    }
}

//货物审核
- (void)checkRefundCommodity:(BOOL)isAgree reason:(NSString *)reason{
    kWeakSelf(self);
    [HttpApiShopQuiteOrder sellerReceipt:self.detailModel.businessOrder.id_field reason:isAgree?@"":reason state:isAgree?1:2 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            weakself.superVcNeedRefresh = YES;
            [weakself getDetailData];
            [SVProgressHUD showSuccessWithStatus:strMsg];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

//填写退款物流单号
- (void)inputRefundLogistics:(NSString *)name logisticsNum:(NSString *)num{
    kWeakSelf(self);
    [HttpApiShopQuiteOrder buyerDeliver:self.detailModel.businessOrder.id_field logisticsName:name logisticsNum:num callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            weakself.superVcNeedRefresh = YES;
            [weakself getDetailData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
//撤销退款申请
- (void)cancelOrderRefund{
    kWeakSelf(self);
    ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"撤销退款申请") message:kLocalizationMsg(@"确认撤销退款申请?")];
    [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alertVC addOptions:kLocalizationMsg(@"确定") textColor:ForceAlert_OrangeColor clickHandle:^{
       // NSLog(@"过滤文字撤销申请退款"));
        [HttpApiShopQuiteOrder cancelApplyRefund:self.detailModel.businessOrder.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                weakself.superVcNeedRefresh = YES;
                [weakself getDetailData];
                [SVProgressHUD showSuccessWithStatus:strMsg];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }];
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (void)orderCancelDo:(ShopUserOrderDetailDTOModel *)model{
    kWeakSelf(self);
    ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"取消订单") message:kLocalizationMsg(@"确认取消订单吗")];
    [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alertVC addOptions:kLocalizationMsg(@"确定") textColor:ForceAlert_OrangeColor clickHandle:^{
       // NSLog(@"过滤文字取消订单"));
        [HttpApiShopOrder cancelOrder:model.businessOrder.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                weakself.superVcNeedRefresh = YES;
                [weakself getDetailData];
                [SVProgressHUD showSuccessWithStatus:strMsg];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }];
    [self presentViewController:alertVC animated:YES completion:nil];
}
//确认收货
- (void)confirmReceiptGoods:(ShopUserOrderDetailDTOModel *)model{
    kWeakSelf(self);
    ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"确认收货") message:kLocalizationMsg(@"确认已收到货并完成订单")];
    [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alertVC addOptions:kLocalizationMsg(@"确定") textColor:ForceAlert_OrangeColor clickHandle:^{
        [HttpApiShopOrder confirmReceipt:model.businessOrder.id_field  callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                weakself.superVcNeedRefresh = YES;
                [weakself getDetailData];
                [SVProgressHUD showSuccessWithStatus:strMsg];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
             
        }];
    }];
    [self presentViewController:alertVC animated:YES completion:nil];
}
//立即付款
- (void)payNow:(ShopUserOrderDetailDTOModel *)model{
    PaymentParamModel *param = [[PaymentParamModel alloc] init];
    param.payId = self.detailModel.parentOrder.id_field;
    param.price = self.detailModel.parentOrder.nhrAmount;
    kWeakSelf(self);
    [PaymentManager startPay:param businType:BusinessTypeShop result:^(BOOL success, NSString * _Nullable msg) {
        if (success) {
            weakself.superVcNeedRefresh = YES;
            [weakself getDetailData];
        }
    } cancel:^{
        
    }];
}

//修改收货地址
- (void)adressupdate:(NSNotification *)notice{
    ShopAddressModel *address = [notice object];
    kWeakSelf(self);
    if (address) {
        [HttpApiShopOrder updateOrderAddress:address.id_field businessOrderId:self.detailModel.businessOrder.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [weakself getDetailData];
                [SVProgressHUD showSuccessWithStatus:strMsg];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}
#pragma mark - OrderDetailFooterViewDelegate
- (void)OrderDetailFooterViewLogisticBtnClick{
    self.isPush = YES;
    if (self.detailModel.businessOrder.orderNum.length > 0 && self.detailModel.refundLogisticsNum.length > 0) {
        [RouteManager routeForName:RN_Shopping_Order_LogisticDetailVC currentC:self parameters:@{@"busness_code":self.detailModel.businessOrder.orderNum,@"logistics_num":self.detailModel.refundLogisticsNum}];
    }else{
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"物流不存在")];
        return;
    }
     
}
@end

