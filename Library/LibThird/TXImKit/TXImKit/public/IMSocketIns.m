//
//  IMSocketIns.m
//  IMSocket
//
//  Created by admin on 2019/6/5.
//  Copyright © 2019 admin All rights reserved.
//
#import <Foundation/Foundation.h>
#import "IMSocketIns.h"
#import "ImApiEngine.h"
#import "ImMsgEngine.h"
#import "ImDataBase.h"
#import "ImMessage.h"
#import <LibTools/LibTools.h> 
 

static IMSocketIns *_imIns = nil;
static id<ImConfig> _socketCfg = nil;
static id<ImSdkHander> _sdkHander = nil;//连接状态
static id<ImConversationHander> _conversationHander = nil;//会话
@interface IMSocketIns ()<V2TIMSDKListener,V2TIMAdvancedMsgListener,V2TIMConversationListener>

@end


@implementation IMSocketIns
#pragma mark - IM基本设置（开启与关闭） ～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～
/// 设置IM配置信息
/// @param cfg 配置
+(void)setConfig: (_Nonnull id<ImConfig>)cfg{
    _socketCfg = cfg;
    if(_socketCfg != nil) {
        V2TIMSDKConfig *config = [[V2TIMSDKConfig alloc] init];
        config.logLevel = V2TIM_LOG_INFO;
        int appId =  [[NSString stringWithFormat:@"%lld",[cfg getImKey]] intValue];
        [[V2TIMManager sharedInstance] initSDK:appId config:config];
//        NSString *versaion =  [[V2TIMManager sharedInstance] getVersion];
//       // NSLog(@"过滤文字####【TXImKit】#### - sdk版本 == %@"),versaion);
        [[V2TIMManager sharedInstance] addIMSDKListener:[IMSocketIns getIns]];
        [[V2TIMManager sharedInstance] addAdvancedMsgListener:[IMSocketIns getIns]];
        [[V2TIMManager sharedInstance] addConversationListener:[IMSocketIns getIns]];
    }
}

/// 初始化IM
/// @param hander IM连接监听者
+(void)initIns:(_Nullable id<ImSdkHander>)hander{
    _sdkHander = hander;
    
    if (_socketCfg != nil) {
        int64_t uid =[_socketCfg getUserID];
        ImApiEngine* apiEngine=[[ImApiEngine alloc] init];
        [apiEngine initIns:uid];
        
        ImMsgEngine * msgEngine=[[ImMsgEngine alloc] init];
        [msgEngine initIns:uid];
        __weak NSString *userID = [NSString stringWithFormat:@"%lld",[_socketCfg getUserID]];
        [_socketCfg getImUserSig:^(NSString *userSig) {
            if (userSig.length > 0) {
                [[V2TIMManager sharedInstance] login:userID userSig:userSig succ:^{
                    if (_sdkHander) {
                        [_sdkHander onConnect:YES];
                    }
                } fail:^(int code, NSString *desc) {
                    if (_sdkHander) {
                        [_sdkHander onConnect:NO];
                    }
                }];
            }else{
                if (_sdkHander) {
                    [_sdkHander onConnect:NO];
                }
            }
             
        }];
         
    }
    
    
}


/// 退出IM 关闭后，如果重新打开，需要重新注册消息Receiver
+(void)closeIns{
    [[V2TIMManager sharedInstance] logout:^{
        _socketCfg = nil;
       // NSLog(@"过滤文字####【TXImKit】#### - 退出IM登录成功"));
        [[V2TIMManager sharedInstance]removeAdvancedMsgListener:[IMSocketIns getIns]];
        [[V2TIMManager sharedInstance]removeConversationListener:[IMSocketIns getIns]];
        [[IMSocketIns getIns] removeAllReceiver];
    } fail:^(int code, NSString *desc) {
       // NSLog(@"过滤文字####【TXImKit】#### - 退出IM登录失败"));
    }];
}

/// 获取IM管理对象
+ (IMSocketIns *)getIns{
    if(_imIns==nil)
    {
        _imIns=[IMSocketIns new];
    }
    return _imIns;
}

/// 判断IM登录链接状态
-(Boolean)isLogin{
    V2TIMLoginStatus status = [[V2TIMManager sharedInstance] getLoginStatus];
    if (status == V2TIM_STATUS_LOGOUT) {
        return NO;
    }
    return YES;
    
}


