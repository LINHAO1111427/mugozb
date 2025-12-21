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

@interface AgoraMPVideo ()<AgoraRtcEngineDelegate>

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
    [AgoraManager.rtcEngine muteAllRemoteAudioStreams:close];
    _playVideoObj.mute = close;
}

- (void)remoteVideoClosed:(BOOL)close{
    [AgoraManager.rtcEngine muteAllRemoteVideoStreams:close];
    if (_playVideoObj) {
        _playVideoObj.videoPause = close;
    }
}


/// 初始化基础信息
/// @param role 用户角色                       主播=1 // 副播=2 // 观众(默认) =3
- (void)initMPVideoRole:(int)role {
    self.clientRole = (role ==3?AgoraClientRoleAudience:AgoraClientRoleBroadcaster);
    _isAgoraBeauty = (AgoraManager.beautyCls?NO:YES);
    NSString *rtmp = [NSString stringWithFormat:@"%@/%lld",AgoraManager.pullUrl, AgoraManager.userID];
    self.pullStr = rtmp;
    _userId = AgoraManager.userID;
}

- (void)initMPVideoRole:(int)role userid:(int64_t)userid
{
    self.clientRole = (role ==3?AgoraClientRoleAudience:AgoraClientRoleBroadcaster);
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
    [AgoraManager setVideoAgoraBase:AgoraChannelProfileLiveBroadcasting];
    [AgoraManager.rtcEngine setClientRole:self.clientRole];
    if (_isAgoraBeauty) {
        AgoraBeautyView *beautyV = [[AgoraBeautyView alloc] init];
        self.agoraBeauty = beautyV;
        [self AgoreSetRednessLevel:0.5 smoothnessLevel:0.5 BrightLevel:0.5];
    }else{
        _beautyObj = [[AgoraVideoSourceObj alloc] init];
        [AgoraManager.rtcEngine setVideoSource:_beautyObj];
    }
}


