//
//  AgoraMPVideo.m
//  AgoraExtension
//
//  Created by kalacheng on 2020/6/9.
//  Copyright © 2020 kalacheng. All rights reserved.
//

#import "AgoraMPVideo.h"
#import <LibTools/LibTools.h>
#import "AgoraBeautyView.h"
#import "AgoraVideoSourceObj.h"
#import "TXLivePlayObj.h"

#import "AgoraVideoSnasshot.h"
#import "HttpSessionObj.h"

typedef NS_ENUM(NSUInteger, XTLiveUserCurrentState) {
    ///普通直播
    XTLiveUserCurrentNormal,
    ///连麦中
    XTLiveUserCurrentLinkMic,
    ///主播互动中
    XTLiveUserCurrentInteractive,
};

@interface AgoraMPVideo ()<ByteRTCEngineDelegate>

@property (nonatomic, assign) int64_t anchorId; ///主播ID
@property (nonatomic, assign) int64_t userId;  ///自己的uid

@property (nonatomic, weak) UIImageView *anchorV;           //主播视图

@property (nonatomic, weak) UIImageView *subAnchorV;        //pk的对方主播视图
@property (nonatomic, assign) int64_t otherUserId;          //副播的用户id
@property (nonatomic, assign) int64_t otherRoomId;          //副播的房间id    (前提：房间id = 直播id)

@property (nonatomic, assign)XTLiveUserCurrentState userCurrentState; ///用户当前的状态

@property (nonatomic, copy) TXLivePlayObj *playVideoObj;   ///播放视频

@property (nonatomic, weak) AgoraBeautyView *agoraBeauty;        //自带美颜视图

@property (nonatomic, copy) AgoraVideoSourceObj *beautyObj;   ///美颜

@property (nonatomic, copy) AgoraVideoSnasshot *videoSnasshot;   ///视频监控

@property (nonatomic, copy)void (^disconnectBlock)(void);  ///连麦失败的回调

//模式设置-------------------------------------------------------------------------------------

@property (nonatomic, assign)BOOL isAgoraBeauty;   //是否使用云自带美颜

//模式设置-------------------------------------------------------------------------------------

@end

@implementation AgoraMPVideo

@synthesize playStatusBlock;
@synthesize pullStr;
@synthesize onConnectStatusBlock;

- (void)dealloc{
   // NSLog(@"过滤文字多人直播文件 dealloc"));
    AgoraManager.rtcEngine.delegate = nil;
    [AgoraManager destroy];
    
    _beautyObj = nil;
    
    //    [self agoraAnchorLeave];
    //    [self agoraAudienceLeave];
}


+ (instancetype)registerObj{
    return [[AgoraMPVideo alloc] init];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _userCurrentState = 0;
    }
    return self;
}

- (void)remoteVoiceClosed:(BOOL)close{
    [AgoraManager.rtcEngine muteAllRemoteAudio:close ? ByteRTCMuteStateOn : ByteRTCMuteStateOff];
    _playVideoObj.mute = close;
}

- (void)remoteVideoClosed:(BOOL)close{
    [AgoraManager.rtcEngine muteAllRemoteVideo:close ? ByteRTCMuteStateOn : ByteRTCMuteStateOff];
    if (_playVideoObj) {
        _playVideoObj.videoPause = close;
    }
}


/// 初始化基础信息
/// @param role 用户角色                       主播=1 // 副播=2 // 观众(默认) =3
- (void)initMPVideoRole:(int)role {
    self.clientRole = (role ==3?ByteRTCUserRoleTypeSilentAudience:ByteRTCUserRoleTypeBroadcaster);
    _isAgoraBeauty = (AgoraManager.beautyCls?NO:YES);
    NSString *rtmp = [NSString stringWithFormat:@"%@/%lld",AgoraManager.pullUrl, AgoraManager.userID];
    self.pullStr = rtmp;
    _userId = AgoraManager.userID;
}

- (void)initMPVideoRole:(int)role userid:(int64_t)userid
{
    self.clientRole = (role ==3?ByteRTCUserRoleTypeSilentAudience:ByteRTCUserRoleTypeBroadcaster);
    _isAgoraBeauty = (AgoraManager.beautyCls?NO:YES);
    NSString *rtmp = [NSString stringWithFormat:@"%@/%lld",AgoraManager.pullUrl, AgoraManager.userID];
    self.pullStr = rtmp;
    _userId = AgoraManager.userID;
}

