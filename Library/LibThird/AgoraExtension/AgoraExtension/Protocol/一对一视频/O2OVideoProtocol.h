//
//  O2OVideoProtocol.h
//  AgoraExtension
//
//  Created by shirley on 2020/1/4.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol O2OVideoProtocol <NSObject>

/// 初始化基础信息
/// @param role 用户角色   主播=1 // 副播=2 // 观众(默认) =3
- (void)initO2OVideoRole:(int)role;

///画面截取（可设置可不设置）
- (void)setSnasshotTime:(int)time videoFrame:(void(^)(UIImage *image))videoFrame;

///预览
- (void)preview:(UIImageView *)preview;

/** 创建直播房间配置基础数据 */
- (void)joinRoom:(int64_t)roomId;

/** 设置用户的连麦视图 */
- (void)addConnectMicV:(UIImageView *)showV otherUid:(int64_t)uid;

/** 副播进出房间---回调的信息 */
- (void)userInfoBlock:(void(^)(BOOL isOut, int64_t userId, UIImageView *_Nullable userImageV))userBlock;

/** 关闭其中一个用户 */
- (void)closeUser:(int64_t)userId;

/// 断开链接
- (void)disconnect;

/** 离开 */
- (void)leaveRoom;

/** 美颜 */
- (void)showBeautyInView:(UIView * _Nullable)superV complete:(void (^)(void))complete;

/** 切换摄像头 */
- (void)switchCamera;


@end

NS_ASSUME_NONNULL_END