#pragma mark - 消息监听设置

/// 添加普通消息监听者 归类到组
/// @param groupID 消息分组key
/// @param receiver 监听者
-(void)addReceiver:(NSString*)groupID  receiver:(id<IMReceiver>)receiver{
    [[ImApiEngine getIns] addReceiver:groupID receiver:receiver];
}

/// 删除本组所有的消息监听
/// @param groupID 消息分组key
-(void)removeReceiverByGroupID:(NSString*)groupID{
    [[ImApiEngine getIns] removeReceiverByGroupID:groupID];
}

/// 移除所有普通消息监听
-(void)removeAllReceiver{
    [[ImApiEngine getIns] removeAllReceiver];
}

#pragma mark - 会话列表  ～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～

/// 置顶某条会话
/// @param conversantionId 会话ID
/// @param isPinned 是否置顶
/// @param succ 成功
/// @param fail 失败
- (void)putTopCoversation:(NSString *)conversantionId isPinned:(BOOL)isPinned succ:(txIMSucc)succ fail:(txIMFail)fail{
    [[V2TIMManager sharedInstance] pinConversation:conversantionId isPinned:isPinned succ:succ fail:fail];
}
/// 设置会话列表监听
/// @param hander 回调
- (void)addConversantionHander:(_Nullable id<ImConversationHander>)hander{
    _conversationHander = hander;
}
/// 获取会话列表
/// @param count 数目
/// @param idLessThan 搜索开始位置的消息ID
/// @param succ 成功
/// @param fail 失败
-(void)getConversationList:(int)count  idLessThan:(int64_t)idLessThan success:(void(^)(NSArray<V2TIMConversation *>*list, uint64_t nextSeq, BOOL isFinished))succ fail:(txIMFail)fail{
    [[V2TIMManager sharedInstance] getConversationList:idLessThan count:count succ:succ fail:fail];
    
}

/// 获取指定的会话
/// @param conversations 指定的会话
/// @param succ 成功
/// @param fail 失败
- (void)getConversation:(NSArray <NSString *>*)conversations success:(void(^)(NSArray<V2TIMConversation *>*list))succ fail:(txIMFail)fail{
    [[V2TIMManager sharedInstance] getConversationList:conversations succ:succ fail:fail];
}

/// 获取某个用户或群组的消息列表
/// @param count 数目
/// @param groupOrUid 群ID或用户ID
/// @param isGroupMsg 是否是群消息
/// @param lastMsg 搜索开始位置的消息
/// @param succ 成功
/// @param fail 失败
-(void)getImMsg:(int)count groupOrUid:(int64_t)groupOrUid isGroupMsg:(Boolean)isGroupMsg  lastMsg:(V2TIMMessage *)lastMsg success:(void(^)(NSArray<V2TIMMessage *> *msgs))succ fail:(txIMFail)fail{
    NSString *userid = @"";
    NSString *groupId = @"";
    if (isGroupMsg) {
        groupId = [NSString stringWithFormat:@"%lld",groupOrUid];
    }else{
        userid = [NSString stringWithFormat:@"%lld",groupOrUid];
    }
    V2TIMMessageListGetOption *option = [[V2TIMMessageListGetOption alloc] init];
    option.getType = V2TIM_GET_CLOUD_OLDER_MSG;
    option.userID = userid;
    option.groupID = groupId;
    option.count = count;
    option.lastMsg = lastMsg;
    [[V2TIMManager sharedInstance] getHistoryMessageList:option succ:succ fail:fail];
}
 
 
#pragma mark - 私聊消息处理

/// 设置IM私聊消息监听
/// @param hander 监听者
+(void)addImHander:(_Nullable id<ImMsgHander>)hander{
    [ImMsgEngine setImHandle:hander];
}

/// 发送私聊消息
/// @param groupOrUid 用户ID或群组ID
/// @param isGroupMsg 是否是群组消息
/// @param jsonMsgContent 消息内容
/// @param isUnreadCountMsg 是否计入已读未读消息
/// @param priority 消息重要性等级
-(ImSendResult*)sendImMsg:(int64_t)groupOrUid isGroupMsg:(Boolean)isGroupMsg jsonMsgContent:(NSDictionary*)jsonMsgContent isUnreadCountMsg:(Boolean)isUnreadCountMsg Priority:(NSUInteger)priority{
    return  [[ImMsgEngine getIns] sendImMsg:groupOrUid isGroupMsg:isGroupMsg jsonMsgContent:jsonMsgContent isUnreadCountMsg:isUnreadCountMsg Priority:priority];
}

