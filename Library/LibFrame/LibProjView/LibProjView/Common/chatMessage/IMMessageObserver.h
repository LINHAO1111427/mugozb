//
//  IMMessageObserver.h
//  LibProjView
//
//  Created by klc_sl on 2021/7/27.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TXImKit/TXImKit.h>
 
NS_ASSUME_NONNULL_BEGIN

///聊天消息代理类
@protocol IMMessageDelegate <NSObject>

/// 发送消息结果返回回调 ///暂没被调用
@optional
- (void)onSendMessageResponse:(ImMessage *)message;

/// 接收消息(服务器端下发的)回调
@optional
- (void)onReceiveMessage:(ImMessage *)message;

/// 更改某条消息内容（变更状态，或者删除）
@optional
- (void)onUpdateMessage:(ImMessage *)message;

 
@optional

/// 某条消息已读
/// @param userOrGroupId 用户ID或群ID
- (void)onUpdateReadMessage:(NSString *)userOrGroupId;

/// 撤销某条消息
/// @param msgId 消息ID
@optional
- (void)onUpdateRevokMessage:(NSString *)msgId;
@end



///会话消息代理类
@protocol IMConversationDelegate <NSObject>

/// 会话信息变更通知
@optional
- (void)onConversationChanged:(NSArray<V2TIMConversation*> *) conversationList;
 
@end



@protocol IMObserverDelegate <IMMessageDelegate,IMConversationDelegate>

@end










@interface IMMessageObserver : NSObject


+ (void)onImHandle;


+ (void)addDelegate:(id<IMObserverDelegate>)delegate;


+ (void)removeDelegate:(id<IMObserverDelegate>)delegate;


@end

NS_ASSUME_NONNULL_END
