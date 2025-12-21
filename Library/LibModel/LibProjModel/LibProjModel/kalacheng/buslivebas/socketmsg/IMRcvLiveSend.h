//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "ApiCloseLiveModel.h"
#import "ApiSimpleMsgRoomModel.h"
#import "GuardUserVOModel.h"
#import "ApiLeaveRoomAnchorModel.h"
#import "ApiUsersVoiceAssistanModel.h"
#import "ApiLeaveRoomModel.h"
#import "ApiJoinRoomAnchorModel.h"
#import "AppJoinRoomVOModel.h"
#import "ApiKickLiveModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
直播间live发送消息
 */
@interface IMRcvLiveSend: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 后台强制关闭房间
 @param apiCloseLive null
 */
-(void) onManageLeaveRoom:(ApiCloseLiveModel* )apiCloseLive ;


/**
 房间中的角色 1:普通用户 2:管理员 3:主播
 @param roomRole null
 */
-(void) onRoomAdministrator:(int)roomRole ;


/**
 土豪进场消息
 @param apiSimpleMsgRoom null
 */
-(void) onJoinRoomMsgRoom:(ApiSimpleMsgRoomModel* )apiSimpleMsgRoom ;


/**
 房间上锁
 @param liveLockStatus null
 */
-(void) onLiveLockStatusMsg:(int)liveLockStatus ;


/**
 购买守护列表消息
 @param list null
 */
-(void) onBuyGuardListRoom:(NSMutableArray<GuardUserVOModel*>* )list ;


/**
 主播离开房间
 @param ApiLeaveRoomAnchor null
 */
-(void) onAnchorLeaveRoom:(ApiLeaveRoomAnchorModel* )ApiLeaveRoomAnchor ;


/**
 下麦操作
 @param apiVoiceAssistanEntity null
 */
-(void) onDownVoiceAssistan:(ApiUsersVoiceAssistanModel* )apiVoiceAssistanEntity ;


/**
 关闭直播间发送消息
 @param apiCloseLive null
 */
-(void) onCloseLive:(ApiCloseLiveModel* )apiCloseLive ;


/**
 离开房间给房间发送消息
 @param apiLeaveRoom null
 */
-(void) onUserLeaveRoom:(ApiLeaveRoomModel* )apiLeaveRoom ;


/**
 主播回来房间
 @param apiJoinRoomAnchor null
 */
-(void) onAnchorJoinRoom:(ApiJoinRoomAnchorModel* )apiJoinRoomAnchor ;


/**
 获取最新的房间信息
 @param appJoinRoomVO null
 */
-(void) onRoomAssistan:(AppJoinRoomVOModel* )appJoinRoomVO ;


/**
 修改房间背景图推送公告内容
 @param voicethumb null
 */
-(void) onUserBackground:(NSString *)voicethumb ;


/**
 踢人消息
 @param apiKickLive null
 */
-(void) onManageKickRoom:(ApiKickLiveModel* )apiKickLive ;


/**
 加入直播间发送消息
 @param appJoinRoomVO null
 */
-(void) onUserJoinRoom:(AppJoinRoomVOModel* )appJoinRoomVO ;


/**
 修改直播间标题
 @param content null
 */
-(void) onLiveTitleMsg:(NSString *)content ;

@end

NS_ASSUME_NONNULL_END
