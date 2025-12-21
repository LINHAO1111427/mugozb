//
//  SendIMMessageObj.h
//  LibProjView
//
//  Created by klc_sl on 2021/7/22.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TXImKit/TXImKit.h>
@class V2TIMMessage;
@class ApiGiftSenderModel;

typedef NS_ENUM(NSUInteger, IMMessageType) {
    ///未知消息
    IMMessageTypeForunknown = -1,
    ///通用消息 - 图片
    IMMessageTypeForPicture = 0,
    ///通用消息 - 礼物
    IMMessageTypeForGift = 1,
    ///通用消息 - 音频
    IMMessageTypeForAudio = 2,
    ///通用消息 - 视频
    IMMessageTypeForVideo = 3,
    ///通用消息 - 1v1语音
    IMMessageTypeFor1v1Voice = 4,
    ///通用消息 - 1v1视频
    IMMessageTypeFor1v1Video = 5,
    ///通用消息 - 红包      ///已废弃
    IMMessageTypeForRedPack = 6,
    ///通用消息 - 邀约（寻觅）订单
    IMMessageTypeForInviteOrder = 7,
    ///通用消息 - 文本消息
    IMMessageTypeForText = 8,
    ///通用消息 - 群组提示
    IMMessageTypeForGroupTip = 9,
    ///通用消息 - 购物消息
    IMMessageTypeForShopping = 10,
    ///通用消息 - 查看一次图片
    IMMessageTypeForShowOncePic = 11,
    
    ///系统消息 - 进家族发红包的消息
    IMSystemMsgTypeForGroupRedPt = 1101,
    ///系统消息 - 领红包的消息
    IMSystemMsgTypeForOpenRedPt = 1102,
    ///系统消息 - 用户加入家族的消息
    IMSystemMsgTypeForJoinFamily = 1201,
    ///系统消息 - 主播求赏信息
    IMSystemMsgTypeForAskGift = 1301,
    ///系统消息 - 发送语音的检测结果
    IMSystemMsgTypeForVoiceCheck = 1001,
    
    

};

///信息的状态值（与message.sendStatus）
typedef NS_ENUM(NSUInteger, IMMessageSendStatus) {
    ///发送成功
    IMMessageSendStatusForSuccess          = 1,
    ///发送超时
    IMMessageSendStatusForTimeout          = 4,
    ///发送失败
    IMMessageSendStatusForFail             = 0,
    ///家族已经解散
    IMMessageSendStatusForGroupDissolve   = 404,
    ///已被踢出家族
    IMMessageSendStatusForGroupKicked     = 405,
    ///发送已被禁言
    IMMessageSendStatusForSilenced         = 701,
    ///发送等待中
    IMMessageSendStatusForWaiting          = 999,
    ///发送消息检测中
    IMMessageSendStatusForCheck            = 1998,
    ///发送检测信息没过关
    IMMessageSendStatusForCheckFail        = 1999,
    
};

///信息更新的类型
typedef NS_ENUM(NSUInteger, IMMessageUpDateType) {
    ///单聊消息被阅读
    IMMessageUpDateTypeForRead            = 1,
    ///回撤消息
    IMMessageUpDateTypeForRevoke          = 2,
    ///消息状态
    IMMessageUpDateTypeForStatus          = 3,
    ///其他的
    IMMessageUpDateTypeForOther           = 4,
};
typedef void(^_Nullable SendIMMessageBlock)(BOOL success);

NS_ASSUME_NONNULL_BEGIN



@interface SendIMMessageObj : NSObject

///添加监听
- (void)addMonitor:(int64_t)messageId isGroup:(BOOL)isGroup;
///删除监听
- (void)removeMonitor;

///监听接收消息的回调
@property (nonatomic, copy) void(^onReceiveIMMessage)(ImMessage *message);
///监听发送消息的结果的回调
@property (nonatomic, copy) void(^onSendIMMessage)(ImMessage *message);
///更新消息回调
@property (nonatomic, copy) void(^onUpdateIMMessage)(IMMessageUpDateType type,NSString *idStr, ImMessage *message);
 

/// 发送私信消息
/// @param messageType 消息类型
/// @param customDict 自定义消息
/// @param muteMsg 是否静音消息
/// @param resultBlock 结果回调
- (void)sendMessageType:(IMMessageType)messageType customDict:(NSDictionary *)customDict muteMsg:(BOOL)muteMsg sendResult:(SendIMMessageBlock)resultBlock;



@end








@interface IMInfoManager : NSObject

///删除某个用户的信息
+ (void)deleteUserExtraInfo:(int64_t)userId;

///删除家族群组信息
+ (void)deleteFamilyGroupExtraInfo:(int64_t)groupId;

///删除粉丝团群组信息
+ (void)deleteFansGroupExtraInfo:(int64_t)anchorId;


@end



NS_ASSUME_NONNULL_END
