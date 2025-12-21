//
//  AgoraRtcManager.h
//  AgoraExtension
//
//  Created by kalacheng on 2020/6/9.
//  Copyright © 2020 kalacheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AgoraRtcKit/AgoraRtcEngineKit.h>
#import "LiveBeautyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

#define AgoraManager [AgoraRtcManager manager]


@interface AgoraRtcManager : NSObject


@property (strong, nonatomic) AgoraRtcEngineKit *rtcEngine;

@property (nonatomic, assign) int64_t roomID;
@property (nonatomic, assign) int64_t userID;

@property (nonatomic, copy) NSString *agoraId;

///美颜等级
@property (nonatomic, assign) int imageQualityNum;

///设置美颜文件
@property (nonatomic, copy) Class<LiveBeautyProtocol> beautyCls;


@property (nonatomic, copy)NSString *pushUrl;

@property (nonatomic, copy)NSString *pullUrl;

///视频画面预览状态
@property (nonatomic, assign)BOOL previewStatus;


+ (void)setAgoraLiveKey:(NSString *)key userId:(int64_t)userId;


+ (void)setUrlForCDN:(NSString *)urls;


+ (instancetype)manager;


- (void)reloadAgoraRtc;


- (void)destroy;




///设置视频基础数据
- (void)setVideoAgoraBase:(AgoraChannelProfile)channelProfile;

///设置语音基础数据
- (void)setVoiceAgoraBase:(AgoraChannelProfile)channelProfile;

///设置基础layout
- (void)setTranscodingAgoraBase:(AgoraLiveTranscoding *)transcoding;



@end

NS_ASSUME_NONNULL_END
