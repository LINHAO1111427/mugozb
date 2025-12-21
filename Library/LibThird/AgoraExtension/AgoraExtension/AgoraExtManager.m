//
//  AgoraExtManager.m
//  AgoraExtension
//
//  Created by shirley on 2020/5/16.
//  Copyright © 2020 . All rights reserved.
//

#import "AgoraExtManager.h"
#import "AgoraManagerConfig.h"
#import <AVFoundation/AVFoundation.h>
#import "AgoraRtcManager.h"
#import "AgoraO2OVideo.h"
#import "AgoraMPAudio.h"
#import "AgoraMPVideo.h"
 

static AgoraExtManager *_manager = nil;
static Class<AgoraManagerConfig> _managerConfig;
 
@interface AgoraExtManager ()

@property (nonatomic, strong)id<MPVideoProtocol> mpVideoObj;
@property (nonatomic, strong)id<MPAudioProtocol> mpAudioObj;
@property (nonatomic, strong)id<O2OVideoProtocol> o2oVideoObj;
@property (nonatomic, strong)id<LivePubProtocol,LiveMusicProtocol> pubOBj;

@end

@implementation AgoraExtManager


- (void)dealloc
{
   // NSLog(@"过滤文字直播文件销毁:%s"),__func__);
    _mpVideoObj = nil;
    _mpAudioObj = nil;
    _pubOBj = nil;
    _manager = nil;
}

+ (AgoraExtManager *)manager{
    if (_manager == nil) {
        _manager = [[AgoraExtManager alloc] init];
    }
    return _manager;
}


+ (void)setConfig:(Class<AgoraManagerConfig>)config{
    _managerConfig = config;
    
    [AgoraExtManager initKey];
}


+ (void)initKey{
    if ([AgoraExtManager checkConfig]) {
        [AgoraRtcManager setAgoraLiveKey:[_managerConfig getLiveKey] userId:[_managerConfig getUserId]];
         
    }
}


- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


- (void)tokenInvalid{
    [AgoraExtManager disconnect];
}

+ (void)disconnect{
    _manager.mpAudioObj = nil;
    _manager.pubOBj = nil;
    _manager = nil;
}


#pragma mark - 每个独立的功能
///音乐管理
+ (id<LiveMusicProtocol>)music{
    return [AgoraExtManager manager].pubOBj;
}

///公共方法管理
+ (id<LivePubProtocol>)pubMethod{
    return [AgoraExtManager manager].pubOBj;
}
///一对一视频管理
+ (id<O2OVideoProtocol>)otoVideo{
    return [AgoraExtManager manager].o2oVideoObj;
}
///多人直播管理
+ (id<MPVideoProtocol>)mpVideo{
    return [AgoraExtManager manager].mpVideoObj;
}

+ (id<MPAudioProtocol>)mpAudio{
    return [AgoraExtManager manager].mpAudioObj;
}



///一对一视频
- (id<O2OVideoProtocol>)o2oVideoObj{
    if (!_o2oVideoObj) {
        AgoraO2OVideo<O2OVideoProtocol,LivePubProtocol,LiveMusicProtocol> *o2o = [AgoraO2OVideo registerObj];
        self.pubOBj = o2o;
        _o2oVideoObj = o2o;
        AgoraManager.beautyCls = [self getBeautyClass];
    }
    return _o2oVideoObj;
}


///多人直播
- (id<MPVideoProtocol>)mpVideoObj{
    if (!_mpVideoObj) {
        AgoraMPVideo<MPVideoProtocol,LivePubProtocol,LiveMusicProtocol> *mpV = [AgoraMPVideo registerObj];
        self.pubOBj = mpV;
        _mpVideoObj = mpV;
        [AgoraRtcManager setUrlForCDN:[_managerConfig getCDNLiveKey]];
        AgoraManager.beautyCls = [self getBeautyClass];
    }
    return _mpVideoObj;
}

///多人语音
- (id<MPAudioProtocol>)mpAudioObj{
    if (!_mpAudioObj) {
        AgoraMPAudio<MPAudioProtocol,LivePubProtocol,LiveMusicProtocol> *mpA = [AgoraMPAudio registerObj];
        self.pubOBj = mpA;
        _mpAudioObj = mpA;
    }
    return _mpAudioObj;
}


- (void)setPubOBj:(id<LivePubProtocol,LiveMusicProtocol,MPVideoProtocol>)pubOBj{
    if (!_pubOBj && pubOBj) {
        _pubOBj = pubOBj;
        if ([AgoraExtManager checkConfig]) {
            [AgoraRtcManager setAgoraLiveKey:[_managerConfig getLiveKey] userId:[_managerConfig getUserId]];
            AgoraManager.imageQualityNum = [_managerConfig getImageQualityNum];
        }
        
    }
}

+ (BOOL)checkConfig{
    if (_managerConfig) {
        return YES;
    }else{
       // NSLog(@"过滤文字文件配置错误，请检查配置文件"));
        return NO;
    }
}


- (Class<LiveBeautyProtocol>)getBeautyClass{
    if ([AgoraExtManager checkConfig]) {
        if ([_managerConfig getBeautySwitch] == 1) {  ///开启美颜
            if ([_managerConfig respondsToSelector:@selector(getBeautyObj)]) {
                Class<LiveBeautyProtocol> cls = [_managerConfig getBeautyObj];
                
                return cls;
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

@end
