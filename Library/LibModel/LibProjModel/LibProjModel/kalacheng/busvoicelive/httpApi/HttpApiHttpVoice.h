//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "ApiUsersVoiceAssistanModel.h"

#import "ApiCloseLiveModel.h"

#import "AppJoinRoomVOModel.h"

#import "HttpVoice_openVoiceLive.h"
#import "HttpNoneModel.h"

#import "ApiLeaveRoomModel.h"

#import "AssistantUserInfoVOModel.h"

#import "AppVoiceThumbModel.h"

#import "ApiLineVoiceModel.h"

#import "AppUserDtoModel.h"

#import "AppStrickerModel.h"

typedef void (^CallBackHttpVoice_ApiUsersVoiceAssistan)(int code,NSString *strMsg,ApiUsersVoiceAssistanModel* model);
typedef void (^CallBackHttpVoice_ApiCloseLive)(int code,NSString *strMsg,ApiCloseLiveModel* model);
typedef void (^CallBackHttpVoice_AppJoinRoomVO)(int code,NSString *strMsg,AppJoinRoomVOModel* model);
typedef void (^CallBackHttpVoice_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackHttpVoice_ApiLeaveRoom)(int code,NSString *strMsg,ApiLeaveRoomModel* model);
typedef void (^CallBackHttpVoice_AssistantUserInfoVOArr)(int code,NSString *strMsg,NSArray<AssistantUserInfoVOModel*>* arr);
typedef void (^CallBackHttpVoice_AppVoiceThumbArr)(int code,NSString *strMsg,NSArray<AppVoiceThumbModel*>* arr);
typedef void (^CallBackHttpVoice_ApiLineVoiceArr)(int code,NSString *strMsg,NSArray<ApiLineVoiceModel*>* arr);
typedef void (^CallBackHttpVoice_AppUserDtoArr)(int code,NSString *strMsg,NSArray<AppUserDtoModel*>* arr);
typedef void (^CallBackHttpVoice_AppStrickerArr)(int code,NSString *strMsg,NSArray<AppStrickerModel*>* arr);
NS_ASSUME_NONNULL_BEGIN



/**
语音直播间
 */
@interface HttpApiHttpVoice: NSObject



/**
 开关麦
 @param onOffState 麦克风状态(目标值) 0:关麦 1:开麦(音量)
 @param roomId 直播间ID
 */
+(void) offVolumn:(int)onOffState roomId:(int64_t)roomId  callback:(CallBackHttpVoice_ApiUsersVoiceAssistan)callback;


/**
 http方式关播
 @param roomId 房间id
 */
+(void) closeVoiceLive:(int64_t)roomId  callback:(CallBackHttpVoice_ApiCloseLive)callback;




/**
 http方式创建房间code为3时请先认证
 @param addr 主播地址
 @param channelId 频道ID
 @param city 市
 @param lat 纬度
 @param lng 经度
 @param pull 直播云推/拉流地址
 @param roomType 房间模式 0:普通房间 1:私密房间 2:收费房间 3:计时房间 4:贵族房间
 @param roomTypeVal 房间模式对应的值 密码房间：密码  收费房间：收费金额
 @param title 开播标题
 @param upStatus 自动上麦状态 1:开 0:关
 */
+(void) openVoiceLive:(HttpVoice_openVoiceLive*)_mdl callback:(CallBackHttpVoice_AppJoinRoomVO)callback;
/**
 http方式创建房间code为3时请先认证
 @param addr 主播地址
 @param channelId 频道ID
 @param city 市
 @param lat 纬度
 @param lng 经度
 @param pull 直播云推/拉流地址
 @param roomType 房间模式 0:普通房间 1:私密房间 2:收费房间 3:计时房间 4:贵族房间
 @param roomTypeVal 房间模式对应的值 密码房间：密码  收费房间：收费金额
 @param title 开播标题
 @param upStatus 自动上麦状态 1:开 0:关
 */
