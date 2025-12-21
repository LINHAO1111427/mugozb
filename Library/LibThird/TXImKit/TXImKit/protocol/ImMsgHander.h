//
//  ImMsgHander.h
//  TXImKit
//
//  Created by swh_y on 2022/5/26.
//

#ifndef IMMsgHander_h
#define IMMsgHander_h

#import "ImMessage.h"
@import ImSDK_Plus;

@protocol ImMsgHander <NSObject>
-(void) onReceiveImMsg:(ImMessage*)imMsg;

-(void) onImMsgStatusChange:(int)code message:(V2TIMMessage *)message groupOrUid:(int64_t)groupOrUid isGroupMsg:(Boolean)isGroupMsg note:(NSString*)note;


/// 收到回撤消息
/// @param msg 消息
- (void)onRecvRevokedMsg:(NSString *)msg;

/// 收到已读通知
/// @param receiptList 已读消息对象
- (void)onRecvSingleChatReadReceipt:(NSArray<V2TIMMessageReceipt *> *)receiptList;

/// 收到群事件消息
/// @param groupID 群组ID
/// @param data 数据
- (void)onReceiveGrupEventData:(NSString *)groupID data:(NSData *)data;


@optional

@end

#endif /* IMMsgHander_h */
