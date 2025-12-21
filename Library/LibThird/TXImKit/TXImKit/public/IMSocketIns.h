//
//  IMSocketIns.h
//  IMSocket
//
//  Created by admin on 2019/6/5.
//  Copyright © 2019 admin All rights reserved.
//



#import "ImConfig.h"
#import "ImSdkHander.h"
#import "ImMsgHander.h"
#import "IMReceiver.h"
#import "ImConversationHander.h"

#import "ImSendResult.h"
#import "ImExtraInfo.h"
@import ImSDK_Plus;
typedef void (^CallBack_SocketAck)(int code,NSString * _Nullable errMsg, NSDictionary* __nullable data);
NS_ASSUME_NONNULL_BEGIN
/// 成功通用回调
typedef void (^txIMSucc)(void);
/// 失败通用回调
typedef void (^txIMFail)(int code, NSString * desc);
 
@interface IMSocketIns : NSObject



#pragma mark - IM基本设置
/// 设置IM配置信息
/// @param cfg 配置
+(void)setConfig: (_Nonnull id<ImConfig>)cfg;

/// 初始化IM
/// @param hander IM连接监听者
+(void)initIns:(_Nullable id<ImSdkHander>)hander;

/// 退出IM 关闭后，如果重新打开，需要重新注册消息Receiver
+(void)closeIns;

/// 获取IM管理对象
+ (IMSocketIns *)getIns;

/// 判断IM登录链接状态
- (Boolean)isLogin;


#pragma mark - 消息监听设置
/// 添加普通消息监听者 归类到组
/// @param groupID 消息分组key
/// @param receiver 监听者
-(void)addReceiver:(NSString*)groupID  receiver:(id<IMReceiver>)receiver;

/// 删除本组所有的消息监听，注：会删除本组所有IMReceiver 及其它组与本组IMReceiver的MsgType相同的监听
/// @param groupID 消息分组key
-(void)removeReceiverByGroupID:(NSString*)groupID;

/// 移除所有普通消息监听
-(void)removeAllReceiver;





#pragma mark - 会话处理

/// 置顶某条会话
/// @param conversantionId 会话ID
/// @param isPinned 是否置顶
/// @param succ 成功
/// @param fail 失败
- (void)putTopCoversation:(NSString *)conversantionId isPinned:(BOOL)isPinned succ:(txIMSucc)succ fail:(txIMFail)fail;

/// 设置会话列表监听
/// @param hander 回调
- (void)addConversantionHander:(_Nullable id<ImConversationHander>)hander;

/// 删除某聊天及相应的历史信息
/// @param conversationID 会话ID
/// @param succ 成功
/// @param fail 失败
-(void)deleteCoversation:(NSString *)conversationID sucess:(txIMSucc)succ fail:(txIMFail)fail;

/// 删除全部列表
/// @param conversationList 会话ID列表
/// @param succ 成功
/// @param fail 失败
-(void)deleteAllConversation:(NSArray <NSString *>*)conversationList sucess:(txIMSucc)succ fail:(txIMFail)fail;

/// 获取会话列表
/// @param count 数目
/// @param idLessThan 搜索开始位置的消息ID
/// @param succ 成功
/// @param fail 失败
-(void)getConversationList:(int)count  idLessThan:(int64_t)idLessThan success:(void(^)(NSArray<V2TIMConversation *>*list, uint64_t nextSeq, BOOL isFinished))succ fail:(txIMFail)fail;
 
/// 获取指定的会话
/// @param conversations 指定的会话
/// @param succ 成功
/// @param fail 失败
- (void)getConversation:(NSArray <NSString *>*)conversations success:(void(^)(NSArray<V2TIMConversation *>*list))succ fail:(txIMFail)fail;

#pragma mark - 私聊消息处理
/// 设置IM私聊消息监听
/// @param hander 监听者
+(void)addImHander:(_Nullable id<ImMsgHander>)hander;
 
