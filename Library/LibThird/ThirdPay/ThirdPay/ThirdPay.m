//
//  ThirdPay.m
//  TCDemo
//
//  Created by admin on 2019/9/20.
//  Copyright © 2019 CH. All rights reserved.
//

#import "ThirdPay.h"
#import "Order.h"
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
#import <objc/runtime.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LibTools.h>

#import <ShareSDK/ShareSDK.h>

static ThirdPay *_pay = nil;

@interface ThirdPay () <WXApiDelegate>
@end

@implementation ThirdPay

+ (ThirdPay *)pay{
    if (_pay == nil) {
        _pay = [[ThirdPay alloc] init];
    }
    return _pay;
}

- (void)wxPay:(NSString *)singleStr complete:(ThirdPaymentComplete)complete{
    
    if (![WXApi isWXAppInstalled]) {
        complete(NO, kLocalizationMsg(@"请安装微信后进行支付"));
        return;
    }
    
    NSDictionary *dic = [NSString dictionaryWithJsonString:singleStr];
    NSString *wechartId = dic[@"appid"];
    NSString *noncestr = dic[@"noncestr"];
    NSString *package = dic[@"package"];
    NSString *partnerid = dic[@"partnerid"];
    NSString *prepayid = dic[@"prepayid"];
    NSString *sign = dic[@"sign"];
    NSString *timestamp = dic[@"timestamp"];
    
    objc_setAssociatedObject(self, @"thirdPayKey", complete, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [WXApi registerApp:wechartId universalLink:[[ProjConfig shareInstence].keyConfig universalLink]];
    
    if ([prepayid isEqual:[NSNull null]] || prepayid == NULL || [prepayid isEqual:@"null"]) {
        prepayid = @"123";
    }
    
    //调起微信支付
    NSString *times         = timestamp;
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = partnerid;
    req.prepayId            = prepayid;
    req.nonceStr            = noncestr;
    req.timeStamp           = times.intValue;
    req.package             = package;
    req.sign                = sign;
    [WXApi sendReq:req completion:^(BOOL success) {
        if (!success) {
            complete(success, kLocalizationMsg(@"支付失败"));
        }
    }];
}


- (void)wxMiniProgramPay:(NSString *)singleStr complete:(ThirdPaymentComplete)complete{
    
    if (![WXApi isWXAppInstalled]) {
        complete(NO, kLocalizationMsg(@"请安装微信后进行支付"));
        return;
    }
    
    NSData *jsonData = [singleStr dataUsingEncoding:(NSUTF8StringEncoding)];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:(NSJSONReadingFragmentsAllowed) error:nil];
    
    NSString *path = [dic[@"path"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *userName = [dic[@"userName"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *wechartId = [dic[@"wechartId"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [WXApi registerApp:wechartId universalLink:[[ProjConfig shareInstence].keyConfig universalLink]];
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    [shareParams SSDKSetupShareParamsByText:@""
                                     images:nil
                                        url:[NSURL URLWithString:@""]
                                      title:@""
                                       type:SSDKContentTypeAuto];
    
    [ShareSDK share:SSDKPlatformTypeWechat parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
    }];
    
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    launchMiniProgramReq.userName = userName;
    launchMiniProgramReq.path = path;
    launchMiniProgramReq.miniProgramType = WXMiniProgramTypeRelease;
    [WXApi sendReq:launchMiniProgramReq completion:^(BOOL success) {
        if (!success) {
            complete(success, kLocalizationMsg(@"支付失败"));
        }
    }];
}



- (void)onResp:(BaseResp *)resp{
    ThirdPaymentComplete complete = objc_getAssociatedObject(self, @"thirdPayKey");
    //支付返回结果，实际支付结果需要去微信服务器端查询
    //    NSString *strMsg = [NSString stringWithFormat:kLocalizationMsg(@"支付结果")];
    switch (resp.errCode) {
        case WXSuccess:
            //            strMsg = kLocalizationMsg(@"支付结果：成功！");
           // NSLog(@"过滤文字支付成功－PaySuccess，retcode = %d"), resp.errCode);
            if (complete) {
                complete(YES, kLocalizationMsg(@"支付成功"));
            }
            break;
        default:
            //            strMsg = [NSString stringWithFormat:kLocalizationMsg(@"支付结果：失败！retcode = %d, retstr = %@"), resp.errCode,resp.errStr];
           // NSLog(@"过滤文字错误，retcode = %d, retstr = %@"), resp.errCode,resp.errStr);
            if (complete) {
                complete(NO, resp.errStr);
            }
            break;
    }
    
    objc_removeAssociatedObjects(self);
    _pay = nil;
}



- (void)payResultToOpenURL:(NSURL *)url{
    
    ThirdPaymentComplete complete = objc_getAssociatedObject(self, @"thirdPayKey");
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            
           // NSLog(@"过滤文字result = %@"),resultDic);
            int statusCode = [resultDic[@"resultStatus"]  intValue];
            if (statusCode == 9000){
                //订单支付
               // NSLog(@"过滤文字______支付成功"));
                complete(YES, kLocalizationMsg(@"支付成功"));
            }
            else{
                NSString *errorStr = resultDic[@"memo"];
                switch (statusCode) {
                    case 8000:
                    {
                        errorStr = errorStr.length>0?errorStr:kLocalizationMsg(@"正在处理中");
                    }
                        break;
                    case 4000:
                    {
                        errorStr = errorStr.length>0?errorStr:kLocalizationMsg(@"订单支付失败");
                    }
                        break;
                    case 6001:
                    {
                        errorStr = errorStr.length>0?errorStr:kLocalizationMsg(@"用户中途取消");
                    }
                        break;
                    case 6002:
                    {
                        errorStr = errorStr.length>0?errorStr:kLocalizationMsg(@"网络连接出错");
                    }
                        break;
                    default:
                    {
                        errorStr = errorStr.length>0?errorStr:kLocalizationMsg(@"支付失败");
                    }
                        break;
                }
                //交易失败
                complete(NO, errorStr);
            }
        }];
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
           // NSLog(@"过滤文字result = %@"),resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
           // NSLog(@"过滤文字授权结果 authCode = %@"), authCode?:@"");
        }];
    }
    //微信支付回调
    if ([url.host isEqualToString:@"pay"]) {
        [WXApi handleOpenURL:url delegate:self];
    }
    
    objc_removeAssociatedObjects(self);
    _pay = nil;
}

