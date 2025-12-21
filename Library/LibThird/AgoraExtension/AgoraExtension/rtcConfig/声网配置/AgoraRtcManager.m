//
//  AgoraRtcManager.m
//  AgoraExtension
//
//  Created by kalacheng on 2020/6/9.
//  Copyright © 2020 kalacheng. All rights reserved.
//

#import "AgoraRtcManager.h"
#import <LibTools/LibTools.h>

@interface AgoraRtcManager ()

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
    [AgoraRtcEngineKit destroy];
}


#pragma mark  - 业务 -

///充值声网的key
- (void)reloadAgoraRtc{
    [_manager agoraAppId:_agoraId];
}


// 360*640 15 1200  1280x720 15 3000/3420  848*480 30  2200
- (void)setVideoAgoraBase:(AgoraChannelProfile)channelProfile{
    
    [self.rtcEngine setChannelProfile:channelProfile];
    [self.rtcEngine enableDualStreamMode:YES];
    [self.rtcEngine enableVideo];
    
    // 1.视频分辨率 2.帧速率视频帧速率 3.比特率视频比特率 4.方向模式
    AgoraVideoEncoderConfiguration *configuration =
    [[AgoraVideoEncoderConfiguration alloc] initWithSize:AgoraVideoDimension1280x720
                                               frameRate:AgoraVideoFrameRateFps15
                                                 bitrate:[self getVideoBitrateData]
                                         orientationMode:AgoraVideoOutputOrientationModeAdaptative];
    [self.rtcEngine setVideoEncoderConfiguration:configuration];
    
    
    configuration.mirrorMode = AgoraVideoMirrorModeEnabled;
    [self.rtcEngine setVideoEncoderConfiguration:configuration];
    [self.rtcEngine setLocalRenderMode:AgoraVideoRenderModeHidden];
}


- (void)setVoiceAgoraBase:(AgoraChannelProfile)channelProfile {
    [_rtcEngine enableAudio];
    [_rtcEngine setChannelProfile:channelProfile];
    
    ///设置音频应用场景 与adjustPlaybackSignalVolume最好不共存
    [_rtcEngine setAudioProfile:AgoraAudioProfileMusicHighQuality scenario:AgoraAudioScenarioGameStreaming];
    
    // 启用获取远程用户说话的音量回调
    [_rtcEngine enableAudioVolumeIndication:200 smooth:3 report_vad:NO];
    [_rtcEngine setEnableSpeakerphone:YES];
    
    [_rtcEngine muteLocalAudioStream:NO];
    [_rtcEngine muteAllRemoteAudioStreams:NO];
    
    [_rtcEngine enableLastmileTest];//开始监听网络
    
}

- (void)setTranscodingAgoraBase:(AgoraLiveTranscoding *)transcoding{
    //    transcoding.audioSampleRate = AgoraAudioSampleRateType44100;
    //    transcoding.audioChannels = 2;
    //    transcoding.audioBitrate = 48;
    transcoding.size = CGSizeMake(720, 1280);
    transcoding.videoBitrate = [self getVideoBitrateData] ;
    // 推流输出视频的编码规格。可以设置为 Baseline (66)、Main (77) 或 High (100)。如果设置其他值，Agora 会统一设为默认值 High (100)。
    transcoding.videoCodecProfile = AgoraVideoCodecProfileTypeHigh;
}


- (NSInteger)getVideoBitrateData{
    
    switch (_imageQualityNum) {
        case 1:
            return 1130;
            break;
        case 2:
            return 2260 ;
            break;
        case 3:
            return 3420 ;
            break;
        default:
            return 1130 ;
            break;
    }
}

- (void)setPreviewStatus:(BOOL)previewStatus{
    _previewStatus = previewStatus;
    
    //    previewStatus?[AgoraManager.rtcEngine startPreview]:[AgoraManager.rtcEngine stopPreview];
    
    NSDictionary *param;
    if (previewStatus) {
        param = @{@"rtc.video.preview":@(YES)};
    }else{
        param = @{@"rtc.video.preview":@(NO)};
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [_rtcEngine setParameters:jsonString];
    
}



#pragma mark  - 设置服务器的key -
+ (void)setUrlForCDN:(NSString *)urls{
   // NSLog(@"过滤文字暂未实现"));
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



///设置声网的key
- (void)agoraAppId:(NSString *)appId{
    _rtcEngine = nil;
    _agoraId = appId;
    [AgoraRtcEngineKit destroy];
    _rtcEngine = [AgoraRtcEngineKit sharedEngineWithAppId:appId delegate:nil];
    [AgoraRtcEngineKit getSdkVersion];
}


@end