- (void)setSnasshotTime:(int)time videoFrame:(void (^)(UIImage * _Nonnull))videoFrame{
    if (time > 0 && !_videoSnasshot) {
        _videoSnasshot = [[AgoraVideoSnasshot alloc] initWithSnasshotForSecond:time];
        _videoSnasshot.snasshotBlock = ^(UIImage * _Nonnull image) {
            if (videoFrame) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    videoFrame(image);
                });
            }
        };
    }
}

///主播预览视图
- (void)preview:(UIImageView *)preview isOpen:(BOOL)isOpen {
    _anchorV = preview;
    [self initAgoraData];
    [self addLocalSessionAndView:preview];
    [preview layoutIfNeeded];
    
    AgoraManager.previewStatus = isOpen;
}

- (void)initAgoraData{
    AgoraManager.rtcEngine.delegate = self;
    [AgoraManager setVideoAgoraBase:ByteRTCRoomProfileLiveBroadcasting];
    [AgoraManager.rtcEngine setUserRole:self.clientRole];
    if (_isAgoraBeauty) {
        AgoraBeautyView *beautyV = [[AgoraBeautyView alloc] init];
        self.agoraBeauty = beautyV;
        [self AgoreSetRednessLevel:0.5 smoothnessLevel:0.5 BrightLevel:0.5];
    }else{
        _beautyObj = [[AgoraVideoSourceObj alloc] init];
        [_beautyObj startCapture];
    }
}


/** 主播用-创建直播房间配置基础数据 */
- (void)createVideo:(int64_t)roomId{
    _anchorId = _userId;
    [AgoraManager.rtcEngine setUserRole:self.clientRole];
    ///主播加入房间
    {
        kWeakSelf(self);
        [self joinRoom:roomId didJoinSuccess:^(ByteRTCEngineKit * _Nonnull engine) {
            [weakself.videoSnasshot startMonitoring:engine];
            {
                ///主播绘制画面并且推流
                [self refreshAnchorCompositingLayout];

//                推流接口更换
//                [HttpSessionObj sendpushUrl:AgoraManager.pushUrl userId:AgoraManager.userID roomId:roomId successBlock:^(BOOL, NSDictionary * _Nonnull) {
//
//                }];
            }
        }];
    }

}


/** 主播用-与其他视频房间主播互动 */
- (void)connectVideo:(int64_t)roomId showV:(UIImageView *)showV disconnectBlock:(void (^)(void))disconnect {
    self.disconnectBlock = disconnect;
    kWeakSelf(self);
    [self getConnectRoomId:roomId mediaRelayToken:^(BOOL success, NSString * _Nonnull srcToken, NSString * _Nonnull destToken) {
        if (success && srcToken.length>0 && destToken.length > 0) {
            [weakself connectVideo:roomId showV:showV srcToken:srcToken destToken:destToken];
        }else{
            weakself.onConnectStatusBlock?weakself.onConnectStatusBlock(RTCForMPVideoConnectInviteFail, [NSString stringWithFormat:kLocalizationMsg(@"邀请房间(%lld)连麦失败(鉴权失败)"),roomId]):nil;
        }
    }];
}

- (void)connectVideo:(int64_t)roomId showV:(UIImageView *)showV srcToken:(NSString *)srcToken destToken:(NSString *)destToken{
    (void)srcToken;
    ForwardStreamConfiguration *destRelayInfo = [[ForwardStreamConfiguration alloc] init];
    destRelayInfo.roomId = [NSString stringWithFormat:@"%lld", roomId];
    destRelayInfo.token = destToken;
    int code = [AgoraManager.rtcEngine startForwardStreamToRooms:@[destRelayInfo]];

    if (code == 0) {
        _subAnchorV = showV;
        _otherRoomId = roomId;
        _userCurrentState = XTLiveUserCurrentInteractive;
        self.onConnectStatusBlock?self.onConnectStatusBlock(RTCForMPVideoConnectInviteSuccess, [NSString stringWithFormat:kLocalizationMsg(@"邀请房间(%lld)连麦成功"),roomId]):nil;
    } else {
        self.onConnectStatusBlock?self.onConnectStatusBlock(RTCForMPVideoConnectInviteFail, [NSString stringWithFormat:kLocalizationMsg(@"邀请房间(%lld)连麦失败(%d)"),roomId,code]):nil;
        self.disconnectBlock?self.disconnectBlock():nil;
       // NSLog(@"过滤文字Join channel failed: %d"), code);
    }
}



/** 用户用-加入直播房间 */
- (void)joinVideo:(int64_t)roomId anchorId:(int64_t)anchorId showV:(UIImageView *)showV{
    AgoraManager.roomID = roomId;
    _anchorId = anchorId;
    [self audiencJoinRoomOpenMic:roomId audienceV:showV];
}
- (void)joinLookVideo:(int64_t)roomId anchorId:(int64_t)anchorId showV:(UIImageView *)showV{
    AgoraManager.roomID = roomId;
    _anchorId = anchorId;
    _anchorV = showV;
}