/// 删除某条消息
/// @param message 消息
-(void)deleteOneImMsg:(V2TIMMessage*)message sucess:(txIMSucc)succ fail:(txIMFail)fail{
    [[V2TIMManager sharedInstance] deleteMessages:@[message] succ:succ fail:fail];
}


/// 删除某聊天及相应的历史信息
/// @param conversationID 会话ID
/// @param succ 成功
/// @param fail 失败
-(void)deleteCoversation:(NSString *)conversationID sucess:(txIMSucc)succ fail:(txIMFail)fail{
    [[V2TIMManager sharedInstance] deleteConversation:conversationID succ:succ fail:fail];
}




/// 删除全部列表
/// @param conversationList 会话ID列表
/// @param succ 成功
/// @param fail 失败
-(void)deleteAllConversation:(NSArray <NSString *>*)conversationList sucess:(txIMSucc)succ fail:(txIMFail)fail{
    __block NSInteger count = conversationList.count;
    for (int i = 0; i < count; i++) {
        NSString *conversationId = conversationList[i];
        [[V2TIMManager sharedInstance] deleteConversation:conversationId succ:^{
            count --;
            if (count == 0) {
                succ();
            }
        } fail:^(int code, NSString *desc) {
            fail(code,desc);
            return;
        }];
    }
}

/// 获取某一条消息
/// @param msgCId 消息ID
-(V2TIMMessage*)getImMsg:(int64_t)msgCId{
   // NSLog(@"过滤文字####【TXImKit】#### - 抱歉 未实现该方法(getImMsg) 请检查"));
    return  nil;
}

/// 撤销某一条消息
/// @param message 消息
/// @param succ 成功
/// @param fail 失败
-(void)cancelImMsg:(V2TIMMessage*)message sucess:(txIMSucc)succ fail:(txIMFail)fail{
    [[V2TIMManager sharedInstance] revokeMessage:message succ:succ fail:fail];
}
 

#pragma mark - 消息已读未读
/// 阅读某条消息
/// @param msgCId 消息ID
-(void)readImMsg:(int64_t)msgCId{
   // NSLog(@"过滤文字####【TXImKit】#### - 抱歉 未实现该方法(readImMsg) 请检查"));
}

/// 阅读某个人或群的所有消息
/// @param groupOrUid 群ID或用户ID
/// @param isGroup 是否为群
/// @param succ 成功
/// @param fail 失败
-(void)readConversationMsg:(NSString *)groupOrUid isGroup:(Boolean)isGroup sucess:(txIMSucc)succ fail:(txIMFail)fail{
    if (isGroup) {
        [[V2TIMManager sharedInstance] markGroupMessageAsRead:groupOrUid succ:succ fail:fail];
    }else{
        [[V2TIMManager sharedInstance] markC2CMessageAsRead:groupOrUid succ:succ fail:fail];
    }
}

/// 所有消息已读
/// @param succ 成功
/// @param fail 失败
-(void)readAllImMsg:(txIMSucc)succ fail:(txIMFail)fail{
    [[V2TIMManager sharedInstance] markAllMessageAsRead:succ fail:fail];
}

/// 获取所有未读消息数目
/// @param succ 成功
/// @param fail 失败
-(void)getAllUnreadMsgCount:(void(^)(int count))succ fail:(txIMFail)fail{
    [[V2TIMManager sharedInstance] getTotalUnreadMessageCount:^(UInt64 totalCount) {
        NSString *countStr = [NSString stringWithFormat:@"%llu",totalCount];
        succ([countStr intValue]);
    } fail:^(int code, NSString *desc) {
        fail(code,desc);
    }];
}

#pragma mark - 群事件

/// 加入群聊
/// @param gruopId 群组ID
/// @param msg 消息
/// @param succ 成功
/// @param fail 失败
- (void)joinGroupWithGroupId:(NSString *)gruopId msg:(NSString *)msg sucess:(txIMSucc)succ fail:(txIMFail)fail{
    [[V2TIMManager sharedInstance] joinGroup:gruopId msg:msg succ:succ fail:fail];
}


