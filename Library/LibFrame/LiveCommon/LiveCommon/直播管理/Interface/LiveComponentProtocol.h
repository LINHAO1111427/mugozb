//
//  LiveComponentProtocol.h
//  LiveCommon
//
//  Created by shirley on 2021/12/31.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LiveCommon/MPLiveInterface.h>
#import <LiveCommon/OneLiveInterface.h>


NS_ASSUME_NONNULL_BEGIN

@protocol LiveComponentProtocol <NSObject>


@optional


#pragma mark - 配置的组建 -

/// 获取多人直播视频主播组件
+ (NSArray<Class> *)getAnchorVideoComptClass;

/// 获取多人直播视频观众组件
+ (NSArray<Class> *)getAudienceVideoComptClass;

/// 获取多人语音主播组件
+ (NSArray<Class> *)getAnchorAudioComptClass;

/// 获取多人语音观众组件
+ (NSArray<Class> *)getAudienceAudioComptClass;

/// 获取一对一直播视频组件
+ (NSArray<Class> *)getOTOVideoComptClass;

/// 获取一对一语音视频组件
+ (NSArray<Class> *)getOTOAudioComptClass;



#pragma mark - 配置的view -

///获得多人直播view的class
+ (Class<MPLiveInterface>)getMpVideoViewClass;

///获得多人语音view的class
+ (Class<MPLiveInterface>)getMpAudioViewClass;

///获得一对一view的class
+ (Class<OneLiveInterface>)getOtoLiveViewClass;


@end

NS_ASSUME_NONNULL_END