+(void) openVoiceLive:(NSString *)addr channelId:(int64_t)channelId city:(NSString *)city lat:(double)lat lng:(double)lng pull:(NSString *)pull roomType:(int)roomType roomTypeVal:(NSString *)roomTypeVal title:(NSString *)title upStatus:(int)upStatus  callback:(CallBackHttpVoice_AppJoinRoomVO)callback;


/**
 null
 @param isAuto 自动上麦开关 1：打开 0：关闭
 @param roomId 房间号
 */
+(void) setAutoUpAssistant:(int)isAuto roomId:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback;


/**
 锁定或解锁麦位
 @param assistantNo 麦位序号
 @param retireState 封麦状态值 0封麦 1解封
 @param roomId 直播间ID
 */
+(void) lockAssistant:(int)assistantNo retireState:(int)retireState roomId:(int64_t)roomId  callback:(CallBackHttpVoice_ApiUsersVoiceAssistan)callback;


/**
 http方式离开房间
 @param roomId 房间id
 */
+(void) leaveVoiceRoomOpt:(int64_t)roomId  callback:(CallBackHttpVoice_ApiLeaveRoom)callback;


/**
 获取麦位上的用户信息列表
 @param roomId 直播间ID
 */
+(void) getAssistantUserInfoList:(int64_t)roomId  callback:(CallBackHttpVoice_AssistantUserInfoVOArr)callback;


/**
 房主抱房间内观众（角色可以是主播也可以是用户）上麦
 @param inviteUid 被邀请上麦方ID
 @param roomId 直播间ID
 */
+(void) letUserUpAssitant:(int64_t)inviteUid roomId:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback;


/**
 null
 @param roomId 房间号
 */
+(void) quitPK:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback;


/**
 观众撤销申请上麦
 @param roomId 房间号
 */
+(void) cancelUpAssistant:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback;


/**
 null
 @param roomId 房间号
 */
+(void) getAutoUpAssistant:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback;


/**
 主播踢人
 @param roomId 直播间ID
 @param userId 被踢下麦的副播ID
 */
+(void) kickOutAssistan:(int64_t)roomId userId:(int64_t)userId  callback:(CallBackHttpVoice_ApiUsersVoiceAssistan)callback;


/**
 邀请直播间内用户上麦成为副播
 @param inviteUid 被邀请方ID
 @param roomId 房间号
 */
+(void) inviteLiveUserUpAssistant:(int64_t)inviteUid roomId:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback;


/**
 房主同意或拒绝申请用户上麦
 @param assistantNo 申请上的麦序（弹窗中时为-1）
 @param isAgree 是否同意申请方上麦 1是 0否
 @param roomId 多人语音直播间ID
 @param userId 申请方ID
 */
+(void) dealUpAssistantAsk:(int)assistantNo isAgree:(int)isAgree roomId:(int64_t)roomId userId:(int64_t)userId  callback:(CallBackHttpVoice_HttpNone)callback;


/**
 null
 @param inviteUid 邀请方用户id
 @param reply 回复邀请方房主，同意或拒绝上麦  1同意 0拒绝
 @param roomId 多人语音直播间ID
 */
+(void) replyAuthorInvt:(int64_t)inviteUid reply:(int)reply roomId:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback;


/**
 null
 @param pktype PK类型 1:房间PK 2:单人Pk 3:激情团战
 @param roomID 多人语音直播间ID
 */
+(void) applyPK:(int)pktype roomID:(int64_t)roomID  callback:(CallBackHttpVoice_HttpNone)callback;


/**
 下麦操作
 @param assistantNo 麦位序号
 @param roomId 直播间ID
 */
+(void) authDownAssistant:(int)assistantNo roomId:(int64_t)roomId  callback:(CallBackHttpVoice_ApiUsersVoiceAssistan)callback;


/**
 获取语音直播间背景图
 @param type 类型 0:多人语音 1:一对一语音
 */
+(void) voiceThumbList:(int)type  callback:(CallBackHttpVoice_AppVoiceThumbArr)callback;


