//
//  ChatGiftSocketTool.h
//  Message
//
//  Created by klc_tqd on 2020/5/21.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LibProjModel/IMRcvLiveGiftSend.h>
#import <UIKit/UIKit.h>
#import "ConversationBaseInfo.h"

NS_ASSUME_NONNULL_BEGIN
 
@interface ChatGiftSocketTool : IMRcvLiveGiftSend

- (void)chatSocketToolParInit:(UIView *)superView sendMsgId:(int64_t)sendMsgId chatType:(ConversationChatForType)chatType;

- (void)removeMessageSocket;


///  全直播间飘屏信息
/// @param apiGiftSender  内容
- (void)onGiftMsgAll:(ApiGiftSenderModel *)apiGiftSender;

///  单聊送礼物
/// @param apiGiftSender  内容
- (void)onGiveGiftUser:(ApiGiftSenderModel *)apiGiftSender;

///群聊送礼物
- (void)onGroupGiveGift:(ApiGiftSenderModel* )apiGiftSender;
@end

NS_ASSUME_NONNULL_END
