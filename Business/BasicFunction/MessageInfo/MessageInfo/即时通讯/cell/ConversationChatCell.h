//
//  ConversationChatCell.h
//  Message
//
//  Created by klc_tqd on 2020/5/11.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageChatModel.h"
#import "ConversationBaseInfo.h"

NS_ASSUME_NONNULL_BEGIN

@class MessageChatModel;
@class InviteOrderModel;
@class ConversationChatCell;
@class MessageUserJoinView;

@protocol ConversationChatCellDelegate <NSObject>

@optional

///播放语音
- (void)conversationChatCell:(ConversationChatCell *)cell voicePlayStatus:(BOOL)isPlay;
///重发消息
- (void)conversationChatCell:(ConversationChatCell *)cell resendMessage:(BOOL)resend;
///购物
- (void)conversationChatCell:(ConversationChatCell *)cell shopChat:(MessageChatModel *)model;
///订单
- (void)conversationChatCell:(ConversationChatCell *)cell invitOrder:(InviteOrderModel *)model;
///点击用户头像
- (void)conversationChatCell:(ConversationChatCell *)cell userInfoClick:(SendMsgUserInfoObj *)model;
///点击红包
- (void)conversationChatCell:(ConversationChatCell *)cell redPacket:(MessageRedPacketModel *)model;
///点击欢迎
- (void)conversationChatCell:(ConversationChatCell *)cell welcomeUser:(GroupUserJoinFamilyObj *)model;
///删除改条消息
- (void)conversationChatCell:(ConversationChatCell *)cell deleteMsg:(MessageChatModel *)model;
///求赏送礼物
- (void)conversationChatCell:(ConversationChatCell *)cell sendAskGift:(MessageAskGiftModel *)model;
///阅后即焚图片
- (void)conversationChatCell:(ConversationChatCell *)cell showOncePic:(MessageShowOncePicModel *)model;
///撤回操作
- (void)conversationChatCell:(ConversationChatCell *)cell cancelMsg:(MessageChatModel *)model;

@end

@interface ConversationChatCell : UITableViewCell

@property (nonatomic, assign)ConversationChatForType chatType;

@property(nonatomic,strong)MessageChatModel *mModel;

@property(nonatomic,copy)void(^clickHeaderImageBlock)(int64_t uid);

@property(nonatomic,assign)BOOL isPlayingVoice;

@property(nonatomic,weak)id<ConversationChatCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
