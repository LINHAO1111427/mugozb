//
//  AgoraBase.m
//  AgoraExtension
//
//  Created by shirley on 2020/9/8.
//  Copyright © 2019 XTY. All rights reserved.
//

#import "AgoraBase.h"
#import <LibTools/LibTools.h>
#import "HttpSessionObj.h"

typedef void(^UserAgoraTokenBlock)(BOOL success, NSString *strMsg, NSString * _Nonnull token);

@interface AgoraBase ()<AgoraRtcEngineDelegate>

///音乐播放
@property (nonatomic, copy)void (^playHandle)(int, int) ;    //播放时间回调
@property (nonatomic, copy)void (^complete)(void) ;          //播放完成回调

@property (nonatomic, copy)void (^didJoinRoomBlock)(AgoraRtcEngineKit * _Nonnull) ;          //加入房间回调
@property (nonatomic, copy)void (^didLeaveRoomBlock)(AgoraRtcEngineKit * _Nonnull) ;          //离开房间回调

@property (nonatomic, copy)NSTimer *timer;

@property (nonatomic, copy)NSString *playMusicUrl;

@property (nonatomic, assign)int playMusicMixingDuration; ///音乐总时长

@end

@implementation AgoraBase

@synthesize userStatusBlock;
@synthesize netQualityStatusBlock;


#pragma mark - 初始化

- (void)dealloc
{
   // NSLog(@"过滤文字直播文件销毁"));
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
    }
    return self;
}

#pragma mark ----LivePubProtocol----

- (void)localVideoClosed:(BOOL)close{
    [AgoraManager.rtcEngine muteLocalVideoStream:close];
    [AgoraManager.rtcEngine enableLocalVideo:!close];
}

- (void)localAudioClosed:(BOOL)close{
    [AgoraManager.rtcEngine muteLocalAudioStream:close];
    [AgoraManager.rtcEngine enableLocalAudio:!close];
}

- (void)remoteVoiceClosed:(BOOL)close{
    [AgoraManager.rtcEngine muteAllRemoteAudioStreams:close];
}

- (void)remoteVideoClosed:(BOOL)close{
    [AgoraManager.rtcEngine muteAllRemoteVideoStreams:close];
}


#pragma mark ----播放音乐----
#pragma mark - LiveMusicProtocol
///实时回调音乐进度
- (void)musicSecondValueChange{
    
    int progress = [AgoraManager.rtcEngine getAudioMixingCurrentPosition];

    if (_playHandle) {
        _playHandle(progress, self.playMusicMixingDuration);
    }
   // NSLog(@"过滤文字=======音乐播放=====%d--------%d======="),progress, self.playMusicMixingDuration);
    if (progress > 0 && self.playMusicMixingDuration > 0) {
        if ((self.playMusicMixingDuration-progress<100) && _complete) {
            _complete();
            [self closeCurrentMusicInfo];
        }
    }
}

/** 开始播放音乐 */
- (void)playMusicForPath:(NSURL *)path progress:(void (^)(int, int))progress complete:(void (^)(void))complete {
    [_timer invalidate];
    _timer = nil;
    _playMusicUrl = path.absoluteString;
    [AgoraManager.rtcEngine getAudioFileInfo:_playMusicUrl];
    _playHandle = progress;
    _complete = complete;
    [AgoraManager.rtcEngine startAudioMixing:path.absoluteString loopback:NO replace:NO cycle:1 startPos:0];
}

/** 停止播放音乐 */
- (void)stopMusic{
    [self closeCurrentMusicInfo];
    [AgoraManager.rtcEngine stopAudioMixing];
}
///暂停
- (void)pauseMusic{
    [AgoraManager.rtcEngine pauseAudioMixing];
}
///恢复
- (void)resumeMusic{
    [AgoraManager.rtcEngine resumeAudioMixing];
}

/// 调整本地和远端音量
- (void)adjustAudioVolume:(NSInteger)value{
    [AgoraManager.rtcEngine adjustAudioMixingPlayoutVolume:value];
    [AgoraManager.rtcEngine adjustAudioMixingPublishVolume:value];
}
/// 播放一次音效文件,推到所有用户
- (int)playEffectFilePath:(NSString *)filePath soundId:(int)soundId{
    return [AgoraManager.rtcEngine playEffect:soundId filePath:filePath loopCount:1 pitch:1.0 pan:0 gain:100.0 publish:YES];
}


#pragma mark - privite

- (void)closeCurrentMusicInfo{
    [_timer invalidate];
    _timer = nil;
    _playHandle = nil;
    _complete = nil;
}