/** 主播用-创建直播房间配置基础数据 */
- (void)createVideo:(int64_t)roomId{
    _anchorId = _userId;
    [AgoraManager.rtcEngine setClientRole:self.clientRole];
    ///主播加入房间
    {
        kWeakSelf(self);
        [self joinRoom:roomId didJoinSuccess:^(AgoraRtcEngineKit * _Nonnull engine) {
            [weakself.videoSnasshot startMonitoring:engine];
            {
                ///主播绘制画面并且推流
                [self refreshAnchorCompositingLayout];
                
                NSString *rtmp = [NSString stringWithFormat:@"%@/%lld",AgoraManager.pushUrl, AgoraManager.userID];
                int code = [engine addPublishStreamUrl:rtmp transcodingEnabled:YES];
               // NSLog(@"过滤文字%d"),code);
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
        [AgoraManager.rtcEngine stopChannelMediaRelay];
    }
    _subAnchorV = nil;
    _otherRoomId = 0;
    self.userCurrentState = XTLiveUserCurrentNormal;
    [self refreshAnchorCompositingLayout];
}


/** 观众用---与主播断开连麦 */
- (void)leaveRoomToPlay{
    self.userCurrentState = XTLiveUserCurrentNormal;
    self.clientRole = AgoraClientRoleAudience;
    [AgoraManager.rtcEngine setClientRole:AgoraClientRoleAudience];
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
    
    [AgoraManager.rtcEngine setupLocalVideo:nil];
    [self leaveRoom:0 didLeaveSuccess:nil];
    if (self.clientRole == AgoraClientRoleBroadcaster) {
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
        int code = [AgoraManager.rtcEngine switchCamera];
       // NSLog(@"过滤文字code:%d"),code);
    }else{
        
        [self.beautyObj switchCamera:^(BOOL isFront) {
            [AgoraManager.rtcEngine setLocalRenderMode:AgoraVideoRenderModeHidden mirrorMode:isFront?AgoraVideoMirrorModeEnabled:AgoraVideoMirrorModeDisabled];
        }];
    }
}

- (void)addLocalSessionAndView:(UIImageView *)imageV{
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = (NSUInteger)_userId;
    videoCanvas.view = imageV;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    videoCanvas.mirrorMode = AgoraVideoMirrorModeAuto;
    [AgoraManager.rtcEngine setupLocalVideo:videoCanvas];
}


- (void)videoSessionOfUid:(NSUInteger)uid AndHostingView:(UIView *)hostingView{
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = uid;
    videoCanvas.view = hostingView;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    [AgoraManager.rtcEngine setupRemoteVideo:videoCanvas];
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
        [self joinRoom:roomId didJoinSuccess:^(AgoraRtcEngineKit * _Nonnull engine) {
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
        [self joinRoom:roomId didJoinSuccess:^(AgoraRtcEngineKit * _Nonnull engine) {
            [weakself.videoSnasshot startMonitoring:engine];
            weakself.otherUserId = weakself.userId;
            [weakself.playVideoObj stopVideoPlay];
        }];
    }
    
    [self videoSessionOfUid:_anchorId AndHostingView:imgV];
    
    [imgV layoutIfNeeded];
}

//基础数据
- (void)baseAgoraLiveTranscoding:(NSArray <AgoraLiveTranscodingUser *> *)userArr{
    AgoraLiveTranscoding *transcoding = [[AgoraLiveTranscoding alloc] init];
    transcoding.transcodingUsers = userArr;
    [AgoraManager setTranscodingAgoraBase:transcoding];
    [AgoraManager.rtcEngine setLiveTranscoding:transcoding];
}

//刷新连麦的SEI
- (void)refreshLinkVideoCompositingLayout{
    CGFloat UserW = 720;
    CGFloat UserH = 1280;
    
    AgoraLiveTranscodingUser *anchor = [[AgoraLiveTranscodingUser alloc] init];
    anchor.uid = (NSInteger)AgoraManager.userID;
    if (_otherRoomId>0) {
        anchor.rect = CGRectMake(0, UserH*0.2, UserW/2, UserH*0.4);
    }else{
        anchor.rect = CGRectMake(0, 0, UserW, UserH);
    }
    anchor.audioChannel = 0;
    anchor.zOrder = 0;
    
    AgoraLiveTranscodingUser *other = [[AgoraLiveTranscodingUser alloc] init];
    other.uid = (NSInteger)_otherUserId;
    if (_otherRoomId>0) {
        other.rect = CGRectMake(UserW/2, UserH*0.2, UserW/2, UserH*0.4);
    }else{
        other.rect = CGRectMake(UserW*0.69, UserH*0.68, UserW*0.3, UserH*0.2);
    }
    other.audioChannel = 0;
    other.zOrder = 1;
    [self baseAgoraLiveTranscoding:@[anchor,other]];
}

- (void)refreshAnchorCompositingLayout{
    AgoraLiveTranscodingUser *anchor = [[AgoraLiveTranscodingUser alloc] init];
    anchor.uid = (NSInteger)AgoraManager.userID;
    anchor.rect = CGRectMake(0, 0, 720, 1280);
    anchor.audioChannel = 0;
    [self baseAgoraLiveTranscoding:@[anchor]];
}


#pragma mark - 主播副播

- (void)agoraAnchorLeave{
    //    // 关闭网络监控
    [_videoSnasshot stopMonitoring];
    if (_otherRoomId > 0) {
        [AgoraManager.rtcEngine stopChannelMediaRelay];
    }
    
    [AgoraManager.rtcEngine setupLocalVideo:nil];
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
    [AgoraManager.rtcEngine setupLocalVideo:nil];
    [self leaveRoom:0 didLeaveSuccess:nil];
}


- (void)AgoreSetRednessLevel:(CGFloat)redness smoothnessLevel:(CGFloat)smoothness BrightLevel:(CGFloat)bright{
    AgoraBeautyOptions *options = [[AgoraBeautyOptions alloc] init];
    options.rednessLevel = redness;
    options.smoothnessLevel = smoothness;
    options.lighteningLevel = bright;
    options.lighteningContrastLevel = AgoraLighteningContrastNormal;
    [AgoraManager.rtcEngine setBeautyEffectOptions:_isAgoraBeauty?YES:NO options:options];
}


- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    if (_anchorId == uid) {
        [self videoSessionOfUid:uid AndHostingView:_anchorV];
    }else{
        [self videoSessionOfUid:uid AndHostingView:_subAnchorV];
        self.otherUserId = uid;
    }
    if (_anchorId == _userId && self.userCurrentState == XTLiveUserCurrentLinkMic) {
        [self refreshLinkVideoCompositingLayout];
    }
}


- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason {
    if (_otherUserId == uid) {
        if (self.onConnectStatusBlock) {
            self.onConnectStatusBlock(RTCForMPVideoConnectLeaveSuccess, [NSString stringWithFormat:kLocalizationMsg(@"用户(%zi)已退出房间"),uid]);
        }
        self.userCurrentState == XTLiveUserCurrentNormal;
        [self closeConnect];
    }
}

///跨频道媒体流转发状态发生改变回调
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine channelMediaRelayStateDidChange:(AgoraChannelMediaRelayState)state error:(AgoraChannelMediaRelayError)error{
    if (state == AgoraChannelMediaRelayStateRunning) {
        if (self.onConnectStatusBlock) {
            self.onConnectStatusBlock(RTCForMPVideoConnectJoinSuccess, kLocalizationMsg(@"开始接收远端用户视频流"));
        }
    }
    if (state == AgoraChannelMediaRelayStateFailure) {
        if (self.onConnectStatusBlock) {
            self.onConnectStatusBlock(RTCForMPVideoConnectJoinFail,[NSString stringWithFormat:kLocalizationMsg(@"跨频道连麦异常(%zi)"),error]);
        }
        self.disconnectBlock?self.disconnectBlock():nil;
    }
}


@end
