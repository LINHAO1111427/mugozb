//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "OOOInviteRetModel.h"

#import "ApiUsersLineModel.h"

#import "HttpNoneModel.h"

#import "OOOReturnModel.h"

#import "ApiPushChatModel.h"

#import "ApiPushChatDataModel.h"

#import "AppSendPushChatVOModel.h"

#import "OOOHangupReturnModel.h"

typedef void (^CallBackOOOCall_OOOInviteRet)(int code,NSString *strMsg,OOOInviteRetModel* model);
typedef void (^CallBackOOOCall_ApiUsersLineArr)(int code,NSString *strMsg,NSArray<ApiUsersLineModel*>* arr);
typedef void (^CallBackOOOCall_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackOOOCall_OOOReturn)(int code,NSString *strMsg,OOOReturnModel* model);
typedef void (^CallBackOOOCall_ApiPushChatArr)(int code,NSString *strMsg,NSArray<ApiPushChatModel*>* arr);
typedef void (^CallBackOOOCall_ApiPushChatData)(int code,NSString *strMsg,ApiPushChatDataModel* model);
typedef void (^CallBackOOOCall_AppSendPushChatVO)(int code,NSString *strMsg,AppSendPushChatVOModel* model);
typedef void (^CallBackOOOCall_OOOHangupReturn)(int code,NSString *strMsg,OOOHangupReturnModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
一对一直播间会话管理
 */
@interface HttpApiOOOCall: NSObject



/**
 是否能发起一对一通话 code:1成功 2:对方正忙 3:对方正在通话 4:对方不在线 7101:用户余额不足无法邀请通话 10:不能向自己发起邀请11:数据错误 12:贵族才能通话 13:用户和用户不能打电话 14:主播和主播不能打电话 15:对方开启了勿扰 16:主播正忙 17:被邀请用户设置了勿扰 18:您已被拉黑 20:未认证
 @param inviteUId 对方id
 @param isVideo 0:语音 1:视频
 */
+(void) inviteChat:(int64_t)inviteUId isVideo:(int)isVideo  callback:(CallBackOOOCall_OOOInviteRet)callback;


/**
 女主播列表
 @param lat 纬度
 @param lng 经度
 @param pageIndex 当前页
 @param pageSize 每页条数
 @param type 类型 1:聊场 2:女主播
 */
+(void) getAnchorOrMailList:(double)lat lng:(double)lng pageIndex:(int)pageIndex pageSize:(int)pageSize type:(int)type  callback:(CallBackOOOCall_ApiUsersLineArr)callback;


/**
 撤销邀请
 @param sessionID 会话ID
 */
+(void) cancelInvite:(int64_t)sessionID  callback:(CallBackOOOCall_HttpNone)callback;


/**
 回复用户,是否接受邀请 code 1:成功 2:会话已经结束 3:重复请求 9:余额不足
 @param replyType 是否同意 1:同意 0:拒绝
 @param sessionID 会话ID
 */
+(void) replyInvite:(int)replyType sessionID:(int64_t)sessionID  callback:(CallBackOOOCall_OOOReturn)callback;


/**
 1v1抢聊列表
 @param pageIndex pageIndex
 @param pageSize pageSize
 */
+(void) getGrabAchatList:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackOOOCall_ApiPushChatArr)callback;


/**
 退出求聊信息
 */
+(void) exitPushChat:(CallBackOOOCall_HttpNone)callback;


/**
 获取求聊页面数据
 @param type 类型 1:视频聊天 2:语音聊天
 */
+(void) getPushChatData:(int)type  callback:(CallBackOOOCall_ApiPushChatData)callback;


/**
 通过推送恢复发送邀请的socket
 @param oooFee (受益方)通话每分钟费用
 @param sessionId 会话ID
 */
+(void) oooCallPushDataRestore:(double)oooFee sessionId:(int64_t)sessionId  callback:(CallBackOOOCall_HttpNone)callback;


/**
 发布求聊信息(跳过选择界面)code=2时为余额不足 3:不是贵族无法发布
 */
+(void) addPushChat1:(CallBackOOOCall_AppSendPushChatVO)callback;


/**
 随机和一位空闲的主播发起通话
 @param isVideo 0:语音 1:视频
 */
+(void) getNextAnchor:(int)isVideo  callback:(CallBackOOOCall_OOOInviteRet)callback;


/**
 发布求聊信息code=7101时为余额不足 3:不是贵族无法发布
 @param chatType 聊天类型 1:视频聊天 2:语音聊天
 @param feeId 话费id
 @param oooChannelId ooo一级菜单id
 */
+(void) addPushChat:(int)chatType feeId:(int64_t)feeId oooChannelId:(int64_t)oooChannelId  callback:(CallBackOOOCall_AppSendPushChatVO)callback;


/**
 通过推送恢复发送邀请的socket
 @param portrait 海报地址
 @param roomId 房间id
 */
+(void) setUserPortrait:(NSString *)portrait roomId:(int64_t)roomId  callback:(CallBackOOOCall_HttpNone)callback;


/**
 一对一最小化数据恢复
 @param sessionId 操作人id
 @param showId 通话标识
 */
+(void) minimizeData:(int64_t)sessionId showId:(NSString *)showId  callback:(CallBackOOOCall_OOOReturn)callback;


/**
 抢聊操作
 @param sessionId 抢聊标识
 @param toUid 用户id(被抢用户id)
 */
+(void) robPushChat:(int64_t)sessionId toUid:(int64_t)toUid  callback:(CallBackOOOCall_OOOReturn)callback;


/**
 挂断通话 code 1:成功 2:通话已经结束
 @param resion 挂断原因 1:正常 2:直播云断掉了
 @param sessionID 会话ID
 */
+(void) hangupCall:(int)resion sessionID:(int64_t)sessionID  callback:(CallBackOOOCall_OOOHangupReturn)callback;

@end

NS_ASSUME_NONNULL_END