/// 发送私聊消息
/// @param groupOrUid 用户ID或群组ID
/// @param isGroupMsg 是否是群组消息
/// @param jsonMsgContent 消息内容
/// @param isUnreadCountMsg 是否计入已读未读消息
/// @param priority 消息重要性等级 0默认(普通消息) 1重要(如礼物) 2一般常规(普通消息) 3低级消息(如点赞)
-(ImSendResult*)sendImMsg:(int64_t)groupOrUid isGroupMsg:(Boolean)isGroupMsg jsonMsgContent:(NSDictionary*)jsonMsgContent isUnreadCountMsg:(Boolean)isUnreadCountMsg Priority:(NSUInteger)priority;

 


/// 获取某一条消息
/// @param msgCId 消息ID
-(V2TIMMessage*)getImMsg:(int64_t)msgCId;

/// 获取某个用户或群组的消息列表
/// @param count 数目
/// @param groupOrUid 群ID或用户ID
/// @param isGroupMsg 是否是群消息
/// @param lastMsg 搜索开始位置的消息
/// @param succ 成功
/// @param fail 失败
-(void)getImMsg:(int)count groupOrUid:(int64_t)groupOrUid isGroupMsg:(Boolean)isGroupMsg  lastMsg:(V2TIMMessage *)lastMsg success:(void(^)(NSArray<V2TIMMessage *> *msgs))succ fail:(txIMFail)fail;


/// 撤销某一条消息
/// @param message 消息
/// @param succ 成功
/// @param fail 失败
-(void)cancelImMsg:(V2TIMMessage*)message sucess:(txIMSucc)succ fail:(txIMFail)fail;



#pragma mark - 消息已读未读
/// 阅读某条消息
/// @param msgCId 消息ID
-(void)readImMsg:(int64_t)msgCId;
 

/// 阅读某个人或群的所有消息
/// @param groupOrUid 群ID或用户ID
/// @param isGroup 是否为群
/// @param succ 成功
/// @param fail 失败
-(void)readConversationMsg:(NSString *)groupOrUid isGroup:(Boolean)isGroup sucess:(txIMSucc)succ fail:(txIMFail)fail;

/// 所有消息已读
/// @param succ 成功
/// @param fail 失败
-(void)readAllImMsg:(txIMSucc)succ fail:(txIMFail)fail;

/// 删除某条消息
/// @param message 消息
/// @param succ 成功
/// @param fail 失败
-(void)deleteOneImMsg:(V2TIMMessage*)message sucess:(txIMSucc)succ fail:(txIMFail)fail;

 
/// 获取所有未读消息数目
/// @param succ 成功
/// @param fail 失败
-(void)getAllUnreadMsgCount:(void(^)(int totalCount))succ fail:(txIMFail)fail;

 
#pragma mark - 群事件
/// 加入群聊
/// @param gruopId 群组ID
/// @param msg 消息
/// @param succ 成功
/// @param fail 失败
- (void)joinGroupWithGroupId:(NSString *)gruopId msg:(NSString *)msg sucess:(txIMSucc)succ fail:(txIMFail)fail;

/// 退出群聊
/// @param gruopId 群组ID
/// @param succ 成功
/// @param fail 失败
- (void)quitGroupWithGroupId:(NSString *)gruopId sucess:(txIMSucc)succ fail:(txIMFail)fail;




#pragma mark - 本地数据库个人信息处理
/// 设置用户个人信息
/// @param UGID 用户或群组标识
/// @param ditExtraInfo 信息
- (void)setExtraInfo:(int64_t)UGID ditExtraInfo:(NSDictionary*)ditExtraInfo;

/// 获取用户个人信息
/// @param UGID 用户或群组标识
-(ImExtraInfo*)getExtraInfo:(int64_t)UGID;

/// 删除某人的个人信息
/// @param UGID 用户或群组标识
- (void)delExtraInfo:(int64_t)UGID;

#pragma mark -后台测试
/// 本地发送socket消息
/// @param msgType 消息主类型
/// @param msgSubType 消息子类型
/// @param message 消息内容
-(void)sendMsg:(NSString*)msgType msgSubType:(NSString*)msgSubType message:(V2TIMMessage*)message;


/// 本地发送socket消息
/// @param msgType 消息主类型
/// @param msgSubType 消息子类型
/// @param message 消息内容
/// @param callback 回调
-(void)sendMsg:(NSString*)msgType msgSubType:(NSString*)msgSubType message:(NSDictionary*)message callback:(CallBack_SocketAck)callback;

@end

NS_ASSUME_NONNULL_END
