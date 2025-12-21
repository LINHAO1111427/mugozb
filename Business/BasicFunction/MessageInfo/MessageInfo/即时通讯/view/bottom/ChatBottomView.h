//
//  ChatBottomView.h
//  Message
//
//  Created by klc_tqd on 2020/5/11.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import "ConversationBaseInfo.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ChatBottomViewDelegate <NSObject>
@optional

- (void)sendMessageToOther:(NSString *)inputText;

- (void)sendMessageToOtherNoti:(NSString *)inputText andUserArr:(NSArray *)userArr andIsAtAll:(BOOL)isAtAll;

- (void)featuresBtnClick:(int64_t )featuresId;

- (void)clickFaceBtn:(UIButton *)sender;

///键盘隐藏或者将要显示
- (void)keyBoardWillShow:(BOOL)isShow;

@end

@interface ChatBottomView : UIView

- (instancetype)initWithFrame:(CGRect)frame chatType:(ConversationChatForType)chatType;

@property(nonatomic, weak)id<ChatBottomViewDelegate> delegate;

@property(nonatomic ,weak)UITextView *chatTextView;

@property(nonatomic, weak)UIButton *faceBtn;
///发送置顶消息的金币值
@property (nonatomic, assign)double topMsgCoin;
///NO 单聊  YES 群聊
@property(nonatomic, assign, readonly)BOOL isGroupMsg;
///群组ID
@property(nonatomic,assign)int64_t groupId;
///是否为置顶消息
@property (nonatomic, assign)BOOL isTopMsg;

/// 设置功能按钮
/// @param otherUid 单聊：对方ID。  群聊：群主Id
/// @param otherRole 单聊：对方的角色。群聊 ：无
-(void)setChatOtherUid:(int64_t)otherUid otherRole:(int)otherRole;


//-(void)addUserNotice:(JMSGUser *)user andIsAtAll:(BOOL)isAtAll;


-(void)sendTextMessage;

@end

NS_ASSUME_NONNULL_END
