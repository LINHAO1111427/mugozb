//
//  AgoraMPAudio.m
//  AgoraExtension
//
//  Created by kalacheng on 2020/6/9.
//  Copyright © 2020 kalacheng. All rights reserved.
//

#import "AgoraMPAudio.h"
#import <LibTools/LibTools.h>

@interface AgoraMPAudio ()<ByteRTCEngineDelegate>

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
    self.clientRole = (role == 3)?ByteRTCUserRoleTypeSilentAudience:ByteRTCUserRoleTypeBroadcaster;
    ///语音不需要推流
    if (role == 1) {
    } else if (role == 2) {
    } else{
    }
    [AgoraManager setVoiceAgoraBase:ByteRTCRoomProfileLiveBroadcasting];
    [AgoraManager.rtcEngine setUserRole:self.clientRole];
    [AgoraManager.rtcEngine stopVideoCapture];
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
    self.clientRole = (role == 3)?ByteRTCUserRoleTypeSilentAudience:ByteRTCUserRoleTypeBroadcaster;
    [AgoraManager.rtcEngine setUserRole:self.clientRole];
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
    (void)srcToken;
    ForwardStreamConfiguration *destRelayInfo = [[ForwardStreamConfiguration alloc] init];
    destRelayInfo.roomId = [NSString stringWithFormat:@"%lld", roomId];
    destRelayInfo.token = destToken;
    int code = [AgoraManager.rtcEngine startForwardStreamToRooms:@[destRelayInfo]];

    if (code == 0) {
        _otherRoomId = roomId;
    } else {
       // NSLog(@"过滤文字Join channel failed: %d"), code);
    }
}

/** 关闭与他人互动 */
- (void)closeConnect{
    
    if(_otherRoomId > 0){
        [AgoraManager.rtcEngine stopForwardStreamToRooms];
    }
    _otherRoomId = 0;
    ByteRTCVideoCompositingRegion *anchor = [[ByteRTCVideoCompositingRegion alloc] init];
    anchor.uid = [NSString stringWithFormat:@"%lld", AgoraManager.userID];
    anchor.roomId = [NSString stringWithFormat:@"%lld", AgoraManager.roomID];
    anchor.renderMode = ByteRTCRenderModeHidden;
    anchor.alpha = 1.0;
    anchor.zOrder = 0;
    anchor.localUser = YES;
    anchor.x = 0.0;
    anchor.y = 0.0;
    anchor.width = 1.0;
    anchor.height = 1.0;
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


- (void)videoSessionOfUid:(NSString *)uid AndHostingView:(UIView *)hostingView{
    ByteRTCVideoCanvas *canvas = [[ByteRTCVideoCanvas alloc] init];
    canvas.uid = uid;
    canvas.view = hostingView;
    canvas.renderMode = ByteRTCRenderModeHidden;
    [AgoraManager.rtcEngine setRemoteVideoCanvas:uid withIndex:ByteRTCStreamIndexMain withCanvas:canvas];
}



//基础数据
- (void)baseAgoraLiveTranscoding:(NSArray <ByteRTCVideoCompositingRegion *> *)regions{
    ByteRTCLiveTranscoding *transcoding = [[ByteRTCLiveTranscoding alloc] init];
    ByteRTCVideoCompositingLayout *layout = [[ByteRTCVideoCompositingLayout alloc] init];
    layout.backgroundColor = @"#000000";
    layout.regions = regions ?: @[];
    transcoding.layout = layout;
    if (AgoraManager.pushUrl.length > 0) {
        transcoding.url = [NSString stringWithFormat:@"%@/%lld", AgoraManager.pushUrl, AgoraManager.userID];
    }
    [AgoraManager setTranscodingAgoraBase:transcoding];
}

#pragma mark - ByteRTCEngineDelegate -

- (void)rtcEngine:(ByteRTCEngineKit *)engine onUserJoined:(ByteRTCUserInfo *)userInfo elapsed:(NSInteger)elapsed {
}

- (void)rtcEngine:(ByteRTCEngineKit * _Nonnull)engine onAudioVolumeIndication:(NSArray<ByteRTCAudioVolumeInfo *> * _Nonnull)speakers totalRemoteVolume:(NSInteger)totalRemoteVolume{
    
    for (ByteRTCAudioVolumeInfo *volumeInfo in speakers) {
        NSUInteger volume = (NSUInteger)(volumeInfo.linearVolume / 28.33);
        int64_t uidValue = volumeInfo.uid.length > 0 ? (int64_t)[volumeInfo.uid longLongValue] : _userId;
        _voiceBlock ? _voiceBlock(volume, uidValue) : nil;
        
        if (self.anchorVolumeBlock && _anchorId == uidValue) {  ///主播
            self.anchorVolumeBlock(volume);
        }
    }
}


@end
