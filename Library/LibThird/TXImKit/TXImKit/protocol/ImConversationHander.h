//
//  ImCoversationHander.h
//  TXImKit
//
//  Created by swh_y on 2022/5/31.
//

#ifndef ImConversationHander_h
#define ImConversationHander_h
@import ImSDK_Plus;

@protocol ImConversationHander <NSObject>
@optional


/// 有新的会话
/// @param conversationList 会话列表
- (void)ImNewConversationIn:(NSArray<V2TIMConversation*> *) conversationList;


/// 会话消息发生改变
/// @param conversationList 会话列表
- (void)ImConversationChanged:(NSArray<V2TIMConversation*> *) conversationList;


/// 消息总未读数发生改变
/// @param totalUnreadCount 未读数
- (void)ImTotalUnreadMessageCountChanged:(UInt64) totalUnreadCount;
@end
#endif /* ImConversationHander */