/** 主播用-显示连麦的视图 */
- (void)showLinkMicV:(UIImageView *)showV{
    self.userCurrentState = XTLiveUserCurrentLinkMic;
    _subAnchorV = showV;
}

/** 用户用-播放视频 */
- (void)playVideoUrl:(NSString *)url showV:(UIImageView *)showV thumb:(NSString *)thumb{
    _anchorV = showV;
    
    [self showAnchorPullUrl:url thumb:thumb];
}


/** 主播用--关闭与他人连麦视图 */
- (void)closeConnect{
    _otherUserId = 0;
    _userCurrentState = 0;
    if(_otherRoomId > 0){
        [AgoraManager.rtcEngine stopForwardStreamToRooms];
    }
    _subAnchorV = nil;
    _otherRoomId = 0;
    self.userCurrentState = XTLiveUserCurrentNormal;
    [self refreshAnchorCompositingLayout];
}


/** 观众用---与主播断开连麦 */
- (void)leaveRoomToPlay{
    self.userCurrentState = XTLiveUserCurrentNormal;
    self.clientRole = ByteRTCUserRoleTypeSilentAudience;
    [AgoraManager.rtcEngine setUserRole:ByteRTCUserRoleTypeSilentAudience];
    AgoraManager.previewStatus = NO;
    _userCurrentState = 0;
    BOOL isPlay = [self checkPlayUrl:self.playVideoObj.anchorPullUrl];
    if (isPlay == NO)
    {
        if (_playVideoObj) {  //如果是观众观看cdn模式
            _subAnchorV = nil;
            [self leaveRoom:0 didLeaveSuccess:nil];
            self.beautyObj = nil;
            [AgoraManager destroy];
            if (_otherUserId == _userId){
                
                [self.playVideoObj reStartVideoPlay];
            }
        }
    }else{
        int64_t temroomId = AgoraManager.roomID;
        
        [self audiencLookJoinRoomOpenMic:temroomId audienceV:_anchorV];
    }
    
    _otherUserId = 0;
}

/** 离开 */
- (void)leaveRoom{
    [_playVideoObj stopVideoPlay];
    _playVideoObj = nil;
    
    [self closeConnect];
    [self agoraAnchorLeave];
    [self agoraAudienceLeave];
    
    [AgoraManager.rtcEngine setLocalVideoCanvas:ByteRTCStreamIndexMain withCanvas:nil];
    [self leaveRoom:0 didLeaveSuccess:nil];
    if (self.clientRole == ByteRTCUserRoleTypeBroadcaster) {
        AgoraManager.previewStatus = NO;
    }
    _anchorV = nil;
    _subAnchorV = nil;
    AgoraManager.rtcEngine.delegate = nil;
    [AgoraManager destroy];
    
}

/** 美颜 */
- (void)showBeautyInView:(UIView *)superV complete:(void (^)(void))complete{
    kWeakSelf(self);
    if (_isAgoraBeauty) {
        [self.agoraBeauty showWithSelectHandle:^(CGFloat redness, CGFloat smoothness, CGFloat bright) {
            [weakself AgoreSetRednessLevel:redness smoothnessLevel:smoothness BrightLevel:bright];
        } complete:^{
            if (complete) {
                complete();
            }
        }];
    }else{
        [AgoraManager.beautyCls showBeautyInView:superV complete:^{
            if (complete) {
                complete();
            }
        }];
    }
}

/** 切换摄像头 */
- (void)switchCamera{
    if (_isAgoraBeauty) {
        [AgoraManager toggleCamera];
    }else{
        [self.beautyObj switchCamera:^(BOOL isFront) {
            ByteRTCMirrorType mirrorType = isFront ? ByteRTCMirrorTypeRender : ByteRTCMirrorTypeNone;
            [AgoraManager.rtcEngine setLocalVideoMirrorType:mirrorType];
        }];
    }
}

- (void)addLocalSessionAndView:(UIImageView *)imageV{
    ByteRTCVideoCanvas *videoCanvas = [[ByteRTCVideoCanvas alloc] init];
    videoCanvas.uid = [NSString stringWithFormat:@"%lld", _userId];
    videoCanvas.view = imageV;
    videoCanvas.renderMode = ByteRTCRenderModeHidden;
    [AgoraManager.rtcEngine setLocalVideoCanvas:ByteRTCStreamIndexMain withCanvas:videoCanvas];
}


