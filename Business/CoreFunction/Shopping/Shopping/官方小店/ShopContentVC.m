//
//  ShopContentVC.m
//  Shopping
//
//  Created by kalacheng on 2020/6/24.
//  Copyright © 2020 klc. All rights reserved.
//

#import "ShopContentVC.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import "ApprovalStatusView.h"
#import "MyOrderV.h"
#import "OrderDataV.h"
#import "ShopManageV.h"
#import <LibProjView/TipAlertView.h>
#import <LibProjModel/HttpApiShopBusiness.h>
#import <LibProjModel/HttpApiShopOrder.h>
#import <LibProjModel/AppMerchantAgreementDTOModel.h>


@interface ShopContentVC ()<ShopManageVDelegate,MyOrderVDelegate,OrderDataVDelegate>
@property(nonatomic,strong)UIScrollView *scrol;
@property(nonatomic,strong)ApprovalStatusView *statusView;
@property(nonatomic,strong)MyOrderV *myOrderV;
@property(nonatomic,strong)OrderDataV *orderDataV;
@property(nonatomic,strong)ShopManageV *shopManageV;
@property(nonatomic,strong)ShopBusinessModel *myShopModel;
@property(nonatomic,assign)int status;//0:没有申请 1:审核中 2.审核通过 3.审核拒绝 4.被冻结

@end

@implementation ShopContentVC

- (void)setShStatus:(NSNumber *)shStatus {
    _shStatus = shStatus;
    self.status = [_shStatus intValue];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getMyShopStatus];
    [self getMyShopInfo];
    [self getOrderNum];
    [self getOrderData:0];
     
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"官方小店");
    self.view.backgroundColor = kRGB_COLOR(@"#F3F3F3");
    [self creatSubView];
}

-(void)creatSubView{
    [self.view addSubview:self.statusView];
    [self.view addSubview:self.scrol];
    
    [self.scrol addSubview:self.myOrderV];
    [self.scrol addSubview:self.orderDataV];
    [self.scrol addSubview:self.shopManageV];
    [self.statusView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(statusViewTap)]];
    
    kWeakSelf(self);
    self.myOrderV.MyOrderVBlock = ^{
        if (weakself.status != 2) {
            [weakself showShopStatusTip];
        }else{
            [RouteManager routeForName:RN_Shopping_Order_ListVC  currentC:weakself parameters:@{@"title":kLocalizationMsg(@"全部订单"),@"type":@(1),@"status":@(0),@"businessId":@(weakself.myShopModel.id_field)}];
        }
    };
    [self.statusView showContentStr:self.remake status:self.status];
}


-(UIScrollView *)scrol{
    if (!_scrol) {
        _scrol = [[UIScrollView alloc] init];
        if (_status == 2) {
            _scrol.frame = CGRectMake(0, 0, kScreenWidth, self.view.height - 30);
        }else{
           _scrol.frame = CGRectMake(0, 30, kScreenWidth, self.view.height - 30);
        }
        _scrol.backgroundColor = kRGB_COLOR(@"#F3F3F3");
    }
    return _scrol;
}

-(ApprovalStatusView *)statusView{
    if (!_statusView) {
        _statusView = [[ApprovalStatusView alloc] init];
        if (_status == 2) {
           _statusView.frame = CGRectMake(0, 0, kScreenWidth, 0);
        }else{
          _statusView.frame = CGRectMake(0, 0, kScreenWidth, 30);
        }
        _statusView.userInteractionEnabled = YES;
    }
    return _statusView;
}

-(MyOrderV *)myOrderV{
    if (!_myOrderV) {
        _myOrderV = [[MyOrderV alloc] initWithFrame:CGRectMake(12, 12, kScreenWidth-24, 135*kScreenWidth/360)];
        _myOrderV.layer.cornerRadius = 6;
        _myOrderV.layer.masksToBounds = YES;
        _myOrderV.backgroundColor = [UIColor whiteColor];
        _myOrderV.delegate = self;
    }
    return _myOrderV;
}

-(OrderDataV *)orderDataV{
    if (!_orderDataV) {
        _orderDataV = [[OrderDataV alloc] initWithFrame:CGRectMake(12, self.myOrderV.maxY + 12, kScreenWidth - 24, 135*kScreenWidth/360)];
        _orderDataV.layer.cornerRadius = 6;
        _orderDataV.layer.masksToBounds = YES;
        _orderDataV.backgroundColor = [UIColor whiteColor];
        _orderDataV.delegate = self;
    }
    return _orderDataV;
}

-(ShopManageV *)shopManageV{
    if (!_shopManageV) {
        _shopManageV = [[ShopManageV alloc] initWithFrame:CGRectMake(12, self.orderDataV.maxY + 12, kScreenWidth - 24, 220*kScreenWidth/360)];
        _shopManageV.layer.cornerRadius = 6;
        _shopManageV.layer.masksToBounds = YES;
        _shopManageV.backgroundColor = [UIColor whiteColor];
        _shopManageV.delegate = self;
    }
    return _shopManageV;
}


