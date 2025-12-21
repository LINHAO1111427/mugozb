//
//  AgoraMPAudio.m
//  AgoraExtension
//
//  Created by kalacheng on 2020/6/9.
//  Copyright © 2020 kalacheng. All rights reserved.
//

#import "AgoraMPAudio.h"
#import <LibTools/LibTools.h>

@interface AgoraMPAudio ()<AgoraRtcEngineDelegate>

@property (nonatomic, copy)void (^voiceBlock)(NSUInteger num, int64_t uid) ;         //用户说话音量回调


@property (nonatomic, assign) int64_t anchorId; ///主播ID
@property (nonatomic, copy)void (^anchorVolumeBlock)(NSUInteger num) ;         //单个说话音量回调

@property (nonatomic, assign) int64_t otherRoomId;          //副播的房间id    (前提：房间id = 直播id)

@property (nonatomic, assign) int64_t userId;  ///自己的uid


@end

@implementation AgoraMPAudio

- (void)dealloc{
    
   // NSLog(@"过滤文字多人语音文件销毁"));
    [self leaveRoom];
    AgoraManager.rtcEngine.delegate = nil;
    [AgoraManager destroy];
    
}


#pragma mark  - LivePubProtocol -
+ (instancetype)registerObj{
    return [[AgoraMPAudio alloc] init];
}


/// 初始化语音三体云
- (void)initMPAudioRole:(int)role{
    self.clientRole = (role == 3)?AgoraClientRoleAudience:AgoraClientRoleBroadcaster;
    ///语音不需要推流
    if (role == 1) {
    } else if (role == 2) {
    } else{
    }
    [AgoraManager setVoiceAgoraBase:AgoraChannelProfileLiveBroadcasting];
    [AgoraManager.rtcEngine setClientRole:role];
    [AgoraManager.rtcEngine disableVideo];
    AgoraManager.rtcEngine.delegate = self;
    _userId = AgoraManager.userID;
}


/// 创建加入房间
- (void)joinRoom:(int64_t)roomId{
    if (roomId == 0) {
        return;
    }
    [self joinRoom:roomId didJoinSuccess:nil];
}


/// 改变用户身份
- (void)changeRole:(int)role{
    self.clientRole = (role == 3)?AgoraClientRoleAudience:AgoraClientRoleBroadcaster;
    [AgoraManager.rtcEngine setClientRole:self.clientRole];
}


- (void)anchorId:(int64_t)anchorId volume:(void (^)(NSUInteger))block{
    _anchorId = anchorId;
    _anchorVolumeBlock=((anchorId>0)?block:nil);
}

/// 用户音量大小
- (void)userVolume:(void (^)(NSUInteger, int64_t))block{
    _voiceBlock = block;
}


/** 与其他视频房间主播互动 */
- (void)connectRoom:(int64_t)roomId otherUid:(int64_t)toUid{
    kWeakSelf(self);
    [self getConnectRoomId:roomId mediaRelayToken:^(BOOL success, NSString * _Nonnull srcToken, NSString * _Nonnull destToken) {
        if (success && srcToken.length>0 && destToken.length > 0) {
            [weakself connectVideo:roomId srcToken:srcToken destToken:destToken];
        }
    }];
}

- (void)connectVideo:(int64_t)roomId srcToken:(NSString *)srcToken destToken:(NSString *)destToken{
    
    AgoraChannelMediaRelayConfiguration *mediaRelayConfig = [[AgoraChannelMediaRelayConfiguration alloc] init];
    AgoraChannelMediaRelayInfo *srcRelayInfo = [[AgoraChannelMediaRelayInfo alloc] initWithToken:srcToken];
    srcRelayInfo.channelName = [NSString stringWithFormat:@"%lld",AgoraManager.roomID];
    srcRelayInfo.uid = 0;
    mediaRelayConfig.sourceInfo = srcRelayInfo;
    
    AgoraChannelMediaRelayInfo *destRelayInfo =  [[AgoraChannelMediaRelayInfo alloc] initWithToken:destToken];
    destRelayInfo.uid = AgoraManager.userID;///目标频道里没有的UId——用自己的uid
    destRelayInfo.channelName = [NSString stringWithFormat:@"%lld",roomId];
    [mediaRelayConfig setDestinationInfo:destRelayInfo forChannelName:destRelayInfo.channelName];
    
    int code = [AgoraManager.rtcEngine startChannelMediaRelay:mediaRelayConfig];
    
    if (code == 0) {
        _otherRoomId = roomId;
    } else {
       // NSLog(@"过滤文字Join channel failed: %d"), code);
    }
}

/** 关闭与他人互动 */
- (void)closeConnect{
    
    if(_otherRoomId > 0){
        [AgoraManager.rtcEngine stopChannelMediaRelay];
    }
    _otherRoomId = 0;
    AgoraLiveTranscodingUser *anchor = [[AgoraLiveTranscodingUser alloc] init];
    anchor.uid = (NSInteger)AgoraManager.userID;
    anchor.rect = CGRectMake(0, 0, 720, 1280);
    anchor.audioChannel = 0;
    [self baseAgoraLiveTranscoding:@[anchor]];
}


/// 离开房间
- (void)leaveRoom{
    
    [self closeConnect];
    [self leaveRoom:0 didLeaveSuccess:nil];
    
    AgoraManager.rtcEngine.delegate = nil;
    [AgoraManager destroy];
    
    _voiceBlock = nil;
    _anchorVolumeBlock = nil;
    _anchorId = 0;
    _otherRoomId = 0;
    _userId = 0;
    
}


#pragma mark - 私有方法 -


- (void)videoSessionOfUid:(NSUInteger)uid AndHostingView:(UIView *)hostingView{
    AgoraRtcVideoCanvas *canvas = [[AgoraRtcVideoCanvas alloc] init];
    canvas.uid = uid;
    canvas.renderMode = AgoraVideoRenderModeHidden;
    [AgoraManager.rtcEngine setupRemoteVideo:canvas];
}



//基础数据
- (void)baseAgoraLiveTranscoding:(NSArray <AgoraLiveTranscodingUser *> *)userArr{
    AgoraLiveTranscoding *transcoding = [[AgoraLiveTranscoding alloc] init];
    transcoding.transcodingUsers = userArr;
    [AgoraManager setTranscodingAgoraBase:transcoding];
    [AgoraManager.rtcEngine setLiveTranscoding:transcoding];
}

#pragma mark - AgoraRtcEngineDelegate -

///远端用户已加入频道
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
}

- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine reportAudioVolumeIndicationOfSpeakers:(NSArray<AgoraRtcAudioVolumeInfo *> * _Nonnull)speakers totalVolume:(NSInteger)totalVolume{
    
    for (AgoraRtcAudioVolumeInfo *volumeInfo in speakers) {
        ///音量回调
        ///volumeInfo.volume:0-255
        if (volumeInfo.uid > 0) {///远端用户
            _voiceBlock((NSUInteger)(volumeInfo.volume/28.33),(int64_t)volumeInfo.uid);
            
            if (self.anchorVolumeBlock && _anchorId == (int64_t)volumeInfo.uid) {  ///主播
                self.anchorVolumeBlock((NSUInteger)(volumeInfo.volume/28.33));
            }
            
        }else{  ///自己
            _voiceBlock((NSUInteger)(volumeInfo.volume/28.33),_userId);
            
            if (self.anchorVolumeBlock && _anchorId == _userId) { ///主播
                self.anchorVolumeBlock((NSUInteger)(volumeInfo.volume/28.33));
            }
        }
    }
}


@end
