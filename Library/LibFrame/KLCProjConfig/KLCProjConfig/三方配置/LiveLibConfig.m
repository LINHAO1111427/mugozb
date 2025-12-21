//
//  LiveLibConfig.m
//  klcVoice
//
//  Created by klc_sl on 2020/4/17.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveLibConfig.h"
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LibTools.h>
#import <AgoraExtension/AgoraManagerConfig.h>
#import <AgoraExtension/AgoraExtManager.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/CfgLiveKeyModel.h>

@interface LiveLibConfig () <AgoraManagerConfig>

@end

@implementation LiveLibConfig

+ (int)getImageQualityNum{
    return [KLCAppConfig appConfig].imageQuality;
}

+ (NSString *)getBeautyKey{
    return [KLCAppConfig appConfig].liveKey.beautyKey;
}

+ (int64_t)getUserId{
    return [ProjConfig userId];
}

+ (NSString *)baseUrl{
    return [ProjConfig baseUrl];
}

+ (NSString *)userToken{
    return [ProjConfig userToken];
}

+ (NSString *)getCDNLiveKey{
    return [KLCAppConfig appConfig].liveKey.cdnCfgKey;
}

+ (NSString *)getLiveKey{
    return [KLCAppConfig appConfig].liveKey.liveAppid;
}

+ (int)getBeautySwitch{
    return [KLCAppConfig appConfig].liveKey.beautySwitch;
}

///配置
+ (void)rtcConfig{
    [AgoraExtManager setConfig:self.class];
}

///获取美颜文件
+ (Class<LiveBeautyProtocol>)getBeautyObj{
    return [[ProjConfig shareInstence].baseConfig getBeautyViewClass];
}
@end