- (void)videoSessionOfUid:(NSString *)uid AndHostingView:(UIView *)hostingView{
    ByteRTCVideoCanvas *videoCanvas = [[ByteRTCVideoCanvas alloc] init];
    videoCanvas.uid = uid;
    videoCanvas.view = hostingView;
    videoCanvas.renderMode = ByteRTCRenderModeHidden;
    [AgoraManager.rtcEngine setRemoteVideoCanvas:uid withIndex:ByteRTCStreamIndexMain withCanvas:videoCanvas];
}


#pragma mark - 私有 -
/*** 房间外 cdn观看 ***/
- (void)showAnchorPullUrl:(NSString *)url thumb:(NSString *)thumb{
    self.playVideoObj.thumb = thumb;
    self.playVideoObj.anchorPullUrl = url;
    BOOL isPlay = [self checkPlayUrl:url];
    if (isPlay == NO)
    {
        [self.playVideoObj startVideoPlay];

    }else{
        [self audiencLookJoinRoomOpenMic:AgoraManager.roomID audienceV:_anchorV];

    }
}
-(BOOL)checkPlayUrl:(NSString*)playUrl {
    
    playUrl = [playUrl lowercaseString];
    if ([playUrl hasPrefix:@"rtmp:"]) {
        return YES;
    } else if (([playUrl hasPrefix:@"https:"] || [playUrl hasPrefix:@"http:"]) && ([playUrl rangeOfString:@".flv"].length > 0)) {
        return YES;
    } else if (([playUrl hasPrefix:@"https:"] || [playUrl hasPrefix:@"http:"]) && [playUrl rangeOfString:@".m3u8"].length > 0) {
        return NO;
    } else if (([playUrl hasPrefix:@"https:"] || [playUrl hasPrefix:@"http:"]) && [playUrl rangeOfString:@".mp4"].length > 0) {
        return NO;
    }  else{
        return NO;
    }
    return NO;
}
- (TXLivePlayObj *)playVideoObj{
    if (!_playVideoObj && _anchorV) {
        _playVideoObj = [[TXLivePlayObj alloc] initShowInView:_anchorV];
    }
    return _playVideoObj;
}

