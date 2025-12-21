//
//  AgoraVideoSnasshot.m
//  AgoraExtension
//
//  Created by klc_sl on 2021/1/11.
//  Copyright © 2021 XTY. All rights reserved.
//

#import "AgoraVideoSnasshot.h"
#import "AgoraMediaDataPlugin.h"

@interface AgoraVideoSnasshot ()<AgoraVideoDataPluginDelegate>

@property (nonatomic)AgoraMediaDataPlugin *agoraMediaDataPligin;

@property (nonatomic, assign)int second;

@property (nonatomic, copy)NSTimer *snasshotTimer;

@end

@implementation AgoraVideoSnasshot

- (void)dealloc
{
    [self stopMonitoring];
}

- (instancetype)initWithSnasshotForSecond:(int)second
{
    self = [super init];
    if (self) {
        _second = second;
    }
    return self;
}

- (void)startMonitoring:(AgoraRtcEngineKit *)engineKit{
    if (_second > 0 && !self.agoraMediaDataPligin) {
        self.agoraMediaDataPligin = [AgoraMediaDataPlugin mediaDataPluginWithAgoraKit:engineKit];
        self.agoraMediaDataPligin.videoDelegate = self;
        ObserverVideoType videoType = ObserverVideoTypeCaptureVideo|ObserverVideoTypeRenderVideo;
        [self.agoraMediaDataPligin registerVideoRawDataObserver:videoType];
        
        if (!_snasshotTimer) {
            _snasshotTimer = [NSTimer scheduledTimerWithTimeInterval:_second target:self selector:@selector(tapSnasshotButton) userInfo:nil repeats:YES];
        };
    }
}

- (void)stopMonitoring{
    [_snasshotTimer invalidate];
    _snasshotTimer = nil;
    _agoraMediaDataPligin.videoDelegate = nil;
    ObserverVideoType videoType = ObserverVideoTypeCaptureVideo|ObserverVideoTypeRenderVideo;
    [_agoraMediaDataPligin deregisterVideoRawDataObserver:videoType];
    _agoraMediaDataPligin = nil;
}

#pragma mark - AgoraVideoDataPluginDelegate -
- (AgoraVideoRawData *)mediaDataPlugin:(AgoraMediaDataPlugin *)mediaDataPlugin didCapturedVideoRawData:(AgoraVideoRawData *)videoRawData{
    return videoRawData;
}

- (AgoraVideoRawData *)mediaDataPlugin:(AgoraMediaDataPlugin *)mediaDataPlugin willPreEncodeVideoRawData:(AgoraVideoRawData *)videoRawData{
    return videoRawData;
}

- (AgoraVideoRawData *)mediaDataPlugin:(AgoraMediaDataPlugin *)mediaDataPlugin willRenderVideoRawData:(AgoraVideoRawData *)videoRawData ofUid:(uint)uid{
    return videoRawData;
}


- (void)tapSnasshotButton{
    [_agoraMediaDataPligin localSnapshot:^(AGImage * _Nonnull image) {
        self.snasshotBlock(image);
    }];
}


@end
