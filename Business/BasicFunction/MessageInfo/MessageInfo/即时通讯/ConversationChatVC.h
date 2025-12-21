//
//  ConversationChatVC.h
//  Message
//
//  Created by klc_tqd on 2020/5/11.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageInfo/ConversationBaseInfo.h>


NS_ASSUME_NONNULL_BEGIN

//#define BottomViewHeight 144


@interface ConversationChatVC : UIViewController

///0单聊  1家族群聊  2聊天广场  3粉丝团
@property (nonatomic,assign)ConversationChatForType chatType;
///chatType=0时 msgId是对方用户ID        chatType=1时，msgId是群组ID
@property (nonatomic,assign)int64_t msgSendId;

@property (nonatomic,copy)NSString *navTitle;

@end

NS_ASSUME_NONNULL_END
