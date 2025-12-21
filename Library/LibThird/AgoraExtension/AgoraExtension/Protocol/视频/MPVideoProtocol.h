//
//  MPVideoProtocol.h
//  AgoraExtension
//
//  Created by shirley on 2020/1/10.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(int, RTCForPlayStatus) {
    ///视频开始播放
    RTCForPlayerPlaying,
    ///视频播放结束
    RTCForPlayerStopped,
};

typedef NS_ENUM(int, RTCForMPVideoConnectStatus) {
    ///用户连接成功
    RTCForMPVideoConnectInviteSuccess    =1,
    ///用户连接失败
    RTCForMPVideoConnectInviteFail       =2,
    ///用户连接成功
    RTCForMPVideoConnectJoinSuccess      =3,
    ///用户连接失败
    RTCForMPVideoConnectJoinFail         =4,
    ///用户退出连接
    RTCForMPVideoConnectLeaveSuccess     =5,
};



@protocol MPVideoProtocol <NSObject>

///用户播放视频状态
@property (nonatomic, copy)void(^playStatusBlock)(RTCForPlayStatus status);

///用户播放视频状态
@property (nonatomic, copy)void(^onConnectStatusBlock)(RTCForMPVideoConnectStatus status, NSString *statusStr);

///拉流地址
@property (nonatomic, copy)NSString *pullStr;

/// 初始化基础信息
/// @param role 用户角色   主播=1 // 副播=2 // 观众(默认) =3
- (void)initMPVideoRole:(int)role;

///画面截取（可设置可不设置）
- (void)setSnasshotTime:(int)time videoFrame:(void(^)(UIImage *image))videoFrame;

///主播预览视图
- (void)preview:(UIImageView *)preview isOpen:(BOOL)isOpen;

/** 主播用-创建直播房间配置基础数据 */
- (void)createVideo:(int64_t)roomId;

/** 主播用-与其他视频房间主播互动 */
- (void)connectVideo:(int64_t)roomId showV:(UIImageView *)showV disconnectBlock:(void(^)(void))disconnect;

/** 主播用-显示连麦的视图 */
- (void)showLinkMicV:(UIImageView *)showV;

/** 用户用-加入直播房间 */
- (void)joinVideo:(int64_t)roomId anchorId:(int64_t)anchorId showV:(UIImageView *)showV;

- (void)joinLookVideo:(int64_t)roomId anchorId:(int64_t)anchorId showV:(UIImageView *)showV;

/** 用户用-播放视频 */
- (void)playVideoUrl:(NSString *)url showV:(UIImageView *)showV thumb:(NSString *)thumb;

/** 主播用--关闭与他人连麦视图 */
- (void)closeConnect;

/** 观众用---与主播断开连麦 */
- (void)leaveRoomToPlay;

/** 离开 */
- (void)leaveRoom;

/** 美颜 */
- (void)showBeautyInView:(UIView * _Nullable)superV complete:(void (^)(void))complete;

/** 切换摄像头 */
- (void)switchCamera;


@end

NS_ASSUME_NONNULL_END
