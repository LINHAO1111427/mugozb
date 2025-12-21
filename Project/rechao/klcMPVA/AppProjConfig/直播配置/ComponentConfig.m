//
//  ComponentConfig.m
//  TCDemo
//
//  Created by ggm on 2019/9/27.
//  Copyright © 2019 CH. All rights reserved.
//

#import "ComponentConfig.h"

#import <MPVideoLive/LiveVideoComponent.h>
#import <MPVideoLive/AudienceVideoComponent.h>
#import <MPVideoLive/AnchorPKComponent.h>
#import <MPVideoLive/AnchorInteractiveComponent.h>
#import <MPVideoLive/LiveMicComponent.h>

#import <MPCommon/MPLiveInfoComponent.h>
#import <MPCommon/CloseMPLiveComponent.h>
#import <MPCommon/OpenMPLiveComponent.h>
#import <MPCommon/LiveMessageComponent.h>
#import <MPCommon/HandleOtherComponent.h>
#import <MPCommon/UserMsgComponent.h>
#import <MPCommon/RedPacketCompnent.h>

#import <LiveCommon/LiveGiftComponent.h>
#import <LiveCommon/LiveMusicComponent.h>
#import <LiveCommon/UserInfoComponent.h>
#import <LiveCommon/LiveWishComponent.h>

#import <LiveCommon/PublicLiveComponent.h>
#import <LiveCommon/LiveGameComponent.h>

#import <MPAudioLive/AudioMicSeatsComponent.h>
#import <MPAudioLive/AudioManagerComponent.h>
#import <MPAudioLive/ChatPKComponent.h>
#import <MPAudioLive/ConnectMicComponent.h>
#import <MPAudioLive/PresenterComponent.h>

#import <Shopping/ShoppingComponent.h>

#import "MPVideoConfig.h"
#import "MPAudioConfig.h"

@implementation ComponentConfig

///获得多人直播view的class
+ (Class<MPLiveInterface>)getMpVideoViewClass{
    return MPVideoConfig.class;
}

///获得多人语音view的class
+ (Class<MPLiveInterface>)getMpAudioViewClass{
    return MPAudioConfig.class;
}

+ (NSArray<Class> *)getAnchorAudioComptClass{
    return @[
        OpenMPLiveComponent.class, //  开播组建
        CloseMPLiveComponent.class,      // 关播组件
        MPLiveInfoComponent.class,  ///直播信息组建
        AudioManagerComponent.class, // 语音组件
        LiveMessageComponent.class, // 消息组件 消息组件一定要在直播信息组件后面
        UserInfoComponent.class,    //用户信息组件
        AudioMicSeatsComponent.class, // 麦位组件
        ChatPKComponent.class,   // 语音pk组件
        ConnectMicComponent.class,   // 连麦组件
        LiveGiftComponent.class,      // 礼物组件
        HandleOtherComponent.class,  //处理其他组件
        LiveMusicComponent.class,   ///音乐组件
        LiveWishComponent.class,   // 心愿单

        UserMsgComponent.class, // 用户消息组件（暂时只有靓号）
        LiveGameComponent.class, // 游戏组件
        RedPacketCompnent.class, // 红包
        PresenterComponent.class, ///主持人
        PublicLiveComponent.class,  ///公共消息组件
    ];
}

+ (NSArray<Class> *)getAudienceAudioComptClass{
    return @[
        CloseMPLiveComponent.class,      // 关播组件
        AudioManagerComponent.class, // 语音组件
        LiveMessageComponent.class, // 消息组件 消息组件一定要在直播信息组件后面
        UserInfoComponent.class,    //用户信息组件
        MPLiveInfoComponent.class,  ///直播信息组建
        AudioMicSeatsComponent.class, // 麦位组件
        ChatPKComponent.class,   // 语音pk组件
        ConnectMicComponent.class,   // 连麦组件
        LiveGiftComponent.class,      // 礼物组件
        HandleOtherComponent.class,  //处理其他组件
        LiveMusicComponent.class,   ///音乐组件
        LiveWishComponent.class,   // 心愿单
        PresenterComponent.class, ///主持人

        UserMsgComponent.class, // 用户消息组件（暂时只有靓号）
        LiveGameComponent.class, // 游戏组件
        RedPacketCompnent.class, // 红包
        
        PublicLiveComponent.class,  ///公共消息组件
    ];
}


+ (NSArray<Class> *)getAnchorVideoComptClass{
    return @[
        LiveVideoComponent.class,   //  直播视频组件
        OpenMPLiveComponent.class, //  开播组建
        MPLiveInfoComponent.class,    //  直播信息组件
        LiveMessageComponent.class, //  直播消息组件

        AnchorPKComponent.class,    // PK 组件
        CloseMPLiveComponent.class,      // 关播组件
        AnchorInteractiveComponent.class, // 互动组件
        LiveMicComponent.class,       // 连麦组件
        LiveMusicComponent.class,      // 音乐组件
        LiveGiftComponent.class,      // 礼物组件
        UserInfoComponent.class,    //用户信息组件
        HandleOtherComponent.class,  //处理其他组件

        LiveWishComponent.class,   // 心愿单
        ShoppingComponent.class, //直播购
        UserMsgComponent.class, // 用户消息组件（暂时只有靓号）
        LiveGameComponent.class, // 游戏组件
        RedPacketCompnent.class, // 红包
        
        PublicLiveComponent.class,  ///公共消息组件
    ];
}

+ (NSArray<Class> *)getAudienceVideoComptClass{
    return @[
        AudienceVideoComponent.class,       // 观众播放组件
        MPLiveInfoComponent.class,    // 直播信息组件
        LiveMessageComponent.class,    // 直播消息组件
        AnchorInteractiveComponent.class,     // 互动组件
        AnchorPKComponent.class,    // PK 组件
        LiveMicComponent.class,       // 连麦组件
        CloseMPLiveComponent.class,  // 关播组件
        LiveGiftComponent.class,      // 礼物组件
        UserInfoComponent.class,    //用户信息组件
        
        HandleOtherComponent.class,  //处理其他组件
        LiveWishComponent.class,   // 心愿单

        UserMsgComponent.class, // 用户消息组件（暂时只有靓号）
        LiveGameComponent.class, // 游戏组件
        RedPacketCompnent.class, // 红包
        
        PublicLiveComponent.class,  ///公共消息组件
    ];
}


@end