/// 退出群聊
/// @param gruopId 群组ID
/// @param succ 成功
/// @param fail 失败
- (void)quitGroupWithGroupId:(NSString *)gruopId sucess:(txIMSucc)succ fail:(txIMFail)fail{
    [[V2TIMManager sharedInstance] quitGroup:gruopId succ:succ fail:fail];
}

#pragma mark - 本地个人信息存储  ～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～
 
/// 设置用户附加信息
/// @param UGID 用户信息UGID
/// @param ditExtraInfo 附加信息
- (void)setExtraInfo:(int64_t)UGID ditExtraInfo:(NSDictionary*)ditExtraInfo{
    [[ImDataBase getIns] setExtraInfo:ditExtraInfo withUGID:UGID];
}

/// 获取附加信息
/// @param UGID 附加信息的UGID
-(ImExtraInfo*)getExtraInfo:(int64_t)UGID{
    return  [[ImDataBase getIns] getExtraInfo:UGID];
}

/// 删除附加信息
/// @param UGID 附加信息的UGID
- (void)delExtraInfo:(int64_t)UGID{
    [[ImDataBase getIns] delExtraInfo:UGID];
}


#pragma mark - 后台测试
  
/// 后台发送测试消息
/// @param msgType 消息主类型
/// @param msgSubType 消息子类型
/// @param message 消息内容
-(void)sendMsg:(NSString*)msgType msgSubType:(NSString*)msgSubType message:(NSDictionary*)message {
   // NSLog(@"过滤文字####【TXImKit】#### - 抱歉 未实现该方法1(sendMsg) 请检查 type == %@  subType == %@"),msgType,msgSubType);
}
 

/// 本地发送socket消息
/// @param msgType 消息主类型
/// @param msgSubType 消息子类型
/// @param message 消息内容
/// @param callback 回调
-(void)sendMsg:(NSString*)msgType msgSubType:(NSString*)msgSubType message:(NSDictionary*)message callback:(CallBack_SocketAck)callback{
//    NSDictionary *msgData = @{@"type":msgType,
//                              @"subType":msgSubType,
//                              @"content":message
//    };
   // NSLog(@"过滤文字####【TXImKit】#### - 抱歉 未实现该方法2(sendMsg) 请检查  type == %@  subType == %@"),msgType,msgSubType);
}




#pragma mark - V2TIMSDKListener ～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～#～
/// SDK 正在连接到服务器
- (void)onConnecting{
   // NSLog(@"过滤文字####【TXImKit】#### -  腾讯IM正在连接..."));
}

/// SDK 已经成功连接到服务器
- (void)onConnectSuccess{
    if (_sdkHander) {
        [_sdkHander onIOConnect:kLocalizationMsg(@"IM连接成功")];
    }
   // NSLog(@"过滤文字####【TXImKit】#### - 腾讯IM连接成功"));
}

/// SDK 连接服务器失败
- (void)onConnectFailed:(int)code err:(NSString*)err{
    if (_sdkHander) {
        [_sdkHander onDisConnect:kLocalizationMsg(@"IM连接失败")];
    }
}

/// 当前用户被踢下线，此时可以 UI 提示用户，并再次调用 V2TIMManager 的 login() 函数重新登录。
- (void)onKickedOffline{
    if (_sdkHander) {
        [_sdkHander onTokenInvalid:kLocalizationMsg(@"被踢下线 请重新登录")];
    }
}

/// 在线时票据过期：此时您需要生成新的 userSig 并再次调用 V2TIMManager 的 login() 函数重新登录。
- (void)onUserSigExpired{
    if (_sdkHander) {
        [_sdkHander onKeyExpire:kLocalizationMsg(@"签名文件过期 请重新登录")];
    }
}

/// 当前用户的资料发生了更新
- (void)onSelfInfoUpdated:(V2TIMUserFullInfo *)Info{
   // NSLog(@"过滤文字####【TXImKit】#### - 用户资料更新 name = %@"),Info.nickName);
}


