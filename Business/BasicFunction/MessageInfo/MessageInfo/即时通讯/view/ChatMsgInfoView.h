//
//  ChatMsgInfoView.h

//  MessageInfo
//
//  Created by klc_sl on 2021/8/9.
//

#import <UIKit/UIKit.h>
#import <TXImKit/TXImKit.h>
#import "ConversationBaseInfo.h"
#import "MessageChatModel.h"

NS_ASSUME_NONNULL_BEGIN
@class ChatMsgInfoView;

@protocol ChatMsgInfoDelegate <NSObject>

///隐藏键盘
- (void)chatMsgInfoScrollForHideKeyBorad:(ChatMsgInfoView *)msgInfoView;
///消息发送
- (void)chatMsgInfo:(ChatMsgInfoView *)msgInfoView sendMsg:(NSDictionary *)sendMsg messageType:(IMMessageType)messageType;
///点击用户头像，操作处理
- (void)chatMsgInfo:(ChatMsgInfoView *)msgInfoView userInfoHandle:(SendMsgUserInfoObj *)userInfo;
///赠送求赏的礼物
- (void)chatMsgInfo:(ChatMsgInfoView *)msgInfoView sendAskGift:(MessageAskGiftModel *)askGift userInfo:(SendMsgUserInfoObj *)userInfo;

@end

@interface ChatMsgInfoView : UIView

- (instancetype)initWithMsgSendId:(int64_t)msgSendId chatType:(ConversationChatForType)chatType;

@property (nonatomic, weak)id<ChatMsgInfoDelegate> msgDelegate;
///
@property (nonatomic, weak)UIViewController *superVC;
 
///添加一条新消息
- (void)addShowIMMessage:(ImMessage *)message;

///更新一条已发送的数据
- (void)updateMySendMsg:(ImMessage *)message;

///滚动到消息底部
- (void)scrollMessageBottom;

///停止播放声音
- (void)stopPlayVoice;

/// 消息被阅读
/// @param userOrGroupId ID
- (void)readMsg:(NSString *)userOrGroupId;

/// 消息被撤回
/// @param msgId 消息ID
- (void)revokMsg:(NSString *)msgId;
 
@end

NS_ASSUME_NONNULL_END
