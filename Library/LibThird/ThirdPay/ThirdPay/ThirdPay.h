//
//  ThirdPay.h
//  TCDemo
//
//  Created by admin on 2019/9/20.
//  Copyright © 2019 CH. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

typedef void(^ThirdPaymentComplete)(BOOL, NSString *);


@interface ThirdPay : NSObject


/**
 单例属性
 */
@property (nonatomic, readonly, class, strong)ThirdPay *_Nonnull pay;



///微信支付
- (void)wxPay:(NSString *)singleStr complete:(ThirdPaymentComplete)complete;


///支付宝支付
- (void)alipayOrderPayWithParams:(NSString *)apliOrderInfo complete:(ThirdPaymentComplete)complete;


///微信小程序
- (void)wxMiniProgramPay:(NSString *)singleStr complete:(ThirdPaymentComplete)complete;



- (void)payResultToOpenURL:(NSURL *)url;



- (void)handleUniversalLink:(NSUserActivity *)userActivity;


@end

NS_ASSUME_NONNULL_END

