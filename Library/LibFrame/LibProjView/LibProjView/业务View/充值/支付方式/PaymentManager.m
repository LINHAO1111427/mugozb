//
//  PaymentManager.m
//  LiveCommon
//
//  Created by admin on 2020/1/17.
//  Copyright © 2020 . All rights reserved.
//

#import "PaymentManager.h"
#import <UIKit/UIKit.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>

#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/CfgPayWayDTOModel.h>

#import "ThirdPayTypeCell.h"
#import "LibProjModel/HttpApiAPPFinance.h"
#import <LibProjBase/ProjConfig.h>

#import <LibProjModel/HttpApiApiPay.h>

#import <LibProjView/FunctionSheetBaseView.h>

#import "PayResultView.h"
#import "ApplePayObj.h"


@implementation PaymentParamModel

@end



@interface PaymentManager ()<UITableViewDelegate,UITableViewDataSource,ApplePayObjDelegate>

@property (nonatomic, weak)UIView *payTypeSelectView;

@property (nonatomic, assign)BusinessType businType;  ///业务类型

@property (nonatomic, copy)NSArray *payItems;   ///方式

@property (nonatomic, strong)PaymentParamModel *paramModel;

@property (nonatomic, copy)CompleteBlock resultBlock;

@property (nonatomic, copy)CancelBlock cancelBlock;

@property (nonatomic, copy)ApplePayObj *applePay;

@end


@implementation PaymentManager

+ (instancetype)share{
    static PaymentManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[PaymentManager alloc] init];
        }
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)applicationWillEnterForeground{
    
}

+ (void)startPay:(PaymentParamModel *)param businType:(BusinessType)businType result:(CompleteBlock)block cancel:(CancelBlock)cancel {
    ///直接支付
    PaymentManager *payment = [PaymentManager share];
    payment.paramModel = param;
    payment.businType = businType;
    payment.resultBlock = block;
    payment.cancelBlock = cancel;
    [payment startPay];
}

///开始支付
- (void)startPay{
    if (self.paramModel.channelId > 0) {
        [[PaymentManager share] payChannelId:self.paramModel.channelId pageType:self.paramModel.pageType];
    }else{
        ///选择
        if (!self.payTypeSelectView) {
            [self createUIWithParam:self.paramModel hasBgColor:YES];
        }
    }
}


#pragma mark -- 购买视图 --
- (void)createUIWithParam:(PaymentParamModel *)param hasBgColor:(BOOL)has{
    
    UIView *selectTypeV = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 100)];
    selectTypeV.backgroundColor =kRGB_COLOR(@"#FFFFFF");
    _payTypeSelectView = selectTypeV;
    
    CGFloat payPrice = param.price; //原价格
    CGFloat discount = param.discount;//本身折扣
    CGFloat discountMoneyIosVip = param.nobleDiscountMoney;//vip打折
    
    ///价格显示
    UIView *priceBgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,50)];
    [selectTypeV addSubview:priceBgV];
    
    UILabel *showStr = [[UILabel alloc] init];
    showStr.textColor = [ProjConfig normalColors];
    showStr.font = [UIFont systemFontOfSize:22];
    showStr.center= priceBgV.center;
    [priceBgV addSubview:showStr];
    [showStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(priceBgV);
    }];
    CGFloat magin = 0;
    if (payPrice > discount && discount > 0) {
        payPrice = discount;
    }
    if (payPrice > discountMoneyIosVip && discountMoneyIosVip > 0) {
        payPrice = discountMoneyIosVip;
    }
    magin += 20;
    showStr.text = [NSString stringWithFormat:@"¥%0.2lf",payPrice];
    
    ///方式
    self.payItems = KLCAppConfig.appConfig.payConfigList;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, priceBgV.maxY + magin, kScreenWidth, 60*self.payItems.count) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    tableView.bounces = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor whiteColor];
    [tableView registerClass:[ThirdPayTypeCell class] forCellReuseIdentifier:@"ThirdPayTypeCellIdentifier"];
    [selectTypeV addSubview:tableView];
    [tableView reloadData];
    
    selectTypeV.height = tableView.maxY+30;
    kWeakSelf(self);
    [FunctionSheetBaseView showTitle:kLocalizationMsg(@"选择支付方式") detailView:selectTypeV cover:has cancelBack:^{
        [weakself paymentFinish];
        weakself.cancelBlock?weakself.cancelBlock():nil;
        
    }];
}


- (void)dismissView{
    [FunctionSheetBaseView deletePopView:_payTypeSelectView];
}

- (void)paymentFinish{
    _paramModel = nil;
    [self dismissView];
}

