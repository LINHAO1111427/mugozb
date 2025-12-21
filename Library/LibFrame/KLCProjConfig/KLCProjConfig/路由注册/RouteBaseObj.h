//
//  RouteBaseObj.h
//  KLCProjConfig
//
//  Created by klc_sl on 2020/8/31.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RouteBaseObj : NSObject

///公共路由注册放在最后 (因为两个相同的路由名称，会调用先注册的路由)
+ (void)registerBase;



///多人直播
+ (void)registerMPLive;



@end

NS_ASSUME_NONNULL_END
