//
//  AgoraBase.h
//  AgoraExtension
//
//  Created by shirley on 2020/9/8.
//  Copyright © 2019 XTY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AgoraRtcManager.h>
#import <LivePubProtocol.h>
#import <AgoraExtension/LiveMusicProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgoraBase : NSObject<LivePubProtocol,LiveMusicProtocol>

/// 1 主播 2观众
@property (nonatomic, assign) AgoraClientRole clientRole;     //当前用户角色
@property (nonatomic, assign) AgoraChannelProfile channelProfile;    ///频道


///加入房间
- (void)joinRoom:(int64_t)roomId didJoinSuccess:(void(^_Nullable)(AgoraRtcEngineKit *engine))joinBlock;

///离开房间
- (void)leaveRoom:(int64_t)roomId didLeaveSuccess:(void(^_Nullable)(AgoraRtcEngineKit *engine))leaveBlock;


///跨频道连麦的token
- (void)getConnectRoomId:(int64_t)roomId mediaRelayToken:(void(^)(BOOL success, NSString *srcToken, NSString *destToken))tokenBlock;

@end

NS_ASSUME_NONNULL_END
