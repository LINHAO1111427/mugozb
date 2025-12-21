//
//  IMMsgEngine.h
//  IMSocket
//
//  Created by wy on 2020/7/15.
//  Copyright © 2020 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImSendResult.h"
#import "ImMsgHander.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    MsgPriority_default = 0, ///< 默认
    MsgPriority_high,        ///< 高优先级，一般用于礼物等重要消息
    MsgPriority_normal,      ///< 常规优先级，一般用于普通消息
    MsgPriority_low          ///< 低优先级，一般用于点赞消息
} GroupMsgPriority;//群聊消息优先级
@interface ImMsgEngine : NSObject


/// 获取ImMsgEngine对象
+(ImMsgEngine*)getIns;

/// 初始化ImMsgEngine
/// @param uid 用户ID
-(void)initIns:(int64_t)uid;

/// 关闭本地用户数据库
-(void)closeDb;

/// 设置im消息监听者
/// @param hander 监听者
+(void)setImHandle:(id<ImMsgHander>) hander;


/// 接受消息
/// @param dicMsg 消息内容
-(void)onReceivedMsg:(V2TIMMessage*)dicMsg;


/// 消息已读通知
/// @param receiptList 消息回馈
- (void)onRecvSingleChatReadReceipt:(NSArray<V2TIMMessageReceipt *> *)receiptList;


/// 收到回撤消息
/// @param msgID 消息ID
- (void)onRecvRevokedMsg:(NSString *)msgID;

/// 收到群事件消息
/// @param groupID 群组ID
/// @param data 数据
- (void)onReceiveGrupEventData:(NSString *)groupID data:(NSData *)data;

/// 发送自定义IM消息
/// @param groupOrUid 用户或者群组ID
/// @param isGroupMsg 是否是群组
/// @param jsonMsgContent 消息内容
/// @param isUnreadCountMsg 是否计入已读未读数
/// @param Priority 消息优先级
-(ImSendResult*)sendImMsg:(int64_t)groupOrUid isGroupMsg:(Boolean)isGroupMsg jsonMsgContent:(NSDictionary*)jsonMsgContent isUnreadCountMsg:(Boolean)isUnreadCountMsg Priority:(GroupMsgPriority)Priority;

@end

NS_ASSUME_NONNULL_END
