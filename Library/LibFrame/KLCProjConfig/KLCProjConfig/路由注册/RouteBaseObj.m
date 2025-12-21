//
//  RouteBaseObj.m
//  KLCProjConfig
//
//  Created by klc_sl on 2020/8/31.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "RouteBaseObj.h"
#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/KLCNavgationContoller.h>

#import <UserInfo/UserInfoRoute.h>
#import <MineCenter/MineCenterRoute.h>
#import <Login/LoginRoute.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/CustomerServiceSettingModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>

@implementation RouteBaseObj

+ (void)registerBase{
    
    ///用户信息
    [UserInfoRoute registeRoute];
    
    ///个人中心
    [MineCenterRoute registeRoute];
    
    ///登录
    [LoginRoute registeRoute];
    
    
    ///web
    [RouteManager addRouteForName:RN_general_webView handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        UIViewController *webVC = [[NSClassFromString(@"KLCWebViewController") alloc] init];
        [webVC setValue:parameters[@"url"] forKey:@"url"];
        return webVC;
    }];

    
    ///贵族VIP中心：
    [RouteManager addRouteForName:RN_User_buyVIP handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        NSString *strUrl = @"/pub/h5page/index.html#/noblePrivilege";
        UIViewController *webVC = [[NSClassFromString(@"KLCWebViewController") alloc] init];
        [webVC setValue:strUrl forKey:@"url"];
        return webVC;
    }];
    
    //1v1 美颜设置
    [RouteManager addRouteForName:RN_activity_setUpBeautyAC vcClass:NSClassFromString(@"SetUpBeautyVC")];
    
    ///申诉
    [RouteManager addRouteForName:RN_Base_BannedTheAppeal complete:^(NSDictionary<NSString *,id> * _Nullable parameters, UIViewController * _Nonnull lastVC) {
        
        if ([KLCAppConfig appConfig].adminLiveConfig.showOnlineService) {
            [RouteManager routeForName:RN_center_setting_onLineService currentC:lastVC];
        }else{
            NSString *complaintTelephone = [KLCAppConfig appConfig].customerServiceSetting.complaintTelephone;
            if (complaintTelephone.length > 0) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",complaintTelephone]]];
            }else{
                
            }
        }
        
    }];
}




+ (void)registerMPLive{
    
    ///直播关闭页面
    [RouteManager addRouteForName:RN_live_liveCloseVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        UIViewController *restInfo = [[NSClassFromString(@"LiveRestInfoVC") alloc] init];
        [restInfo setValue:parameters[@"model"] forKey:@"dtoModel"];
        [restInfo setValue:parameters[@"liveType"] forKey:@"liveType"];
        return restInfo;
    }];
    
    ///    主播协议：
    [RouteManager addRouteForName:RN_center_setting_anchorProtocol handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        NSString *strUrl = @"/api/login/appSite?type=5";
        UIViewController *webVC = [[NSClassFromString(@"KLCWebViewController") alloc] init];
        [webVC setValue:strUrl forKey:@"url"];
        return webVC;
    }];
    
    //直播数据
    [RouteManager addRouteForName:RN_activity_LiveBroadcastDataAC vcClass:NSClassFromString(@"LiveBroadcastDataVC")];
    
}


@end
