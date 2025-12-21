//
//  ProjPublicMethod.h
//  KLCProjConfig
//
//  Created by klc_sl on 2020/8/20.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjPublicMethod : NSObject

///登录
+ (void)logined;

///登出
+ (void)logout;

///token失效
+ (void)tokenInvalid;

///第一次登录
+ (void)firstLogin;

///链接socket
+ (void)connectSocket:(void(^)(void))addAllMonitorBlock;


@end

NS_ASSUME_NONNULL_END
