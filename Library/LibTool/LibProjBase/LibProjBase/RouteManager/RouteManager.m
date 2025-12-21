//
//  RouteManager.m
//  TCDemo
//
//  Created by admin on 2020/9/17.
//  Copyright © 2019 CH. All rights reserved.
//

#import "RouteManager.h"
#import "ProjConfig.h"

// 通用参数名称
#define kRouteParaLastVC          @"kRouteParaLastVC"

@implementation RouteManager


+ (void)routeForName:(NSString *)name currentC:(nonnull UIViewController *)controller{
    [RouteManager routeForName:name currentC:controller parameters:nil];
}

+ (void)routeForName:(NSString *)name currentC:(nonnull UIViewController *)controller parameters:(NSDictionary * _Nullable)parameters{
    [[JLRoutes globalRoutes] routeURL:[NSURL URLWithString:name] withParameters:[RouteManager getParameters:parameters currentC:controller]];
    parameters = nil;
}

+ (void)routeForScheme:(NSString *)scheme currentC:(nonnull UIViewController *)controller routeName:(nonnull NSString *)name parameters:(NSDictionary * _Nullable)parameters{
    [[JLRoutes routesForScheme:scheme] routeURL:[NSURL URLWithString:name] withParameters: [RouteManager getParameters:parameters currentC:controller]];
    parameters = nil;    
}

+ (NSDictionary *)getParameters:(NSDictionary * _Nullable)parameters currentC:(nonnull UIViewController *)controller{
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] init];
    if (parameters) {
        [muDic addEntriesFromDictionary:parameters];
    }
    [muDic setObject:controller forKey:kRouteParaLastVC];
    
    NSDictionary *paraDic = [muDic copy];
    muDic = nil;
    return paraDic;
}


+ (void)addRouteForName:(NSString *)name vcClass:(Class)vcClass{

    [RouteManager addRouteForName:name handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        return [[vcClass alloc] init];
    }];
}

+ (void)addRouteForName:(NSString *)name handle:(UIViewController * _Nonnull (^)(NSDictionary<NSString *,id> * _Nullable))handle{
    
    [RouteManager addRouteForName:name complete:^(NSDictionary<NSString *,id> * _Nullable parameters, UIViewController * _Nonnull lastVC) {
        if (handle) {
            if (!lastVC) {
                lastVC = [ProjConfig currentVC];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                UIViewController *pushVC = handle(parameters);
                [lastVC.navigationController pushViewController:pushVC animated:YES];
            });
            
        }else{
           // NSLog(@"过滤文字===nvc没有值==="));
        }
    }];
}

+ (void)addRouteForName:(NSString *)name complete:(void (^)(NSDictionary<NSString *,id> * _Nullable, UIViewController * _Nonnull))complete {
    
    [[JLRoutes globalRoutes] addRoute:name handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:parameters];
        UIViewController *lastVC = parameters[kRouteParaLastVC];
        if (!lastVC) {
            lastVC = [ProjConfig currentVC];
        }else{
            [muDic removeObjectForKey:kRouteParaLastVC];
        }
        if (complete) {
            dispatch_async(dispatch_get_main_queue(), ^{
                complete([NSDictionary dictionaryWithDictionary:muDic], lastVC);
            });
        }
        muDic = nil;
        return YES;
    }];
    
}

+ (void)addRouteForScheme:(NSString *)scheme routeName:(NSString *)name complete:(void (^)(NSDictionary<NSString *,id> * _Nullable, UIViewController * _Nonnull))complete {
    
    [[JLRoutes routesForScheme:scheme] addRoute:name handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:parameters];
        UIViewController *lastVC = parameters[kRouteParaLastVC];
        if (!lastVC) {
            lastVC = [ProjConfig currentVC];
        }else{
            [muDic removeObjectForKey:kRouteParaLastVC];
        }
        if (complete) {
            dispatch_async(dispatch_get_main_queue(), ^{
                complete([NSDictionary dictionaryWithDictionary:muDic], lastVC);
            });
        }
        muDic = nil;
        return YES;
    }];
    
}




@end
