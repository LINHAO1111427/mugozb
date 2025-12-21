//
//  DemoRouteRegister.m
//  TCDemo
//
//  Created by admin on 2019/9/17.
//  Copyright © 2019 CH. All rights reserved.
//

#import "DemoRouteRegister.h"
#import "AppDelegate.h"
#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/RouteManager.h>

#import <MPVideoLive/MPVideoLiveController.h>
#import <MPAudioLive/MPAudioLiveController.h>

#import "ComponentConfig.h"

#import <KLCProjConfig/RouteBaseObj.h>
#import <DynamicCircle/DynamicRoute.h>
#import <ShortVideo/ShortVideoRoute.h>
#import <Shopping/ShoppingRoute.h>>
#import <Ranking/RankingRoute.h>
#import <MessageInfo/MessageRoute.h>
#import <ALVideoRecord/ALVideoRecord.h>

@implementation DemoRouteRegister


+ (void)registerRoute{
    
    [RouteManager addRouteForName:RN_login_welcome complete:^(NSDictionary<NSString *,id> * _Nullable parameters, UIViewController * _Nonnull lastVC) {
        [[AppDelegate app] isLoginRoot:YES];
    }];
    
    [self registerLiveRoute];
    
    [ShoppingRoute registeRoute];
    [RouteBaseObj registerBase];
    [RouteBaseObj registerMPLive];

    [DynamicRoute registeRoute];
    [ShortVideoRoute registeRoute];
    [AlVideoRcordRoute registeRoute];
    [RankingRoute registeRoute];
    
    [MessageRoute registeRoute];
}


#pragma mark   - 直播注册 -

+ (void)registerLiveRoute{
    ///创建多人直播间
    [RouteManager addRouteForName:RN_live_liveForAnchorVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        MPVideoLiveController *mpLive = [[MPVideoLiveController alloc] initWithIsAnchor:YES];
        mpLive.compClass = ComponentConfig.class;
        mpLive.openData = parameters[@"openData"];
        return mpLive;
    }];
    ///进入多人直播间
    [RouteManager addRouteForName:RN_live_liveForAudienceVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        MPVideoLiveController *mpLive = [[MPVideoLiveController alloc] initWithIsAnchor:NO];
        mpLive.compClass = ComponentConfig.class;
        mpLive.roomModel = parameters[@"model"];
        return mpLive;
    }];
    
    
    /// 创建语音房间
    [RouteManager addRouteForName:RN_live_audioForAnchorVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        MPAudioLiveController *audioForAnchorVC = [[MPAudioLiveController alloc] initWithIsAnchor:YES];
        audioForAnchorVC.compClass = ComponentConfig.class;
        audioForAnchorVC.openData = parameters[@"openData"];
        return audioForAnchorVC;
        
    }];
    
    /// 进入语音房间
    [RouteManager addRouteForName:RN_live_audioForAudienceVC handle:^UIViewController * _Nonnull(NSDictionary<NSString *,id> * _Nullable parameters) {
        MPAudioLiveController *audienceVC = [[MPAudioLiveController alloc] initWithIsAnchor:NO];
        audienceVC.compClass = ComponentConfig.class;
        audienceVC.roomModel = parameters[@"model"];
        return audienceVC;
    }];
}


@end