///加入房间
- (void)joinRoom:(int64_t)roomId didJoinSuccess:(void (^)(AgoraRtcEngineKit * _Nonnull))joinBlock {
    AgoraManager.roomID = roomId;
    self.didJoinRoomBlock = joinBlock;
    kWeakSelf(self);
    [self getOwnAgoraToken:^(BOOL success, NSString *strMsg, NSString * _Nonnull token) {
        NSString *reason = @"";
        if (success && token.length > 0) {
            int code = [AgoraManager.rtcEngine joinChannelByToken:token channelId:[NSString stringWithFormat:@"%lld",roomId] info:nil uid:(NSUInteger)AgoraManager.userID joinSuccess:nil];
            if (code == 0) {
                reason = kLocalizationMsg(@"成功");
            } else {
               // NSLog(@"过滤文字Join channel failed: %d"), code);
                reason = [NSString stringWithFormat:kLocalizationMsg(@"加入失败(%d)"),code];
            }
        }else{
            reason = [NSString stringWithFormat:kLocalizationMsg(@"获取token失败(%@)"),strMsg];
        }
        weakself.userStatusBlock?weakself.userStatusBlock(RTCForJoinedRoom,reason):nil;
    }];
}

///离开房间
- (void)leaveRoom:(int64_t)roomId didLeaveSuccess:(void (^ _Nullable)(AgoraRtcEngineKit * _Nonnull))leaveBlock{
    self.didLeaveRoomBlock = leaveBlock;
    AgoraManager.rtcEngine.delegate = nil;
    [AgoraManager.rtcEngine disableLastmileTest];//关闭监听网络
    int code = [AgoraManager.rtcEngine leaveChannel:nil];
    ///离开房间的回调
    if (AgoraManager.roomID > 0) {
        AgoraManager.roomID = roomId;
        self.userStatusBlock?self.userStatusBlock(RTCForLeaveRoom,[NSString stringWithFormat:kLocalizationMsg(@"离开状态(%d)"),code]):nil;
    }
}


#pragma mark - 接口 -
- (void)getOwnAgoraToken:(UserAgoraTokenBlock)tokenBlock {
    [self getRoomId:AgoraManager.roomID userId:AgoraManager.userID mediaRelayAgoraToken:tokenBlock];
}


- (void)getRoomId:(int64_t)roomId userId:(int64_t)uid mediaRelayAgoraToken:(UserAgoraTokenBlock)tokenBlock{
    [HttpSessionObj getRtcToken:[NSString stringWithFormat:@"%lld",roomId] userId:uid successBlock:^(BOOL success, NSDictionary * _Nonnull dic) {
        NSString *rtcToken = [dic[@"rtcToken"] isKindOfClass:[NSNull class]]?@"":dic[@"rtcToken"];
        tokenBlock?tokenBlock(success, dic[@"strMsg"], (rtcToken.length>0)?rtcToken:@""):nil;
    }];
}


- (void)getConnectRoomId:(int64_t)roomId mediaRelayToken:(void (^)(BOOL, NSString * _Nonnull, NSString * _Nonnull))tokenBlock{
    kWeakSelf(self);
    [self getRoomId:AgoraManager.roomID userId:0 mediaRelayAgoraToken:^(BOOL success, NSString *strMsg, NSString * _Nonnull token) {
        if (success && token.length > 0) {
            NSString *srcToken = token;
            [weakself getRoomId:roomId userId:AgoraManager.userID mediaRelayAgoraToken:^(BOOL success, NSString *strMsg, NSString * _Nonnull token) {
                if (success && token > 0) {
                    NSString *destToken = token;
                    tokenBlock?tokenBlock(YES,srcToken,destToken):nil;
                }else{
                    tokenBlock?tokenBlock(NO,@"",@""):nil;
                   // NSLog(@"过滤文字获取目标token失败"));
                }
            }];
        }else{
            tokenBlock?tokenBlock(NO,@"",@""):nil;
           // NSLog(@"过滤文字获取当前token失败"));
        }
    }];
}



#pragma mark - AgoraRtcEngineDelegate
/**
 *  网络质量检测回调
 *  "- (int)enableLastmileTest;"调用该方法开启
 *  @param quality 网络质量
 */
- (void)rtcEngine:(AgoraRtcEngineKit *)engine lastmileQuality:(AgoraNetworkQuality)quality{
    if (self.netQualityStatusBlock) {
        self.netQualityStatusBlock((quality > AgoraNetworkQualityPoor)?RTCForNetQualityBad:RTCForNetQualityGood);
    }
}

///已离开频道
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine didLeaveChannelWithStats:(AgoraChannelStats *_Nonnull)stats{
    [engine disableLastmileTest];
    self.didLeaveRoomBlock?self.didLeaveRoomBlock(engine):nil;
}

///已加入频道
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinChannel:(NSString *)channel withUid:(NSUInteger)uid elapsed:(NSInteger)elapsed{
    [engine enableLastmileTest];
    self.didJoinRoomBlock?self.didJoinRoomBlock(engine):nil;
}

///已重新加入频道
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didRejoinChannel:(NSString *)channel withUid:(NSUInteger)uid elapsed:(NSInteger)elapsed{
}

