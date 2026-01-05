//
//  AgoraRtcManager.h
//  AgoraExtension
//
//  Created by kalacheng on 2020/6/9.
//  Copyright © 2020 kalacheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VolcEngineRTC/VolcEngineRTC.h>
#import "LiveBeautyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

#define AgoraManager [AgoraRtcManager manager]


@interface AgoraRtcManager : NSObject


@property (strong, nonatomic) ByteRTCEngineKit *rtcEngine;

@property (nonatomic, assign) int64_t roomID;
@property (nonatomic, assign) int64_t userID;

@property (nonatomic, copy) NSString *agoraId;

///美颜等级
@property (nonatomic, assign) int imageQualityNum;

///设置美颜文件
@property (nonatomic, copy) Class<LiveBeautyProtocol> beautyCls;


@property (nonatomic, copy)NSString *pushUrl;

@property (nonatomic, copy)NSString *pullUrl;

@property (nonatomic, assign)BOOL previewStatus;
@property (nonatomic, assign) ByteRTCCameraID currentCameraId;


+ (void)setAgoraLiveKey:(NSString *)key userId:(int64_t)userId;


+ (void)setUrlForCDN:(NSString *)urls;


+ (instancetype)manager;


- (void)reloadAgoraRtc;


- (void)destroy;




///设置视频基础数据
- (void)setVideoAgoraBase:(ByteRTCRoomProfile)roomProfile;

///设置语音基础数据
- (void)setVoiceAgoraBase:(ByteRTCRoomProfile)roomProfile;

///设置基础layout
- (void)setTranscodingAgoraBase:(ByteRTCLiveTranscoding *)transcoding;

- (void)stopLiveTranscoding;

- (void)toggleCamera;



@end

NS_ASSUME_NONNULL_END

