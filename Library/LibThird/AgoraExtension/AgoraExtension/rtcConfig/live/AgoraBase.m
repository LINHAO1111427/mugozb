//
//  AgoraBase.m
//  AgoraExtension
//
//  Created by shirley on 2020/9/8.
//  Copyright ? 2019 XTY. All rights reserved.
//

#import "AgoraBase.h"
#import <LibTools/LibTools.h>
#import "HttpSessionObj.h"

typedef void(^UserAgoraTokenBlock)(BOOL success, NSString *strMsg, NSString * _Nonnull token);

@interface AgoraBase ()<ByteRTCEngineDelegate>

@property (nonatomic, copy) void (^playHandle)(int, int);
@property (nonatomic, copy) void (^complete)(void);

@property (nonatomic, copy) void (^didJoinRoomBlock)(ByteRTCEngineKit * _Nonnull);
@property (nonatomic, copy) void (^didLeaveRoomBlock)(ByteRTCEngineKit * _Nonnull);

@property (nonatomic, copy) NSTimer *timer;
@property (nonatomic, copy) NSString *playMusicUrl;
@property (nonatomic, assign) int playMusicMixingDuration;
@property (nonatomic, assign) int mixingId;

@end

@implementation AgoraBase

@synthesize userStatusBlock;
@synthesize netQualityStatusBlock;

#pragma mark - Lifecycle
- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;
    [self closeCurrentMusicInfo];
    AgoraManager.rtcEngine.delegate = nil;
    [AgoraManager destroy];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mixingId = 0;
    }
    return self;
}

#pragma mark ---- LivePubProtocol ----

- (void)localVideoClosed:(BOOL)close{
    [AgoraManager.rtcEngine muteLocalVideo:close ? ByteRTCMuteStateOn : ByteRTCMuteStateOff];
    if (close) {
        [AgoraManager.rtcEngine stopVideoCapture];
    } else {
        [AgoraManager.rtcEngine startVideoCapture];
    }
}

- (void)localAudioClosed:(BOOL)close{
    [AgoraManager.rtcEngine muteLocalAudio:close ? ByteRTCMuteStateOn : ByteRTCMuteStateOff];
    if (close) {
        [AgoraManager.rtcEngine stopAudioCapture];
    } else {
        [AgoraManager.rtcEngine startAudioCapture];
    }
}

- (void)remoteVoiceClosed:(BOOL)close{
    [AgoraManager.rtcEngine muteAllRemoteAudio:close ? ByteRTCMuteStateOn : ByteRTCMuteStateOff];
}

- (void)remoteVideoClosed:(BOOL)close{
    [AgoraManager.rtcEngine muteAllRemoteVideo:close ? ByteRTCMuteStateOn : ByteRTCMuteStateOff];
}

#pragma mark ---- LiveMusicProtocol ----

- (void)musicSecondValueChange{
    ByteRTCAudioMixingManager *manager = [AgoraManager.rtcEngine getAudioMixingManager];
    if (!manager) {
        return;
    }

    int progress = [manager getAudioMixingCurrentPosition:self.mixingId];
    if (_playHandle) {
        _playHandle(progress, self.playMusicMixingDuration);
    }

    if (progress > 0 && self.playMusicMixingDuration > 0) {
        if ((self.playMusicMixingDuration - progress < 100) && _complete) {
            _complete();
            [self closeCurrentMusicInfo];
        }
    }
}

- (void)playMusicForPath:(NSURL *)path progress:(void (^)(int, int))progress complete:(void (^)(void))complete {
    [_timer invalidate];
    _timer = nil;

    _playMusicUrl = path.absoluteString;
    _playHandle = progress;
    _complete = complete;

    ByteRTCAudioMixingManager *manager = [AgoraManager.rtcEngine getAudioMixingManager];
    if (!manager) {
        return;
    }

    ByteRTCAudioMixingConfig *config = [[ByteRTCAudioMixingConfig alloc] init];
    config.type = ByteRTCAudioMixingTypePlayoutAndPublish;
    config.playCount = 1;
    config.position = 0;
    [manager startAudioMixing:self.mixingId filePath:_playMusicUrl config:config];

    int duration = [manager getAudioMixingDuration:self.mixingId];
    self.playMusicMixingDuration = duration > 0 ? duration : 0;
}

