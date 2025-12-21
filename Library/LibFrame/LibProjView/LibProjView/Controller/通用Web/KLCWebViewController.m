//
//  KLCWebViewController.m
//  TCDemo
//
//  Created by admin on 2019/9/20.
//  Copyright © 2019 CH. All rights reserved.
//

#import "KLCWebViewController.h"
#import <WebKit/WebKit.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjBase/BaseNavBarItem.h>
#import <LibProjBase/ProjConfig.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/PaymentManager.h>
#import <LibProjModel/HttpApiH5OnlineMallController.h>
#import "KLCNetworkShowView.h"
#import <LibProjView/ForceAlertController.h>

@interface KLCWebViewController ()

@property (nonatomic, weak)KLCNetworkShowView *showView;

@property(nonatomic,strong)NSString *rightTitle;

@end

@implementation KLCWebViewController

- (void)dealloc {
    [_showView removeFromSuperview];
    _showView = nil;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    kWeakSelf(self);
    KLCNetworkShowView *showV = [[KLCNetworkShowView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
    showV.showProgressLine = YES;
    showV.titleBlock = ^(NSString * _Nonnull title) {
        weakself.navigationItem.title = title;
    };
    [self.view addSubview:showV];
    [showV loadRequestUrl:_url];
    _showView = showV;
    
    [showV addScriptName:@"paymentVip" messageHandler:^(id  _Nullable messageBody) {
        ///购买VIP
        [weakself paymentVip:messageBody];
    }];
    
    [showV addScriptName:@"gotoAPP" messageHandler:^(id  _Nullable messageBody) {
        ///跳转到积分app
        NSURL *pushUrl = [NSURL URLWithString:messageBody[@"paramsData"]];
        if (kiOS(10)) {
            [[UIApplication sharedApplication] openURL:pushUrl options:@{} completionHandler:nil];
        }else{
            [[UIApplication sharedApplication] openURL:pushUrl];
        }
        
    }];
    
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    [BaseNavBarItem navbar:self bgImage:[UIImage imageWithColor:[UIColor whiteColor]] foregroundColor:nil];
    return [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navBackBtnImage:[UIImage imageNamed:@"main_navbar_back_black"] target:self action:@selector(backBtnClick)]];
}

- (void)paymentVip:(id)messageBody{
    NSDictionary *dicts = [messageBody objectForKey:@"paramsData"];
    NSInteger payChannel = [dicts[@"payChannel"] intValue];
    kWeakSelf(self);
    // payChannel --> 1:支付宝， 2:微信， 3:苹果内购，4:钻石/金币
    if (payChannel == 4) {
        NSDictionary *paramsDict = @{@"grade" : dicts[@"grade"],
                                     @"nobleId" : dicts[@"id"]};
        [HttpApiH5OnlineMallController buyNoble:[paramsDict[@"grade"] intValue] nobleId:[paramsDict[@"nobleId"] intValue] callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [weakself.showView.webView goBack];
            }else if (code == 7101){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself coinAlert];
                });
            }else {
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    } else{
        PaymentParamModel *param = [[PaymentParamModel alloc] init];
        param.payId = [dicts[@"id"] longLongValue];
        param.price = [dicts[@"coin"] doubleValue];
        param.channelId = [dicts[@"channelId"] intValue];
        param.pageType = [dicts[@"pageType"] intValue];
        [PaymentManager startPay:param businType:BusinessTypeVip result:^(BOOL success, NSString * _Nullable msg) {
            if (success) {
                [weakself.showView.webView goBack];
            }
        } cancel:nil];
    }
}


- (void)coinAlert{
    kWeakSelf(self);
    ForceAlertController *alertVC = [ForceAlertController alertTitle:nil message:kLocalizationMsg(@"您的账户余额不足，请及时充值")];
    [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alertVC addOptions:kLocalizationMsg(@"去充值") textColor:ForceAlert_NormalColor clickHandle:^{
        [RouteManager routeForName:RN_center_myAccountAC currentC:weakself];
    }];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
