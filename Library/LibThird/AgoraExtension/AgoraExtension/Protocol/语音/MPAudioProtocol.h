//
//  MPAudioProtocol.h
//  AgoraExtension
//
//  Created by shirley on 2020/5/23.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MPAudioProtocol <NSObject>


/// 初始化语音三体云
- (void)initMPAudioRole:(int)role;


/// 创建加入房间
- (void)joinRoom:(int64_t)roomId;


///目标用户的音量大小
- (void)anchorId:(int64_t)anchorId volume:(void(^_Nullable)(NSUInteger num))block;


/// 改变用户身份
- (void)changeRole:(int)role;


/// 用户音量大小
- (void)userVolume:(void(^)(NSUInteger num, int64_t uid))block;


/** 与其他视频房间主播互动 */
- (void)connectRoom:(int64_t)roomId otherUid:(int64_t)toUid;


/** 关闭与他人互动 */
- (void)closeConnect;


/// 离开房间
- (void)leaveRoom;


@end

NS_ASSUME_NONNULL_END