- (void)stopMusic{
    [self closeCurrentMusicInfo];
    ByteRTCAudioMixingManager *manager = [AgoraManager.rtcEngine getAudioMixingManager];
    [manager stopAudioMixing:self.mixingId];
}

- (void)pauseMusic{
    ByteRTCAudioMixingManager *manager = [AgoraManager.rtcEngine getAudioMixingManager];
    [manager pauseAudioMixing:self.mixingId];
}

- (void)resumeMusic{
    ByteRTCAudioMixingManager *manager = [AgoraManager.rtcEngine getAudioMixingManager];
    [manager resumeAudioMixing:self.mixingId];
}

- (void)adjustAudioVolume:(NSInteger)value{
    ByteRTCAudioMixingManager *manager = [AgoraManager.rtcEngine getAudioMixingManager];
    [manager setAudioMixingVolume:self.mixingId volume:(int)value type:ByteRTCAudioMixingTypePlayout];
    [manager setAudioMixingVolume:self.mixingId volume:(int)value type:ByteRTCAudioMixingTypePublish];
}

- (int)playEffectFilePath:(NSString *)filePath soundId:(int)soundId{
    return [AgoraManager.rtcEngine playEffect:soundId
                                     filePath:filePath
                                     loopback:NO
                                        cycle:1
                                   withVolume:100];
}

#pragma mark - Private

- (void)closeCurrentMusicInfo{
    [_timer invalidate];
    _timer = nil;
    _playHandle = nil;
    _complete = nil;
}

- (void)joinRoom:(int64_t)roomId didJoinSuccess:(void (^)(ByteRTCEngineKit * _Nonnull))joinBlock {
    AgoraManager.roomID = roomId;
    self.didJoinRoomBlock = joinBlock;

    kWeakSelf(self);
    [self getOwnAgoraToken:^(BOOL success, NSString *strMsg, NSString * _Nonnull token) {
        NSString *reason = @"";
        if (success && token.length > 0) {
            ByteRTCUserInfo *userInfo = [[ByteRTCUserInfo alloc] init];
            userInfo.userId = [NSString stringWithFormat:@"%lld", AgoraManager.userID];
            userInfo.extraInfo = @"";

            ByteRTCRoomConfig *roomConfig = [[ByteRTCRoomConfig alloc] init];
            roomConfig.profile = self.channelProfile;
            roomConfig.isAutoPublish = (self.clientRole == ByteRTCUserRoleTypeBroadcaster);
            roomConfig.isAutoSubscribeAudio = YES;
            roomConfig.isAutoSubscribeVideo = YES;

            int code = [AgoraManager.rtcEngine joinRoomByKey:token
                                                     roomId:[NSString stringWithFormat:@"%lld", roomId]
                                                   userInfo:userInfo
                                             rtcRoomConfig:roomConfig];
            if (code == 0) {
                reason = kLocalizationMsg(@"成功");
            } else {
                reason = [NSString stringWithFormat:kLocalizationMsg(@"加入失败(%d)"), code];
            }
        } else {
            reason = [NSString stringWithFormat:kLocalizationMsg(@"获取token失败(%@)"), strMsg];
        }
        weakself.userStatusBlock ? weakself.userStatusBlock(RTCForJoinedRoom, reason) : nil;
    }];
}

- (void)leaveRoom:(int64_t)roomId didLeaveSuccess:(void (^ _Nullable)(ByteRTCEngineKit * _Nonnull))leaveBlock{
    self.didLeaveRoomBlock = leaveBlock;
    AgoraManager.rtcEngine.delegate = nil;

    int code = [AgoraManager.rtcEngine leaveRoom];
    if (AgoraManager.roomID > 0) {
        AgoraManager.roomID = roomId;
        self.userStatusBlock ? self.userStatusBlock(RTCForLeaveRoom, [NSString stringWithFormat:kLocalizationMsg(@"离开状态(%d)"), code]) : nil;
    }
}

#pragma mark - Token

- (void)getOwnAgoraToken:(UserAgoraTokenBlock)tokenBlock {
    [self getRoomId:AgoraManager.roomID userId:AgoraManager.userID mediaRelayAgoraToken:tokenBlock];
}

