//
//  ApplePayObj.m
//  LibProjBase
//
//  Created by klc_sl on 2020/7/22.
//  Copyright © 2020 . All rights reserved.
//

#import "ApplePayObj.h"
#import <StoreKit/StoreKit.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/ProjConfig.h>
#import <LibProjModel/HttpApiApiPay.h>

typedef void(^PaymentResult)(ApplyPaymentResultState state, NSString *msg);

static ApplePayObj *_applePay = nil;

@interface ApplePayObj ()<SKProductsRequestDelegate,SKPaymentTransactionObserver>

@property (nonatomic, copy)SKProductsRequest *request;

@property (nonatomic, copy)NSString *productId;

@property (nonatomic, copy)NSString *orderNo;

@property (nonatomic, copy)PaymentResult resultBlock;

@end

@implementation ApplePayObj

- (void)dealloc
{
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)removeObserver {
    //添加一个交易队列观察者
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (void)payOrderId:(NSString *)orderId productId:(NSString *)productId resultBlock:(PaymentResult)resultBlock {
    _resultBlock = resultBlock;
    if ([SKPaymentQueue canMakePayments]) {
        [self requestProductData:productId];
    }else{
       // NSLog(@"过滤文字--------不允许程序内付费------------"));
        [self resultHandle:ApplePayStateFail msg:kLocalizationMsg(@"不允许程序内付费")];
    }
}

- (void)resultHandle:(ApplyPaymentResultState)state msg:(NSString *)msg{
    if (_resultBlock) {
        _resultBlock(state, msg);
    }
    if (state == ApplePayStateSuccess || state == ApplePayStateFail) {
        [self removeObserver];
        _applePay = nil;
    }
}

///请求苹果支付
-(void)requestProductData:(NSString *)productId{
   // NSLog(@"过滤文字--------请求对应的产品信息------------"));
   // NSLog(@"过滤文字请求对应的产品信息: %@"),productId);
    NSSet *nsset = [NSSet setWithObjects:productId, nil];
    _request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    _request.delegate = self;
    [_request start];
    [self resultHandle:ApplePayStateStart msg:kLocalizationMsg(@"开始支付")];
}


///收到产品反馈消息
-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
   // NSLog(@"过滤文字-------收到产品反馈消息----------"));
    NSArray *product = response.products;
    if ([product count] == 0) {
       // NSLog(@"过滤文字-----没有商品-------"));
        [self resultHandle:ApplePayStateFail msg:kLocalizationMsg(@"没有该商品")];
        return;
    }
    
   // NSLog(@"过滤文字productID:%@"),response.invalidProductIdentifiers);
   // NSLog(@"过滤文字产品付费数量:%lu"),(unsigned long)product.count);
    
    SKProduct *prod = nil;
    for (SKProduct *pro in product) {
       // NSLog(@"过滤文字%@"),pro.description);
       // NSLog(@"过滤文字%@"),pro.localizedTitle);
       // NSLog(@"过滤文字%@"),pro.localizedDescription);
       // NSLog(@"过滤文字%@"),pro.price);
       // NSLog(@"过滤文字%@"),pro.productIdentifier);
        
        if ([pro.productIdentifier isEqualToString:self.productId]) {
            prod = pro;
        }
    }
    
    if (prod != nil) {
        //发送购买请求
       // NSLog(@"过滤文字-------发送购买请求-------"));
        SKPayment *payment = [SKPayment paymentWithProduct:prod];
        [self removeObserver];
        //添加一个交易队列观察者
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
}


#pragma mark - SKRequestDelegate -
-(void)request:(SKRequest *)request didFailWithError:(NSError *)error{
   // NSLog(@"过滤文字购买失败：%@"),error);
    [self resultHandle:ApplePayStateFail msg:error.localizedDescription];
}
- (void)requestDidFinish:(SKRequest *)request{
   // NSLog(@"过滤文字请求结束"));
}

#pragma mark - SKPaymentTransactionObserver -
/// 监听购买的结果
// Sent when the transaction array has changed (additions or state changes).  Client should check state of transactions and finish as appropriate.
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions{
    
    for (SKPaymentTransaction *trans in transactions) {
        switch (trans.transactionState) {
            case SKPaymentTransactionStatePurchasing:
            {
               // NSLog(@"过滤文字==商品添加进列表=="));
            }
                break;
            case SKPaymentTransactionStatePurchased:
            {
               // NSLog(@"过滤文字==交易完成=="));
                [self completeTransaction:trans];
            }
                break;
            case SKPaymentTransactionStateFailed:
            {
               // NSLog(@"过滤文字交易失败"));
                [self failedTransaction:trans];
            }
                break;
            case SKPaymentTransactionStateRestored:
            {
               // NSLog(@"过滤文字==已经购买过商品=="));
                [self restoreTransaction:trans];
                //                [[SKPaymentQueue defaultQueue] finishTransaction:tran]; 消耗型商品不用写
            }
                break;
            case SKPaymentTransactionStateDeferred:
            {
               // NSLog(@"过滤文字==交易延期=="));
            }
                break;
            default:
                break;
        }
    }
}

///购买失败
- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
       // NSLog(@"过滤文字Transaction error: %@"), transaction.error.localizedDescription);
        
    }else{
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    [self resultHandle:ApplePayStateFail msg:transaction.error.localizedDescription];
}

///恢复购买
- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    [self resultHandle:ApplePayStateFail msg:transaction.error.localizedDescription];
    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"用户已经恢复购买")];
}


//交易结束,当交易结束后还要去appstore上验证支付信息是否都正确,只有所有都正确后,我们就可以给用户方法我们的虚拟物品了。
- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    kWeakSelf(self);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[[NSBundle mainBundle] appStoreReceiptURL]];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            
            NSString *encodeStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            ///向服务器发送
            [HttpApiApiPay iosPayCallBack:weakself.orderNo payload:encodeStr.length>0?encodeStr:@"" transactionId:transaction.transactionIdentifier callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
                [weakself resultHandle:(code == 1)?ApplePayStateSuccess:ApplePayStateFail msg:strMsg];
                if (code != 1) {
                    [SVProgressHUD showInfoWithStatus:strMsg];
                }
            }];
        }else{
            [weakself resultHandle:ApplePayStateFail msg:error.localizedDescription];
        }
    }];
    [dataTask resume];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];//完成交易状态
}


- (void)applePayOrderNO:(NSString *)orderNO productId:(NSString *)productId{

    _orderNo = orderNO;
    _productId = productId;
    
    kWeakSelf(self);
    [self payOrderId:orderNO productId:productId resultBlock:^(ApplyPaymentResultState state, NSString *msg) {
        [weakself payResult:state showMsg:msg];
    }];
}

- (void)payResult:(ApplyPaymentResultState)state showMsg:(NSString *)msg{
    switch (state) {
        case ApplePayStateStart:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(applePayStart:)]) {
                [self.delegate applePayStart:self];
            }
        }
            break;
        case ApplePayStateSuccess:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(applePayResult:result:strMsg:)]) {
                [self.delegate applePayResult:self result:YES strMsg:kLocalizationMsg(@"支付成功")];
            }
        }
            break;
        case ApplePayStateFail:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(applePayResult:result:strMsg:)]) {
                [self.delegate applePayResult:self result:NO strMsg:msg];
            }
        }
            break;
        default:
            break;
    }
}




@end