#pragma mark - V2TIMAdvancedMsgListener
/// 收到新消息
- (void)onRecvNewMessage:(V2TIMMessage *)msg{
    NSDictionary *dic = msg.customElem.data.jsonValue;
    int imType = [dic[@"isChatRecord"] intValue];
    if (msg.elemType == V2TIM_ELEM_TYPE_GROUP_TIPS || imType == 1) {
        [[ImMsgEngine getIns] onReceivedMsg:msg];
    }else{
       // NSLog(@"过滤文字####【TXImKit】####  收到socket消息 内容 == %@"),dic);
        [[ImApiEngine getIns] onReceivedMsg:msg];
    } 
}
+(NSDictionary*)returnDictionaryWithDataPath:(NSData*)data
{ 
    NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSData * datas = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingMutableLeaves error:nil];
    
    return jsonDict;
}
/// 消息已读回执通知（如果自己发的消息支持已读回执，消息接收端调用了 sendMessageReadReceipts 接口，自己会收到该回调）
- (void)onRecvMessageReadReceipts:(NSArray<V2TIMMessageReceipt *> *)receiptList{
   // NSLog(@"过滤文字####【TXImKit】#### -  消息回执通知"));
}

/// C2C 对端用户会话已读通知（如果对端用户调用 markC2CMessageAsRead 接口，自己会收到该通知）
- (void)onRecvC2CReadReceipt:(NSArray<V2TIMMessageReceipt *> *)receiptList{
    [[ImMsgEngine getIns] onRecvSingleChatReadReceipt:receiptList];
}


/// 收到消息撤回
/// @param msgID 消息ID
- (void)onRecvMessageRevoked:(NSString *)msgID{
    [[ImMsgEngine getIns] onRecvRevokedMsg:msgID];
}

/// 消息内容被修改（第三方服务回调修改了消息内容）
- (void)onRecvMessageModified:(V2TIMMessage *)msg{
   // NSLog(@"过滤文字####【TXImKit】#### - 消息内容被修改"));
}


#pragma mark - V2TIMConversationListener
/**
 * 同步服务器会话开始，SDK 会在登录成功或者断网重连后自动同步服务器会话，您可以监听这个事件做一些 UI 进度展示操作。
 */
- (void)onSyncServerStart{
   // NSLog(@"过滤文字####【TXImKit】#### -  服务器同步会话开始"));
}

/**
 * 同步服务器会话完成，如果会话有变更，会通过 onNewConversation | onConversationChanged 回调告知客户
 */
- (void)onSyncServerFinish{
   // NSLog(@"过滤文字####【TXImKit】#### -  服务器同步会话完成"));
}

/**
 * 同步服务器会话失败
 */
- (void)onSyncServerFailed{
   // NSLog(@"过滤文字####【TXImKit】#### -  服务器同步会话失败"));
}

/**
 * 有新的会话（比如收到一个新同事发来的单聊消息、或者被拉入了一个新的群组中），可以根据会话的 lastMessage -> timestamp 重新对会话列表做排序。
 */
- (void)onNewConversation:(NSArray<V2TIMConversation*> *) conversationList{
    if (_conversationHander && [_conversationHander respondsToSelector:@selector(ImNewConversationIn:)]) {
        [_conversationHander ImNewConversationIn:conversationList];
    }
}

/**
 * 某些会话的关键信息发生变化（未读计数发生变化、最后一条消息被更新等等），可以根据会话的 lastMessage -> timestamp 重新对会话列表做排序。
 */
- (void)onConversationChanged:(NSArray<V2TIMConversation*> *) conversationList{
    if (_conversationHander && [_conversationHander respondsToSelector:@selector(ImConversationChanged:)]) {
        [_conversationHander ImConversationChanged:conversationList];
    }
}

/**
 * 会话未读总数变更通知（5.3.425 及以上版本支持）
 * @note
 *  - 未读总数会减去设置为免打扰的会话的未读数，即消息接收选项设置为 V2TIMMessage.V2TIM_NOT_RECEIVE_MESSAGE 或 V2TIMMessage.V2TIM_RECEIVE_NOT_NOTIFY_MESSAGE 的会话。
 */
- (void)onTotalUnreadMessageCountChanged:(UInt64) totalUnreadCount{
    if (_conversationHander && [_conversationHander respondsToSelector:@selector(ImTotalUnreadMessageCountChanged:)]) {
        [_conversationHander ImTotalUnreadMessageCountChanged:totalUnreadCount];
    }
}

@end

 