- (void)getRoomId:(int64_t)roomId userId:(int64_t)uid mediaRelayAgoraToken:(UserAgoraTokenBlock)tokenBlock{
    [HttpSessionObj getRtcToken:[NSString stringWithFormat:@"%lld",roomId] userId:uid successBlock:^(BOOL success, NSDictionary * _Nonnull dic) {
        NSString *rtcToken = [dic[@"rtcToken"] isKindOfClass:[NSNull class]] ? @"" : dic[@"rtcToken"];
        tokenBlock ? tokenBlock(success, dic[@"strMsg"], (rtcToken.length > 0) ? rtcToken : @"") : nil;
    }];
}

- (void)getConnectRoomId:(int64_t)roomId mediaRelayToken:(void (^)(BOOL, NSString * _Nonnull, NSString * _Nonnull))tokenBlock{
    kWeakSelf(self);
    [self getRoomId:AgoraManager.roomID userId:0 mediaRelayAgoraToken:^(BOOL success, NSString *strMsg, NSString * _Nonnull token) {
        if (success && token.length > 0) {
            NSString *srcToken = token;
            [weakself getRoomId:roomId userId:AgoraManager.userID mediaRelayAgoraToken:^(BOOL success, NSString *strMsg, NSString * _Nonnull token) {
                if (success && token.length > 0) {
                    NSString *destToken = token;
                    tokenBlock ? tokenBlock(YES, srcToken, destToken) : nil;
                } else {
                    tokenBlock ? tokenBlock(NO, @"", @"") : nil;
                }
            }];
        } else {
            tokenBlock ? tokenBlock(NO, @"", @"") : nil;
        }
    }];
}

#pragma mark - ByteRTCEngineDelegate

- (void)rtcEngine:(ByteRTCEngineKit *_Nonnull)engine onNetworkQuality:(ByteRTCNetworkQualityStats *)localQuality remoteQualities:(NSArray<ByteRTCNetworkQualityStats*> *)remoteQualities{
    ByteRTCNetworkQuality quality = MAX(localQuality.txQuality, localQuality.rxQuality);
    if (self.netQualityStatusBlock) {
        self.netQualityStatusBlock((quality >= ByteRTCNetworkQualityPoor) ? RTCForNetQualityBad : RTCForNetQualityGood);
    }
}

- (void)rtcEngine:(ByteRTCEngineKit *_Nonnull)engine onLeaveRoomWithStats:(ByteRTCRoomStats *_Nonnull)stats{
    self.didLeaveRoomBlock ? self.didLeaveRoomBlock(engine) : nil;
}

- (void)rtcEngine:(ByteRTCEngineKit *_Nonnull)engine onRoomStateChanged:(NSString *_Nonnull)roomId withUid:(nonnull NSString *)uid state:(NSInteger)state extraInfo:(NSString *_Nonnull)extraInfo{
    if (state == 0) {
        self.didJoinRoomBlock ? self.didJoinRoomBlock(engine) : nil;
    }
}

- (void)rtcEngine:(ByteRTCEngineKit * _Nonnull)engine onAudioMixingStateChanged:(NSInteger)mixId state:(ByteRTCAudioMixingState)state error:(ByteRTCAudioMixingError)error {
    switch (state) {
        case ByteRTCAudioMixingStatePlaying:
        {
            if (!_timer && self.playMusicMixingDuration > 0) {
                _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(musicSecondValueChange) userInfo:nil repeats:YES];
                [self musicSecondValueChange];
            }
        }
            break;
        case ByteRTCAudioMixingStateStopped:
        case ByteRTCAudioMixingStateFailed:
        case ByteRTCAudioMixingStateFinished:
        {
            [self musicSecondValueChange];
        }
            break;
        case ByteRTCAudioMixingStatePaused:
        default:
            break;
    }
}

- (void)onTokenWillExpire:(ByteRTCEngineKit * _Nonnull)engine {
    kWeakSelf(self);
    [self getOwnAgoraToken:^(BOOL success, NSString *strMsg, NSString * _Nonnull token) {
        NSString *reason = @"";
        if (success && token.length > 0) {
            int code = [engine updateToken:token];
            if (code == 0) {
                reason = kLocalizationMsg(@"成功");
            } else {
                reason = [NSString stringWithFormat:kLocalizationMsg(@"更新失败(%d)"), code];
            }
        } else {
            reason = [NSString stringWithFormat:kLocalizationMsg(@"获取token失败(%@)"), strMsg];
        }
        weakself.userStatusBlock ? weakself.userStatusBlock(RTCForUpdateToken, reason) : nil;
    }];
}

@end


