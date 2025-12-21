//
//  ChatFamilyMsgSocketTool.h

//  MessageInfo
//
//  Created by klc_sl on 2021/8/10.
//

#import <Foundation/Foundation.h>
#import <LibProjModel/IMRcvChatFamilyMsg.h>
#import <UIKit/UIKit.h>

@class AppFamilyChatroomInfoVOModel;
@class ChatFamilyMsgSocketTool;

NS_ASSUME_NONNULL_BEGIN

@protocol ChatFamilyMsgSocketDelegate <NSObject>
///点击用户头像
- (void)chatFamilyMsg:(ChatFamilyMsgSocketTool *)socketTool userInfoClick:(AppChatFamilyMsgTopVOModel *)topMsg;
///更新家族排行榜单第一位
- (void)chatFamilyMsg:(ChatFamilyMsgSocketTool *)socketTool updateTopUser:(NSString *)topUserIconStr;

@end

@interface ChatFamilyMsgSocketTool : IMRcvChatFamilyMsg


@property (nonatomic, weak)id<ChatFamilyMsgSocketDelegate>  delegate;
///群组信息
@property (nonatomic, strong)AppFamilyChatroomInfoVOModel *chatGroupInfo;


- (void)chatSocketToolParInit:(UIView *)superView groupId:(int64_t)groupId;


- (void)removeMessageSocket;

///显示群聊加入房间的消息
- (void)showJoinInfo:(AppFamilyChatroomInfoVOModel *)joinModel;



@end

NS_ASSUME_NONNULL_END