- (void)shopManageVFunctionBtnClick:(NSInteger)index{
    if (self.status != 2) {
        [self showShopStatusTip];
        return;
    }
    switch (index) {
        case 0: ///我的收入
            [RouteManager routeForName:RN_Shopping_Order_MyShopIncomeVC currentC:self];
            break;
        case 1:{ ///添加商品
            [RouteManager routeForName:RN_Shopping_AddingGoodsVC currentC:self parameters:@{@"isModify":@(NO)}];
            }break;
        case 2:   ///商家简介
            [RouteManager routeForName:RN_Shopping_SubmitShopInfoVC currentC:self parameters:@{@"vcType":@(1)}];
            break;
        case 3:{  ///优惠券

            }break;
        case 4: ///商品管理
            [RouteManager routeForName:RN_Shopping_Commodity_ManagerVC currentC:self parameters:nil];
            break;
        case 5:{ ///满减活动
            
            }break;
        case 6:   ///直播预告
            [RouteManager routeForName:RN_Shopping_LiveTradePreviewFrameVC currentC:self];
            break;
            
        case 7:{  ///小店预览
            NSDictionary *params = @{@"businessId":@(self.myShopModel.id_field)};
            [RouteManager routeForName:RN_Store_Home_DetailVC currentC:self parameters:params];  
            }break;
        default:
            break;
    }
}

- (void)MyOrderVFunctionBtnClick:(NSInteger)index{
   // NSLog(@"过滤文字index==%ld"),(long)index);
    if (self.status != 2) {
        [self showShopStatusTip];
        return;
    }
    [RouteManager routeForName:RN_Shopping_Order_ListVC  currentC:self parameters:@{@"title":kLocalizationMsg(@"全部订单"),@"type":@(1),@"status":@(index+1),@"businessId":@(self.myShopModel.id_field)}];
}
 
-(void)statusViewTap{
    
    if(self.status == 4){
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"您的小店被冻结了")];
        return;
    }

    [RouteManager routeForName:RN_Shopping_SubmitShopInfoVC currentC:self parameters:@{@"vcType":@(1)}];
}




- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    [BaseNavBarItem navbar:self bgImage:[UIImage imageWithColor:[UIColor whiteColor]] foregroundColor:nil];
    return [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navBackBtnImage:[UIImage imageNamed:@"main_navbar_back_black"] target:self action:@selector(popViewController)]];
}

- (void)popViewController{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}

- (void)getMyShopStatus{
    kWeakSelf(self);
    [HttpApiShopBusiness settleIn:^(int code, NSString *strMsg, AppMerchantAgreementDTOModel *model) {
        if (code == 1) {
            weakself.remake = model.remake;
            weakself.status = model.status;
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
- (void)getMyShopInfo{
    kWeakSelf(self);
    [HttpApiShopBusiness getOne:^(int code, NSString *strMsg, ShopBusinessModel *model) {
        if (code == 1) {
            weakself.myShopModel = model;
        }
    }];
}
- (void)getOrderData:(int)type{
    kWeakSelf(self);
    [HttpApiShopOrder getBusinessOrderInfo:type callback:^(int code, NSString *strMsg, ShopBusinessOrderInfoDTOModel *model) {
        if (code == 1) {
            weakself.orderDataV.model = model;
        }
    }];
}
- (void)getOrderNum{
    kWeakSelf(self);
    [HttpApiShopOrder getOrderNum:2 callback:^(int code, NSString *strMsg, ShopOrderNumDTOModel *model) {
        if (code == 1) {
            weakself.myOrderV.model = model;
        }
    }];
}

- (void)showShopStatusTip{
    if (self.status == 1) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"资料正在审核中")];
    }else if(self.status == 3){
        kWeakSelf(self);
        [TipAlertView showTitle:kLocalizationMsg(@"提示") subTitle:^(UILabel * _Nonnull subTitleL) {
            subTitleL.text = [NSString stringWithFormat:kLocalizationMsg(@"审核被拒：%@"),weakself.remake.length>0?weakself.remake:kLocalizationMsg(@"要修改您的信息哦")];
        } sureBtnTitle:kLocalizationMsg(@"去修改") btnClick:^{
            [RouteManager routeForName:RN_Shopping_SubmitShopInfoVC currentC:self parameters:@{@"vcType":@(1)}];
        } cancel:nil];
    }else if(self.status == 4){
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"您的小店被冻结了")];
    }else{
       // NSLog(@"过滤文字未知状态"));
    }
}

#pragma mark - OrderDataVDelegate
- (void)OrderDataVFunctionBtnClick:(NSInteger)index{
   // NSLog(@"过滤文字index==%ld"),(long)index);
    if (self.status != 2) {
        [self showShopStatusTip];
        return;
    }
}
- (void)OrderDataVTimeSelected:(NSInteger)index{
    [self getOrderData:index];
}

@end
