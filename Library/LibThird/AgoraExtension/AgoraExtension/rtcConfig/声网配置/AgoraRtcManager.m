//
//  AgoraRtcManager.m
//  AgoraExtension
//
//  Created by kalacheng on 2020/6/9.
//  Copyright ? 2020 kalacheng. All rights reserved.
//

#import "AgoraRtcManager.h"
#import <LibTools/LibTools.h>

@interface AgoraRtcManager ()
@property (nonatomic, copy) NSString *liveTranscodingTaskId;
@property (nonatomic, assign) BOOL liveTranscodingStarted;
@end

@implementation AgoraRtcManager
static AgoraRtcManager *_manager;

+ (instancetype)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_manager) {
            _manager = [[self alloc] init];
        }
    });
    return _manager;
}

- (void)destroy{
    [self stopLiveTranscoding];
    [ByteRTCEngineKit destroy];
}

#pragma mark  - Service

- (void)reloadAgoraRtc{
    [_manager agoraAppId:_agoraId];
}

// 360*640 15 1200  1280x720 15 3000/3420  848*480 30  2200
- (void)setVideoAgoraBase:(ByteRTCRoomProfile)roomProfile{
    [self.rtcEngine enableSimulcastMode:YES];
    [self.rtcEngine startVideoCapture];

    ByteRTCVideoSolution *solution = [[ByteRTCVideoSolution alloc] init];
    solution.videoSize = CGSizeMake(1280, 720);
    solution.frameRate = 15;
    solution.maxKbps = [self getVideoBitrateData];
    solution.mode = ByteRTCVideoStreamScaleModeFitWithCropping;
    [self.rtcEngine setVideoEncoderConfig:@[solution]];

    ByteRTCMirrorType mirrorType = (self.currentCameraId == ByteRTCCameraIDBack)
        ? ByteRTCMirrorTypeNone
        : ByteRTCMirrorTypeRender;
    [self.rtcEngine setLocalVideoMirrorType:mirrorType];
}

- (void)setVoiceAgoraBase:(ByteRTCRoomProfile)roomProfile {
    [self.rtcEngine startAudioCapture];
    [self.rtcEngine setAudioProfile:ByteRTCAudioProfileHD];
    [self.rtcEngine setAudioScenario:ByteRTCAudioScenarioGameStreaming];
    [self.rtcEngine setAudioRoute:ByteRTCAudioRouteSpeakerphone];
    [self.rtcEngine setAudioVolumeIndicationInterval:200];

    [self.rtcEngine muteLocalAudio:ByteRTCMuteStateOff];
    [self.rtcEngine muteAllRemoteAudio:ByteRTCMuteStateOff];
}

- (void)setTranscodingAgoraBase:(ByteRTCLiveTranscoding *)transcoding{
    ByteRTCLiveTranscoding *config = transcoding;
    if (!config) {
        config = [ByteRTCLiveTranscoding defaultTranscoding];
    }

    if (!config.video) {
        config.video = [[ByteRTCTranscodingVideoConfig alloc] init];
    }
    if (!config.audio) {
        config.audio = [[ByteRTCTranscodingAudioConfig alloc] init];
    }
    if (!config.layout) {
        config.layout = [[ByteRTCVideoCompositingLayout alloc] init];
    }

    config.video.width = 720;
    config.video.height = 1280;
    config.video.fps = 15;
    config.video.kBitRate = [self getVideoBitrateData];

    if (config.layout.backgroundColor.length == 0) {
        config.layout.backgroundColor = @"#000000";
    }

    if (config.roomId.length == 0) {
        config.roomId = [NSString stringWithFormat:@"%lld", self.roomID];
    }
    if (config.userId.length == 0) {
        config.userId = [NSString stringWithFormat:@"%lld", self.userID];
    }

    if (config.url.length > 0) {
        if (self.liveTranscodingTaskId.length == 0) {
            self.liveTranscodingTaskId = @"liveTranscoding";
        }
        if (self.liveTranscodingStarted) {
            [self.rtcEngine updateLiveTranscoding:self.liveTranscodingTaskId transcoding:config];
        } else {
            [self.rtcEngine startLiveTranscoding:self.liveTranscodingTaskId transcoding:config observer:nil];
            self.liveTranscodingStarted = YES;
        }
    }
}

- (void)stopLiveTranscoding {
    if (self.liveTranscodingStarted && self.liveTranscodingTaskId.length > 0) {
        [self.rtcEngine stopLiveTranscoding:self.liveTranscodingTaskId];
    }
    self.liveTranscodingStarted = NO;
}

- (void)toggleCamera {
    if (self.currentCameraId != ByteRTCCameraIDBack) {
        self.currentCameraId = ByteRTCCameraIDBack;
    } else {
        self.currentCameraId = ByteRTCCameraIDFront;
    }
    [self.rtcEngine switchCamera:self.currentCameraId];

    ByteRTCMirrorType mirrorType = (self.currentCameraId == ByteRTCCameraIDBack)
        ? ByteRTCMirrorTypeNone
        : ByteRTCMirrorTypeRender;
    [self.rtcEngine setLocalVideoMirrorType:mirrorType];
}

- (NSInteger)getVideoBitrateData{
    switch (_imageQualityNum) {
        case 1:
            return 1130;
            break;
        case 2:
            return 2260;
            break;
        case 3:
            return 3420;
            break;
        default:
            return 1130;
            break;
    }
}

- (void)setPreviewStatus:(BOOL)previewStatus{
    _previewStatus = previewStatus;
    if (previewStatus) {
        [self.rtcEngine startVideoCapture];
    } else {
        [self.rtcEngine stopVideoCapture];
    }
}

#pragma mark  - Server
+ (void)setUrlForCDN:(NSString *)urls{
    NSArray *urlArr = [urls componentsSeparatedByString:@","];
    if (urlArr.count == 2) {
        AgoraManager.pushUrl = (NSString *)urlArr.firstObject;
        AgoraManager.pullUrl = (NSString *)urlArr.lastObject;
    }
}

+ (void)setAgoraLiveKey:(NSString *)key userId:(int64_t)userId{
    [AgoraManager agoraAppId:key];
    AgoraManager.userID = userId;
}

- (void)agoraAppId:(NSString *)appId{
    _rtcEngine = nil;
    _agoraId = appId;
    [ByteRTCEngineKit destroy];
    _rtcEngine = [[ByteRTCEngineKit alloc] initWithAppId:appId delegate:nil parameters:nil];
    [ByteRTCEngineKit getSdkVersion];
    if (self.currentCameraId == ByteRTCCameraIDInvalid) {
        self.currentCameraId = ByteRTCCameraIDFront;
    }
}

@end