- (void)handleUniversalLink:(NSUserActivity *)userActivity{
    [WXApi handleOpenUniversalLink:userActivity delegate:self];
}


#pragma mark - 支付宝 -

//支付宝
- (void)alipayOrderPayWithParams:(NSString *)apliOrderInfo complete:(ThirdPaymentComplete)complete{
    
    objc_setAssociatedObject(self, @"thirdPayKey", complete, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:apliOrderInfo fromScheme:[ProjConfig getAppSchemeUrl] callback:^(NSDictionary *resultDic) {
       // NSLog(@"过滤文字reslut = %@"),resultDic);
        int statusCode = [resultDic[@"resultStatus"]  intValue];
        if (statusCode == 9000){
            //订单支付
           // NSLog(@"过滤文字______支付成功"));
            complete(YES, kLocalizationMsg(@"支付成功"));
        }
        else{
            NSString *errorStr = kLocalizationMsg(@"支付失败");
            switch (statusCode) {
                case 8000:
                    errorStr = kLocalizationMsg(@"正在处理中");
                    break;
                case 4000:
                    errorStr = kLocalizationMsg(@"订单支付失败");
                    break;
                case 6001:
                    errorStr = kLocalizationMsg(@"用户中途取消");
                    break;
                case 6002:
                    errorStr = kLocalizationMsg(@"网络连接出错");
                    break;
                default:
                    break;
            }
            //交易失败
            complete(NO, errorStr);
        }
        _pay = nil;
    }];
}


@end