#pragma mark  -tableviewdelegate-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _payItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ThirdPayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdPayTypeCellIdentifier" forIndexPath:indexPath];
    cell.payModel = _payItems[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    CfgPayWayDTOModel *dtoModel = _payItems[indexPath.row];
    ///1：APP支付， 2：web网页支付 3：扫码支付,4调起支付宝,5调起微信小程序
    [self payChannelId:(int)dtoModel.id_field pageType:dtoModel.pageType];
    [self dismissView];
}

- (ApplePayObj *)applePay{
    if (!_applePay) {
        _applePay = [[ApplePayObj alloc] init];
        _applePay.delegate = self;
    }
    return _applePay;
}

///请求支付参数
- (void)payChannelId:(int)channerId pageType:(int)pageType{
    kWeakSelf(self);
    [HttpApiApiPay startPay:channerId productId:self.paramModel.payId type:self.businType userId:self.paramModel.receiverUId callback:^(int code, NSString *strMsg, StartPayRetModel *model) {
        if (code == 1) {
            [weakself startPayment:model pageType:pageType channelId:channerId];
        }else{
           // NSLog(@"过滤文字=======支付请求服务器接口报错：%@"), strMsg);
            [weakself paymentSuccessNotification:NO message:strMsg isPayUrl:NO];
        }
    }];
}


///开始支付
- (void)startPayment:(StartPayRetModel *)payModel pageType:(int)pageType channelId:(int)channelId{
    kWeakSelf(self);
    Class<ProjBusniessInterface> cls = [ProjConfig shareInstence].businessConfig;
    if ([cls respondsToSelector:@selector(paymentType:param:resultBlock:)]) {
        if (pageType == 1 && channelId == 3) {///苹果内购
            [self.applePay applePayOrderNO:payModel.orderId productId:payModel.iosPayId];
        }else{
            ///pageType支付页面类型 1：APP支付， 2：web网页支付 3：扫码支付,4调起支付宝,5调起微信小程序
            switch (pageType) {
                case 1:  ///原生
                {
                    NSString *param;
                    int type = 0;
                    switch (channelId) {
                        case 1:
                        {
                            param = payModel.aliPayInfo;
                            type = 1;
                        }
                            break;
                        case 2:
                        {
                            param = payModel.WXPayInfo;
                            type = 2;
                        }
                            break;
                        default:  ///默认无
                            break;
                    }
                    [cls paymentType:type param:param resultBlock:^(BOOL success, NSString *msg){
                        ///通知
                        [weakself paymentSuccessNotification:success message:msg isPayUrl:NO];
                    }];
                }
                    break;
                case 2:
                case 3:
                case 4:
                {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:payModel.url]];
                    [weakself paymentSuccessNotification:YES message:@"" isPayUrl:YES];
                }
                    break;
                case 5: ///小程序
                {
                    NSDictionary *paramDic = @{@"path":payModel.url,
                                               @"userName":payModel.originalId,
                                               @"wechartId":payModel.appid,
                    };
                    NSString *param = [paramDic convertToJsonData];
                    [cls paymentType:3 param:param resultBlock:^(BOOL success, NSString *msg){
                        ///通知成功
                        [weakself paymentSuccessNotification:success message:msg isPayUrl:NO];
                    }];
                }
                    break;
                default:  ///默认无
                    break;
            }
        }
    }
}


///支付结果
- (void)paymentSuccessNotification:(BOOL)success message:(NSString *)message isPayUrl:(BOOL)isPayUrl{
    if (isPayUrl || self.businType == BusinessTypeShop || self.businType == BusinessTypeVip) {
        if (_resultBlock) {
            _resultBlock(success, message);
        }
        [self paymentFinish];
    }else{
        [self showPaymentResult:success message:message];
    }
}


///支付结果显示
- (void)showPaymentResult:(BOOL)success message:(NSString *)msg{
    [self dismissView];
    kWeakSelf(self);
    [PayResultView showResult:success payType:self.businType value:self.paramModel.rechargeCoin failReason:msg btnClick:^(PayResultSelectType selectType) {
        if (selectType == PayResultSelectAgain) {
            [weakself startPay];
        }else{
            weakself.resultBlock?weakself.resultBlock((selectType==success)?YES:NO, msg):nil;
            [self paymentFinish];
        }
    }];
}


#pragma mark -ApplePayObjDelegate-
- (void)applePayStart:(ApplePayObj *)applePay{
    [SVProgressHUD show];
}

- (void)applePayResult:(ApplePayObj *)applePay result:(BOOL)result strMsg:(NSString *)strMsg{
    [SVProgressHUD dismiss];
    [self paymentSuccessNotification:result message:strMsg isPayUrl:NO];
}


@end
