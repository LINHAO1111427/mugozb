//
//  ProjBusinessConfig.m
//  fm3vVideo
//
//  Created by klc_sl on 2020/8/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "ProjBusinessConfig.h"

#import <ThirdPay/ThirdPay.h>

@implementation ProjBusinessConfig

+ (void)paymentType:(int)type param:(NSString *)param resultBlock:(void (^)(BOOL, NSString * _Nonnull))block {
    if (type == 1) {
        [[ThirdPay pay] alipayOrderPayWithParams:param complete:block];
    }
    if (type == 2) {
        [[ThirdPay pay] wxPay:param complete:block];
    }
    if (type == 3) {
        [[ThirdPay pay] wxMiniProgramPay:param complete:block];
    }
}


@end
