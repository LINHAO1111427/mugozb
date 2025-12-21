//
//  AgoraExtManager.h
//  AgoraExtension
//
//  Created by shirley on 2020/5/16.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AgoraExtension/AgoraManagerConfig.h>

#import <AgoraExtension/LiveMusicProtocol.h>
#import <AgoraExtension/MPVideoProtocol.h>
#import <AgoraExtension/LivePubProtocol.h>
#import <AgoraExtension/MPAudioProtocol.h>
#import <AgoraExtension/O2OVideoProtocol.h>
 

NS_ASSUME_NONNULL_BEGIN

@interface AgoraExtManager : NSObject


#pragma mark - 公用方法

///必传否则无法使用
+ (void)setConfig:(Class<AgoraManagerConfig>)config;


///断开链接
+ (void)disconnect;

#pragma mark - 每个独立的功能

///音乐管理
+ (id<LiveMusicProtocol>)music;

///公共方法管理
+ (id<LivePubProtocol>)pubMethod;

///一对一视频
+ (id<O2OVideoProtocol>)otoVideo;


///多人直播
+ (id<MPVideoProtocol>)mpVideo;


///多人语音
+ (id<MPAudioProtocol>)mpAudio;



@end

NS_ASSUME_NONNULL_END
