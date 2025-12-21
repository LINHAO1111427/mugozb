//
//  MessageModel.h
//  Message
//
//  Created by klc_tqd on 2020/5/14.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LibProjView/SendIMMessageObj.h>
#import <TXImKit/TXImKit.h>
#import "MessageContentObj.h"
#import "MessageContentObj.h"

 
NS_ASSUME_NONNULL_BEGIN


@interface GroupMessageObj : NSObject

///群聊中 群组ID
@property (nonatomic, assign)int64_t groupId;
///群组图片
@property (nonatomic, copy)NSString *groupPic;
///群组名称
@property (nonatomic, copy)NSString *groupName;
///群组等级
@property (nonatomic, copy)NSString *groupLevel;
///群组类型  0: 家族||广场。   1 粉丝团
@property (nonatomic, assign)int groupType;

@end


@interface SingleMessageObj : NSObject

///单聊中对方用户的ID
@property (nonatomic, assign)int64_t otherUid;
///对方用户名
@property (nonatomic, copy) NSString *otherUserName;
///对方头像地址
@property (nonatomic, copy) NSString *otherUserAvater;
///贵族勋章
@property (nonatomic, copy)NSString *otherNobleMedalStr;

///svip
@property (nonatomic, copy)NSString *svipIcon;
///性别
@property (nonatomic, assign)int sex;
///年龄
@property (nonatomic, assign)int age;
///角色
@property (nonatomic, assign)int role;
@end


@interface SendMsgUserInfoObj : NSObject

///发消息人的Id
@property (nonatomic, assign)int64_t userId;
///发消息人的头像
@property (nonatomic, copy)NSString *avatar;
///发消息人的名称
@property (nonatomic, copy)NSString *userName;
///发消息人的年龄
@property (nonatomic, assign)int age;
///发消息人的性别
@property (nonatomic, assign)int gender;
///发消息人的vip头像框
@property (nonatomic, copy)NSString *nobleFrameStr;
///发消息人的财富等级图标
@property (nonatomic, copy)NSString *wealthLevelStr;
///发消息人的ViP图标
@property (nonatomic, copy)NSString *nobleLevelStr;
///贵族勋章
@property (nonatomic, copy)NSString *nobleMedalStr;


@end




@interface MessageChatModel : NSObject

///消息类型
@property (nonatomic, assign) IMMessageType messageType;
///返回的数据
@property (nonatomic, strong) ImMessage * imMessage;
///发送的自定义消息
@property (nonatomic, copy) NSDictionary *customDict;
///消息扩充信息
@property (nonatomic, copy) NSDictionary *msgExtraDict;
///会话排序的 orderKey
@property (nonatomic, assign) NSUInteger orderKey;


#pragma mark -消息内容-
///消息的时间
@property (nonatomic, copy) NSDate *messageTimeDate;
///cell的高度
@property (nonatomic, assign) CGFloat messageCellHeight;
///内容的宽度
@property (nonatomic, assign) CGFloat messageWidth;
///是否显示时间
@property (nonatomic, assign) BOOL isShowTime;
///时间的高度
@property (nonatomic, assign) CGFloat messageTimeHeight;
///是否是自己消息
@property (nonatomic, assign) BOOL isOwner;
///是否为群组消息
@property (nonatomic, assign) BOOL isGroupMsg;
///消息标题
@property (nonatomic, copy) NSString *msgTitle;
///是否为撤销消息
@property (nonatomic, assign) BOOL isCancelMsg;


#pragma mark - 会话专用
///置顶ID
@property (nonatomic, assign) BOOL isTop;
///未读数
@property (nonatomic, assign) NSInteger unReadNum;
///展示名字
@property (nonatomic, copy) NSString *showName;
///会话id
@property (nonatomic, copy) NSString *conversationID;

#pragma mark -发送人信息-
@property (nonatomic, strong)SendMsgUserInfoObj *sendUserInfo;


#pragma mark -聊天信息-
///群聊消息数据
@property (nonatomic, strong)GroupMessageObj *groupMsg;
///私聊消息数据
@property (nonatomic, strong)SingleMessageObj *singleMsg;





#pragma mark -消息内容-
///文字消息
@property (nonatomic, strong)MessageTextModel *textMsg;
///红包消息
@property (nonatomic, strong)MessageRedPacketModel *redPacketMsg;
///发送语音内容
@property (nonatomic, strong)MessageVoiceModel *voiceMsg;
///oto语音聊天&视频聊天
@property (nonatomic, strong)MessageOtoCallModel *otoCallMsg;
///图片消息
@property (nonatomic, strong)MessagePictureModel *picMsg;
///邀请订单
@property (nonatomic, strong)InviteOrderModel *inviteOrderMsg;
///购物消息
@property (nonatomic, strong)ShopMessageModel *shoppingMsg;
///礼物消息
@property (nonatomic, strong)SendGiftInfoModel *giftMsg;
///求聊消息
@property (nonatomic, strong)MessageAskGiftModel *askGiftMsg;
///阅后即焚
@property (nonatomic, strong)MessageShowOncePicModel *oncePicMsg;



///群组系统提示纯文字消息
@property (nonatomic, strong)GroupSystemNormalMsgObj *sysNoticeMsg;
///群组系统用户开启红包消息
@property (nonatomic, strong)GroupOpenRedPacketMsgObj *sysOpenRedPtMsg;
///群组系统用户加入群聊消息
@property (nonatomic, strong)GroupUserJoinFamilyObj *sysJoinFamilyMsg;



- (instancetype)initWithChatMessage:(V2TIMMessage *)message;

+ (CGSize)getTextSizeWithContentString:(NSString *)contentString;




@end

NS_ASSUME_NONNULL_END
