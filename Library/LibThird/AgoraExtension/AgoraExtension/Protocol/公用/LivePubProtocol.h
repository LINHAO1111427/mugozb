//
//  LivePubProtocol.h
//  AgoraExtension
//
//  Created by shirley on 2020/3/16.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(int, RTCForUserStatus) {
    ///进入房间
    RTCForJoinedRoom      =1,
    ///更新token
    RTCForUpdateToken     =2,
    ///离开房间
    RTCForLeaveRoom       =3,
};

typedef NS_ENUM(int, RTCForNetQualityStatus) {
    ///网络质量不好
    RTCForNetQualityBad,
    ///网络质量好
    RTCForNetQualityGood,
};

@protocol LivePubProtocol <NSObject>

///用户进出直播间状态
@property (nonatomic, copy)void(^userStatusBlock)(RTCForUserStatus status, NSString *statusStr);

///网络连接状态
@property (nonatomic, copy)void(^netQualityStatusBlock)(RTCForNetQualityStatus status);


/**  关闭/打开本地视频  YES: 关闭，NO: 打开 */
- (void)localVideoClosed:(BOOL)close;
/**  关闭/打开本地音频  YES: 关闭, NO: 打开 */
- (void)localAudioClosed:(BOOL)close;
/**  关闭/打开远程音频  YES: 关闭, NO: 打开 */
- (void)remoteVoiceClosed:(BOOL)close;
/**  关闭/打开远程视频  YES: 关闭, NO: 打开 */
- (void)remoteVideoClosed:(BOOL)close;


@end

NS_ASSUME_NONNULL_END
