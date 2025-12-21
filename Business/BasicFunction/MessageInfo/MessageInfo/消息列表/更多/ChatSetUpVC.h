//
//  ChatSetUpVC.h
//  Message
//
//  Created by klc_tqd on 2020/5/14.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConversationBaseInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatSetUpVC : UIViewController

///0 单聊 1 群聊
@property (nonatomic, assign)ConversationChatForType chatType;

@property (nonatomic, assign)int64_t msgId;

@end

NS_ASSUME_NONNULL_END