///发生错误回调
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine didOccurError:(AgoraErrorCode)errorCode{
   // NSLog(@"过滤文字errorCode==%lu"),(unsigned long)errorCode);
}
///警告回调
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine didOccurWarning:(AgoraWarningCode)warningCode{
   // NSLog(@"过滤文字warningCode==%lu"),(unsigned long)warningCode);
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine firstLocalVideoFrameWithSize:(CGSize)size elapsed:(NSInteger)elapsed {
   // NSLog(@"过滤文字%f==%f"),size.width,size.height);
}

///旁路推流设置被更新回调
-(void)rtcEngineTranscodingUpdated:(AgoraRtcEngineKit *)engine{
   // NSLog(@"过滤文字推流设置被更新回调"));
}

///RTMP 推流状态发生改变回调
-(void)rtcEngine:(AgoraRtcEngineKit *)engine rtmpStreamingChangedToState:(NSString *)url state:(AgoraRtmpStreamingState)state errorCode:(AgoraRtmpStreamingErrorCode)errorCode{
   // NSLog(@"过滤文字url==%@ state====%lu errorCode====%lu"),url,(unsigned long)state,(unsigned long)errorCode);
}


- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine streamPublishedWithUrl:(NSString *_Nonnull)url errorCode:(AgoraErrorCode)errorCode{
   // NSLog(@"过滤文字url==%@  errorCode====%lu"),url,(unsigned long)errorCode);
}


///跨频道媒体流转发事件回调
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine didReceiveChannelMediaRelayEvent:(AgoraChannelMediaRelayEvent)event{
   // NSLog(@"过滤文字跨频道媒体流转发事件回调 event====%lu"),(unsigned long)event);
    
}

///跨频道媒体流转发状态发生改变回调
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine channelMediaRelayStateDidChange:(AgoraChannelMediaRelayState)state error:(AgoraChannelMediaRelayError)error{
   // NSLog(@"过滤文字跨频道媒体流转发状态发生改变回调 state====%lu,error====%lu"),(unsigned long)state,(unsigned long)error);
}

///本地音乐文件播放状态改变
- (void)rtcEngine:(AgoraRtcEngineKit *)engine localAudioMixingStateDidChanged:(AgoraAudioMixingStateCode)state reason:(AgoraAudioMixingReasonCode)reason{
    
    switch (state) {
        case AgoraAudioMixingStatePlaying:  ///开始播放
        {
            if (!_timer && self.playMusicMixingDuration > 0) {
                _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(musicSecondValueChange) userInfo:nil repeats:YES];
                [self musicSecondValueChange];
            }
        }
            break;
        case AgoraAudioMixingStatePaused:  ///暂停播放
        {
            
        }
            break;
        case AgoraAudioMixingStateStopped:    ///播放停止
        {
            [self musicSecondValueChange];
        }
            break;
        case AgoraAudioMixingStateFailed:  ///播放错误
        {
            [self musicSecondValueChange];
        }
            break;
        default:
            break;
    }
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didRequestAudioFileInfo:(AgoraRtcAudioFileInfo *)info error:(AgoraAudioFileInfoError)error{
    if (!error) {
        self.playMusicMixingDuration = (int)info.durationMs;
    }else{
        
    }
}

///通话中本地音频流的统计信息回调
- (void)rtcEngine:(AgoraRtcEngineKit *)engine localAudioStats:(AgoraRtcLocalAudioStats *)stats{
}

///报告通话中远端音频流的统计信息
- (void)rtcEngine:(AgoraRtcEngineKit *)engine remoteAudioStats:(AgoraRtcRemoteAudioStats *)stats{
}

///Token 服务即将过期
- (void)rtcEngine:(AgoraRtcEngineKit *)engine tokenPrivilegeWillExpire:(NSString *)token{
    kWeakSelf(self);
    [self getOwnAgoraToken:^(BOOL success, NSString *strMsg, NSString * _Nonnull token) {
        NSString *reason = @"";
        if (success && token.length > 0) {
            int code = [engine renewToken:token];
            if (code == 0) {
                reason = kLocalizationMsg(@"成功");
            } else {
                reason = [NSString stringWithFormat:kLocalizationMsg(@"更新失败(%d)"),code];
            }
        }else{
            reason = [NSString stringWithFormat:kLocalizationMsg(@"获取token失败(%@)"),strMsg];
        }
        weakself.userStatusBlock?weakself.userStatusBlock(RTCForUpdateToken,reason):nil;
    }];
}

///Token 已过期
- (void)rtcEngineRequestToken:(AgoraRtcEngineKit *)engine{
    kWeakSelf(self);
    [self getOwnAgoraToken:^(BOOL success, NSString *strMsg, NSString * _Nonnull token) {
        NSString *reason = @"";
        if (success && token.length > 0) {
            int code = [engine renewToken:token];
            if (code == 0) {
                reason = kLocalizationMsg(@"成功");
            } else {
                reason = [NSString stringWithFormat:kLocalizationMsg(@"更新失败(%d)"),code];
            }
        }else{
            reason = [NSString stringWithFormat:kLocalizationMsg(@"获取token失败(%@)"),strMsg];
        }
        weakself.userStatusBlock?weakself.userStatusBlock(RTCForUpdateToken,reason):nil;
    }];
}

@end
