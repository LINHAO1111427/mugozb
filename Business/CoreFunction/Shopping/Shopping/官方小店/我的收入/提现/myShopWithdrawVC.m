//
//  myShopWithdrawVC.m
//  Shopping
//
//  Created by yww on 2020/8/6.
//  Copyright © 2020 klc. All rights reserved.
//  提现

#import "myShopWithdrawVC.h"

#import "ShopIncomeProfitShowView.h"
 
#import <LibProjView/ShopWithdrawAccountVC.h>

#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/AppUsersCashAccountModel.h>
#import <LibProjModel/ShopBusinessModel.h>
#import <LibProjModel/HttpApiShopBusiness.h>
#import <LibProjModel/ShopWithdrawDTOModel.h>
#import <LibProjModel/HttpApiAPPFinance.h>

@interface myShopWithdrawVC ()
@property (nonatomic, strong)UIScrollView *scorllview;
@property (nonatomic, weak)ShopIncomeProfitShowView *showV;
@property (nonatomic, strong)AppUsersCashAccountModel *accountModel;
@property (nonatomic, strong)ShopWithdrawDTOModel *withdrawModel;
@property (nonatomic, strong)ShopBusinessModel *shopModel;
@property (nonatomic, assign)BOOL isPush;

@end

@implementation myShopWithdrawVC
- (UIScrollView *)scorllview{
    if (!_scorllview) {
        _scorllview = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scorllview.showsVerticalScrollIndicator = NO;
        _scorllview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _scorllview;;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.isPush) {
        [self getShopInfo];
    }
    self.isPush = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"提现");
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.scorllview];
    [self loadData];
    
    kWeakSelf(self);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navItemTitle:kLocalizationMsg(@"提现记录") bgColor:[UIColor whiteColor] textColor:[ProjConfig normalColors] clickHandle:^{
        [weakself withdrawList];
    }]];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
- (void)getShopInfo{
    kWeakSelf(self);
    [HttpApiShopBusiness getOne:^(int code, NSString *strMsg, ShopBusinessModel *model) {
        if (code == 1) {
            weakself.shopModel = model;
            weakself.showV.shopModel = model;
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
///提现记录
- (void)withdrawList{
    NSString *strUrl = @"/api/h5/toBusinessWithdrawList";
    [RouteManager routeForName:RN_general_webView currentC:self parameters:@{@"url":strUrl}];
}

//获取提现配置信息
- (void)loadData{
    kWeakSelf(self);
    [HttpApiShopBusiness getWithdrawInfo:^(int code, NSString *strMsg, ShopWithdrawDTOModel *model) {
        if (code == 1) {
            weakself.withdrawModel = model;
            [self createUI];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)createUI{
    CGFloat scale = 302/1009.0;
    CGFloat height = (kScreenWidth-24)*scale;
    ShopIncomeProfitShowView *showV = [[ShopIncomeProfitShowView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height+350)];
    showV.withdrawModel = self.withdrawModel;
    showV.shopModel = self.shopModel;
    showV.accountModel = self.withdrawModel.account;
    self.accountModel = self.withdrawModel.account;
    _showV = showV;
    [self.scorllview addSubview:_showV];
    
    kWeakSelf(self);
    [showV.withdrawAccountBtn klc_whenTapped:^{
        ShopWithdrawAccountVC *accountVC = [[ShopWithdrawAccountVC alloc] init];
        accountVC.defaultModel = weakself.accountModel;
        weakself.accountModel = nil;
        accountVC.selectHandle = ^(AppUsersCashAccountModel * _Nullable model) {
            weakself.accountModel = model;
            weakself.showV.accountModel = model;
        };
        weakself.isPush = YES;
        [weakself.navigationController pushViewController:accountVC animated:YES];
    }];
    
    [showV.withdrawBtn klc_whenTapped:^{
        [weakself withdraw];
    }];
    self.scorllview.contentSize = CGSizeMake(kScreenWidth, height+350+30+kNavBarHeight);
}
 

//商家提现
- (void)withdraw{
    [SVProgressHUD show];
    kWeakSelf(self);
    [HttpApiAPPFinance withdrawAccountApply:self.accountModel.id_field accountName:self.accountModel.name accountType:self.accountModel.type delta:[self.showV.withdrawInputTF.text doubleValue] type:4 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showInfoWithStatus:strMsg];
            [weakself getShopInfo];
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


@end
