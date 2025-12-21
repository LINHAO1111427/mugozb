//
//  CloudConfig.m
//  youMengLive
//
//  Created by klc_sl on 2020/7/22.
//  Copyright © 2020 . All rights reserved.
//

#import "CloudConfig.h"
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/CfgLiveKeyModel.h>
#import <XTMediaKit/XTMediaManager.h>
#import <XTMediaKit/XTCameraTool.h>

#import <LibProjBase/HttpClient.h>
#import <LibProjBase/LibProjBase.h>

@implementation CloudConfig

+ (BOOL)isUploadService{
    if ([[ProjConfig shareInstence].baseConfig respondsToSelector:@selector(otherUploadFileType)]) {
        return YES;
    }else{
        return NO;
    }
}


+ (void)mediaConfig{
    [XTMediaManager setConfig:CloudConfig.class];
}

///基础地址
+ (NSString *)baseUrl{
    return [ProjConfig baseUrl];
}

///用户ID
+ (int64_t)userId{
    return [ProjConfig userId];
}

///用户token
+ (NSString *)userToken{
    return [ProjConfig userToken];
}


///获得记录key
+ (NSString *)getRecordKey{
    return [KLCAppConfig appConfig].liveKey.videoClipsKey;
}


@end
