//
//  RedPacketSendView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/17.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface RedPacketSendView : UIView


/// 显示私聊过红包的样式
/// @param importUid 单聊就是对方用户ID 群组就是群主ID
/// @param groupId 群Id 0就是单聊
+ (void)showChatMsgRedPt:(int64_t)importUid groupId:(int64_t)groupId sendType:(int)sendType;


///显示直播间的红包
+ (void)showLiveRedPtForAnchorId:(int64_t)anchorId liveType:(int)liveType roomId:(int64_t)roomId liveShowId:(NSString *)liveShowId;


@end



NS_ASSUME_NONNULL_END
