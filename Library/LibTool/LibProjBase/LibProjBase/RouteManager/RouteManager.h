//
//  RouteManager.h
//  TCDemo
//
//  Created by admin on 2020/9/17.
//  Copyright © 2019 CH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JLRoutes/JLRoutes.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RouteManager : NSObject


#pragma mark -  全局路由配置


/**
 路由跳转 无参 通用跳转

 @param name 路由名称
 @param controller 当前调用对象
 */
+ (void)routeForName:(NSString *)name currentC:(UIViewController *)controller;

/**
 路由跳转 带参

 @param name 路由名称
 @param controller 当前调用对象
 @param parameters 参数
 */
+ (void)routeForName:(NSString *)name currentC:(UIViewController *)controller parameters:(NSDictionary * __nullable)parameters;


/**
 添加路由 无参 通用跳转

 @param name 路由名称
 @param vcClass 注册类
 */
+ (void)addRouteForName:(NSString *)name vcClass:(Class)vcClass;

/**
 添加路由 有参数 通用跳转

 @param name 路由名称
 @param handle 数据处理返回 ： parameters 参数   配置后 return vc
 */
+ (void)addRouteForName:(NSString *)name handle:(UIViewController * (^)(NSDictionary<NSString *, id> * __nullable parameters))handle;

/**
 手动配置跳转方式/传参 个性化需求都在这里注册路由

 @param name 注册的路由名称
 @param complete 路由完成回调 ： parameters 参数  nvc 导航控制器
 */
+ (void)addRouteForName:(NSString *)name complete:(void (^)(NSDictionary<NSString *, id> * __nullable parameters, UIViewController *lastVC))complete;


//------------------------------------------------------------------------------------------------------------------------------------------------------------------------


#pragma mark -  分组路由配置

/**
 分组-路由跳转配置

 @param scheme 注册组名
 @param controller 当前调用对象
 @param name 跳转到路由的名字
 @param parameters 传递的参数
 */
+ (void)routeForScheme:(NSString *)scheme
              currentC:(UIViewController *)controller
             routeName:(NSString *)name
            parameters:(NSDictionary * __nullable)parameters;



/**
 分组-添加配置路由

 @param scheme 注册组名
 @param name 路由名
 @param complete 参数
 */
+ (void)addRouteForScheme:(NSString *)scheme
                routeName:(NSString *)name
                 complete:(void (^)(NSDictionary<NSString *, id> * __nullable parameters, UIViewController *lastVC))complete;


@end

NS_ASSUME_NONNULL_END