/** 房间外和主播连麦 ***/
- (void)audiencJoinRoomOpenMic:(int64_t)roomId audienceV:(UIImageView *)imgV{
    _subAnchorV = imgV;
    [AgoraManager reloadAgoraRtc];
    [self initMPVideoRole:(int)self.clientRole];
    [self initAgoraData];
    
    ///主播加入房间
    {
        kWeakSelf(self);
        [self joinRoom:roomId didJoinSuccess:^(ByteRTCEngineKit * _Nonnull engine) {
            [weakself.videoSnasshot startMonitoring:engine];
            weakself.otherUserId = weakself.userId;
            [weakself.playVideoObj stopVideoPlay];
        }];
    }
    
    [self addLocalSessionAndView:imgV];
    [imgV layoutIfNeeded];
}
- (void)audiencLookJoinRoomOpenMic:(int64_t)roomId audienceV:(UIImageView *)imgV{
    _anchorV = imgV;
    [AgoraManager reloadAgoraRtc];
    [self initMPVideoRole:2];
    [self initAgoraData];
    
    ///主播加入房间
    {
        kWeakSelf(self);
        [self joinRoom:roomId didJoinSuccess:^(ByteRTCEngineKit * _Nonnull engine) {
            [weakself.videoSnasshot startMonitoring:engine];
            weakself.otherUserId = weakself.userId;
            [weakself.playVideoObj stopVideoPlay];
        }];
    }
    
    [self videoSessionOfUid:[NSString stringWithFormat:@"%lld", _anchorId] AndHostingView:imgV];
    
    [imgV layoutIfNeeded];
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

//刷新连麦的SEI
- (void)refreshLinkVideoCompositingLayout{
    ByteRTCVideoCompositingRegion *anchor = [[ByteRTCVideoCompositingRegion alloc] init];
    anchor.uid = [NSString stringWithFormat:@"%lld", AgoraManager.userID];
    anchor.roomId = [NSString stringWithFormat:@"%lld", AgoraManager.roomID];
    anchor.renderMode = ByteRTCRenderModeHidden;
    anchor.alpha = 1.0;
    anchor.zOrder = 0;
    anchor.localUser = YES;
    if (_otherRoomId > 0) {
        anchor.x = 0.0;
        anchor.y = 0.2;
        anchor.width = 0.5;
        anchor.height = 0.4;
    } else {
        anchor.x = 0.0;
        anchor.y = 0.0;
        anchor.width = 1.0;
        anchor.height = 1.0;
    }

    NSMutableArray<ByteRTCVideoCompositingRegion *> *regions = [NSMutableArray arrayWithObject:anchor];
    if (_otherUserId > 0) {
        ByteRTCVideoCompositingRegion *other = [[ByteRTCVideoCompositingRegion alloc] init];
        other.uid = [NSString stringWithFormat:@"%lld", _otherUserId];
        other.roomId = [NSString stringWithFormat:@"%lld", AgoraManager.roomID];
        other.renderMode = ByteRTCRenderModeHidden;
        other.alpha = 1.0;
        other.zOrder = 1;
        other.localUser = NO;
        if (_otherRoomId > 0) {
            other.x = 0.5;
            other.y = 0.2;
            other.width = 0.5;
            other.height = 0.4;
        } else {
            other.x = 0.69;
            other.y = 0.68;
            other.width = 0.3;
            other.height = 0.2;
        }
        [regions addObject:other];
    }
    [self baseAgoraLiveTranscoding:regions];
}

- (void)refreshAnchorCompositingLayout{
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


#pragma mark - 主播副播

- (void)agoraAnchorLeave{
    //    // 关闭网络监控
    [_videoSnasshot stopMonitoring];
    [AgoraManager stopLiveTranscoding];
    if (_otherRoomId > 0) {
        [AgoraManager.rtcEngine stopForwardStreamToRooms];
    }
    
    [AgoraManager.rtcEngine setLocalVideoCanvas:ByteRTCStreamIndexMain withCanvas:nil];
    [self leaveRoom:0 didLeaveSuccess:nil];
    self.beautyObj = nil;
    AgoraManager.previewStatus = NO;
    _subAnchorV = nil;
    _otherRoomId = 0;
    _otherUserId = 0;
    _anchorV = nil;
}

- (void)agoraAudienceLeave{
    [_videoSnasshot stopMonitoring];
    [_playVideoObj stopVideoPlay];
    _playVideoObj = nil;
    _anchorV = nil;
    [AgoraManager.rtcEngine setLocalVideoCanvas:ByteRTCStreamIndexMain withCanvas:nil];
    [self leaveRoom:0 didLeaveSuccess:nil];
}


- (void)AgoreSetRednessLevel:(CGFloat)redness smoothnessLevel:(CGFloat)smoothness BrightLevel:(CGFloat)bright{
    (void)redness;
    (void)smoothness;
    (void)bright;
}


- (void)rtcEngine:(ByteRTCEngineKit *)engine onUserJoined:(ByteRTCUserInfo *)userInfo elapsed:(NSInteger)elapsed {
    NSString *uid = userInfo.userId ?: @"";
    int64_t uidValue = [uid longLongValue];
    if (_anchorId == uidValue) {
        [self videoSessionOfUid:uid AndHostingView:_anchorV];
    }else{
        [self videoSessionOfUid:uid AndHostingView:_subAnchorV];
        self.otherUserId = uidValue;
    }
    if (_anchorId == _userId && self.userCurrentState == XTLiveUserCurrentLinkMic) {
        [self refreshLinkVideoCompositingLayout];
    }
}


- (void)rtcEngine:(ByteRTCEngineKit *)engine onUserLeave:(NSString *)uid reason:(ByteRTCUserOfflineReason)reason {
    int64_t uidValue = [uid longLongValue];
    if (_otherUserId == uidValue) {
        if (self.onConnectStatusBlock) {
            self.onConnectStatusBlock(RTCForMPVideoConnectLeaveSuccess, [NSString stringWithFormat:kLocalizationMsg(@"用户(%zi)已退出房间"),uidValue]);
        }
        self.userCurrentState = XTLiveUserCurrentNormal;
        [self closeConnect];
    }
}

///跨频道媒体流转发状态发生改变回调
- (void)rtcEngine:(ByteRTCEngineKit *)engine onForwardStreamStateChanged:(NSArray<ForwardStreamStateInfo *> *)infos{
    for (ForwardStreamStateInfo *info in infos) {
        if (info.state == ByteRTCForwardStreamStateSuccess) {
            if (self.onConnectStatusBlock) {
                self.onConnectStatusBlock(RTCForMPVideoConnectJoinSuccess, kLocalizationMsg(@"开始接收远端用户视频流"));
            }
        }
        if (info.state == ByteRTCForwardStreamStateFailure) {
            if (self.onConnectStatusBlock) {
                self.onConnectStatusBlock(RTCForMPVideoConnectJoinFail,[NSString stringWithFormat:kLocalizationMsg(@"跨频道连麦异常%zi"),info.error]);
            }
            self.disconnectBlock?self.disconnectBlock():nil;
        }
    }
}


@end
