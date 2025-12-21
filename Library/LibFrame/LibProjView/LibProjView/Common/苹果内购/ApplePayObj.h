//
//  ApplePayObj.h
//  LibProjBase
//
//  Created by klc_sl on 2020/7/22.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ApplyPaymentResultState) {
    ApplePayStateStart,
    ApplePayStateSuccess,
    ApplePayStateFail,
};

@class ApplePayObj;

@protocol ApplePayObjDelegate <NSObject>

- (void)applePayStart:(ApplePayObj *)applePay;

- (void)applePayResult:(ApplePayObj *)applePay result:(BOOL)result strMsg:(NSString *)strMsg;

@end

@interface ApplePayObj : NSObject

@property (nonatomic, weak)id<ApplePayObjDelegate> delegate;

- (void)applePayOrderNO:(NSString *)orderNO productId:(NSString *)productId;



@end

NS_ASSUME_NONNULL_END