/**
 http方式加入语音房间
 @param roomId 房间id
 @param roomType 房间类型 0:一般直播 1:私密直播 2:收费直播 3:计时直播 4:贵族房间
 @param roomTypeVal 如果是密码房间传入密码
 */
+(void) joinVoiceRoom:(int64_t)roomId roomType:(int)roomType roomTypeVal:(NSString *)roomTypeVal  callback:(CallBackHttpVoice_AppJoinRoomVO)callback;


/**
 获取直播间最新麦位
 @param roomId 房间id
 */
+(void) getNewAppJoinRoomVO:(int64_t)roomId  callback:(CallBackHttpVoice_AppJoinRoomVO)callback;


/**
 主持人回复上主持位请求
 @param agreeOrNot 是否同意 1：同意 -1：拒绝
 @param roomId 房间号
 @param userId 申请主持位的用户ID
 */
+(void) replyApplyToBePresenter:(int)agreeOrNot roomId:(int64_t)roomId userId:(int64_t)userId  callback:(CallBackHttpVoice_HttpNone)callback;


/**
 麦位用户禁麦(禁止说话)/麦位用户取消禁麦(允许说话)
 @param presenterUserId 不知道什么id不要使用
 @param roomId 房间号
 @param touid 被禁止说话人id
 */
+(void) addNoTalking:(int64_t)presenterUserId roomId:(int64_t)roomId touid:(int64_t)touid  callback:(CallBackHttpVoice_HttpNone)callback;


/**
 null
 @param roomId 多人语音直播间ID
 @param strickerId 表情包Id
 */
+(void) sendSticker:(int64_t)roomId strickerId:(int64_t)strickerId  callback:(CallBackHttpVoice_HttpNone)callback;


/**
 获取直播间数据
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间id
 */
+(void) getApiJoinRoom:(int)liveType roomId:(int64_t)roomId  callback:(CallBackHttpVoice_AppJoinRoomVO)callback;


/**
 修改直播间背景图
 @param roomId 房间号
 @param voiceThumbId 背景图Id
 */
+(void) updateLiveBackground:(int64_t)roomId voiceThumbId:(int64_t)voiceThumbId  callback:(CallBackHttpVoice_HttpNone)callback;


/**
 邀请直播间外主播上麦成为副播
 @param inviteUid 被邀请方ID
 @param roomId 房间号
 */
+(void) inviteUserUpAssitant:(int64_t)inviteUid roomId:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback;


/**
 下主持位
 @param roomId 房间号
 */
+(void) downPresenter:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback;


/**
 上主持位
 @param roomId 房间号
 */
+(void) applyToBePresenter:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback;


/**
 默认直接上麦，当房间主播设置开关需审核才能上麦时，点击上麦的用户进入申请列表等待,主播可在待审核列表同意指定的观众进入直播间0:观众申请上麦发送成功 1:观众上麦操作成功 2:主播ID不一致 3:麦位数据有误
 @param assistantNo 麦位序号  -1时为弹窗功能的申请上麦，不能指定上的麦序
 @param roomId 直播间ID
 */
+(void) authUpAssistan:(int)assistantNo roomId:(int64_t)roomId  callback:(CallBackHttpVoice_ApiUsersVoiceAssistan)callback;


/**
 查看申请上麦(主播尚未同意的)列表
 @param roomId 直播间ID
 */
+(void) getWaitingUsers:(int64_t)roomId  callback:(CallBackHttpVoice_ApiLineVoiceArr)callback;


/**
 null
 @param role 搜索的角色类型 0:普通用户 1:主播
 @param roomId 房间号
 */
+(void) enableInvtVoice:(int)role roomId:(int64_t)roomId  callback:(CallBackHttpVoice_AppUserDtoArr)callback;


/**
 null
 */
+(void) getStrickerList:(CallBackHttpVoice_AppStrickerArr)callback;

@end

NS_ASSUME_NONNULL_END
