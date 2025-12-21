//
//  ChatMsgBottomView.h
//  Message
//
//  Created by klc_sl on 2021/7/28.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageInfo/ConversationBaseInfo.h>

NS_ASSUME_NONNULL_BEGIN

@class ChatMsgBottomView;
@protocol ChatMsgBottomViewDelegate <NSObject>

///底部功能按钮
- (void)chatMsgBottomView:(ChatMsgBottomView *)bottomView featuresBtnClick:(int64_t )featuresId;

///keyboard 是否显示
- (void)chatMsgBottomView:(ChatMsgBottomView *)bottomView showKeyBoard:(BOOL)show;

///发送语音
- (void)chatMsgBottomView:(ChatMsgBottomView *)bottomView sendRecord:(NSString *)recordUrl andTimeStr:(NSString *)timeStr;

///发送文字
- (void)chatMsgBottomView:(ChatMsgBottomView *)bottomView sendInputText:(NSString *)inputText isTopMsg:(BOOL)isTopMsg;

@end


@interface ChatMsgBottomView : UIView


- (instancetype)initWithFrame:(CGRect)frame chatType:(ConversationChatForType)chatType msgSendId:(int64_t)msgSendId;

///发送置顶消息的金币值
@property (nonatomic, assign)double topMsgCoin;

@property (nonatomic, weak)id<ChatMsgBottomViewDelegate> delegate;

/// 显示聊天的功能按钮
/// @param otherUid 单聊是 对方的用户id    群聊是群主ID
/// @param otherRole 单聊时时对方的角色  群聊用不上传0
- (void)setChatOtherUid:(int64_t)otherUid otherRole:(int)otherRole;


///显示常用文字
- (void)showCommonWords:(NSArray *)array;

///隐藏键盘
- (void)hideKeyBoard;


@end

NS_ASSUME_NONNULL_END
