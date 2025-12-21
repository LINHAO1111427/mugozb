//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "EnableInvtHostModel.h"

#import "OOOVolumeRetModel.h"

#import "HttpNoneModel.h"

#import "OOOInviteRetModel.h"

#import "OOOReturnModel.h"

#import "OOOHangupReturnModel.h"

typedef void (^CallBackOTMCall_EnableInvtHostArr)(int code,NSString *strMsg,NSArray<EnableInvtHostModel*>* arr);
typedef void (^CallBackOTMCall_OOOVolumeRet)(int code,NSString *strMsg,OOOVolumeRetModel* model);
typedef void (^CallBackOTMCall_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackOTMCall_OOOInviteRet)(int code,NSString *strMsg,OOOInviteRetModel* model);
typedef void (^CallBackOTMCall_OOOReturn)(int code,NSString *strMsg,OOOReturnModel* model);
typedef void (^CallBackOTMCall_OOOHangupReturn)(int code,NSString *strMsg,OOOHangupReturnModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
一对一对多直播间会话管理
 */
@interface HttpApiOTMCall: NSObject



/**
 null
 @param gender 主播性别 -1:全部 0:保密 1:男 2:女
 @param keyWord 搜索的主播ID/昵称
 */
+(void) invitingAnchor:(int)gender keyWord:(NSString *)keyWord  callback:(CallBackOTMCall_EnableInvtHostArr)callback;


/**
 在通话过程中修改开关麦操作
 @param sessionID 会话ID
 @param status 麦克风状态值 1：开启 0：关闭
 */
+(void) otmVolume:(int64_t)sessionID status:(int)status  callback:(CallBackOTMCall_OOOVolumeRet)callback;


/**
 在通话过程中对指定副播进行禁言操作
 @param assisUid 指定禁言的副播id
 @param sessionID 会话ID
 @param shutStatus 禁言状态 1:禁言 0:解禁
 */
+(void) addOOOShutup:(int64_t)assisUid sessionID:(int64_t)sessionID shutStatus:(int)shutStatus  callback:(CallBackOTMCall_HttpNone)callback;


/**
 null
 @param anchUid 被撤销邀请的副播id
 @param sessionID 会话ID
 */
+(void) anchCancelInvite:(int64_t)anchUid sessionID:(int64_t)sessionID  callback:(CallBackOTMCall_HttpNone)callback;


/**
 对指定主播发起加入房间1v1v7群聊邀请，主播接通后成为该房间的副播(该功能只有开通了SVIP服务的用户才可以使用) 14:用户金币不足 15:房间人数超限 16:该副播已经处于被邀请中状态中,不能再次邀请！17:对方开启了勿扰 18:男孩子之前不能通话 19:正处于免费通话期间,不能邀请副播
 @param inviteUId 对方id
 @param isVideo 是否视频 0语音1视频 目前1v1v7只能视频
 @param sessionId 1v1v多邀请时填入的1v1房间的sessionId
 */
+(void) invtJoinOneVsOne:(int64_t)inviteUId isVideo:(int)isVideo sessionId:(int64_t)sessionId  callback:(CallBackOTMCall_OOOInviteRet)callback;


/**
 回复用户,是否接受邀请。code:1成功；2会话已经结束；3重复请求; 9余额不足
 @param feeUid 付费用户id
 @param replyType 是否同意 1:同意 0:拒绝
 @param sessionID 会话ID
 */
+(void) replyInviteOTM:(int64_t)feeUid replyType:(int)replyType sessionID:(int64_t)sessionID  callback:(CallBackOTMCall_OOOReturn)callback;


/**
 用户踢人只能踢副播,副播退出的挂断接口。(只自己退出，1v1视频继续)
 @param assitId 被踢出的副播id
 @param isVideo 是否为视频通话 目前1v1v7只支持视频 1视频 0语音
 @param sessionID 会话ID
 */
+(void) kickOutAnch:(int64_t)assitId isVideo:(int)isVideo sessionID:(int64_t)sessionID  callback:(CallBackOTMCall_OOOHangupReturn)callback;


/**
 主播或用户挂断，整个房间销毁.副播挂断，副播退出,房间通话继续; code;1成功；2通话已经结束；11数据错误
 @param reason 挂断原因 1:正常 2:直播云断掉了 11:费用不足 13:超时自动撤销
 @param sessionID 会话ID
 */
+(void) otmHangup:(int)reason sessionID:(int64_t)sessionID  callback:(CallBackOTMCall_OOOHangupReturn)callback;

@end

NS_ASSUME_NONNULL_END
