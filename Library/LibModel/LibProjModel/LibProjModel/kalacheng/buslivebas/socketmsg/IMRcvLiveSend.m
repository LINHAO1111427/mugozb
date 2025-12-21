//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvLiveSend.h"


/**
直播间live发送消息
 */
@implementation IMRcvLiveSend

-(NSString*) getMsgType
{
    return @"LiveSend";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onManageLeaveRoom"])
{
        [self onManageLeaveRoom:[ApiCloseLiveModel getFromDict:content[@"apiCloseLive"]] ];
}else    if([subType isEqualToString:@"onRoomAdministrator"])
{
        [self onRoomAdministrator:[content getInt:@"roomRole"] ];
}else    if([subType isEqualToString:@"onJoinRoomMsgRoom"])
{
        [self onJoinRoomMsgRoom:[ApiSimpleMsgRoomModel getFromDict:content[@"apiSimpleMsgRoom"]] ];
}else    if([subType isEqualToString:@"onLiveLockStatusMsg"])
{
        [self onLiveLockStatusMsg:[content getInt:@"liveLockStatus"] ];
}else    if([subType isEqualToString:@"onBuyGuardListRoom"])
{
        [self onBuyGuardListRoom:[GuardUserVOModel getFromArr:content[@"list"]] ];
}else    if([subType isEqualToString:@"onAnchorLeaveRoom"])
{
        [self onAnchorLeaveRoom:[ApiLeaveRoomAnchorModel getFromDict:content[@"ApiLeaveRoomAnchor"]] ];
}else    if([subType isEqualToString:@"onDownVoiceAssistan"])
{
        [self onDownVoiceAssistan:[ApiUsersVoiceAssistanModel getFromDict:content[@"apiVoiceAssistanEntity"]] ];
}else    if([subType isEqualToString:@"onCloseLive"])
{
        [self onCloseLive:[ApiCloseLiveModel getFromDict:content[@"apiCloseLive"]] ];
}else    if([subType isEqualToString:@"onUserLeaveRoom"])
{
        [self onUserLeaveRoom:[ApiLeaveRoomModel getFromDict:content[@"apiLeaveRoom"]] ];
}else    if([subType isEqualToString:@"onAnchorJoinRoom"])
{
        [self onAnchorJoinRoom:[ApiJoinRoomAnchorModel getFromDict:content[@"apiJoinRoomAnchor"]] ];
}else    if([subType isEqualToString:@"onRoomAssistan"])
{
        [self onRoomAssistan:[AppJoinRoomVOModel getFromDict:content[@"appJoinRoomVO"]] ];
}else    if([subType isEqualToString:@"onUserBackground"])
{
        [self onUserBackground:[content getStr:@"voicethumb"] ];
}else    if([subType isEqualToString:@"onManageKickRoom"])
{
        [self onManageKickRoom:[ApiKickLiveModel getFromDict:content[@"apiKickLive"]] ];
}else    if([subType isEqualToString:@"onUserJoinRoom"])
{
        [self onUserJoinRoom:[AppJoinRoomVOModel getFromDict:content[@"appJoinRoomVO"]] ];
}else    if([subType isEqualToString:@"onLiveTitleMsg"])
{
        [self onLiveTitleMsg:[content getStr:@"content"] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 后台强制关闭房间
 @param apiCloseLive null
 */
-(void) onManageLeaveRoom:(ApiCloseLiveModel* )apiCloseLive {  }
/**
 房间中的角色 1:普通用户 2:管理员 3:主播
 @param roomRole null
 */
-(void) onRoomAdministrator:(int)roomRole {  }
/**
 土豪进场消息
 @param apiSimpleMsgRoom null
 */
-(void) onJoinRoomMsgRoom:(ApiSimpleMsgRoomModel* )apiSimpleMsgRoom {  }
/**
 房间上锁
 @param liveLockStatus null
 */
-(void) onLiveLockStatusMsg:(int)liveLockStatus {  }
/**
 购买守护列表消息
 @param list null
 */
-(void) onBuyGuardListRoom:(NSMutableArray<GuardUserVOModel*>* )list {  }
/**
 主播离开房间
 @param ApiLeaveRoomAnchor null
 */
-(void) onAnchorLeaveRoom:(ApiLeaveRoomAnchorModel* )ApiLeaveRoomAnchor {  }
/**
 下麦操作
 @param apiVoiceAssistanEntity null
 */
-(void) onDownVoiceAssistan:(ApiUsersVoiceAssistanModel* )apiVoiceAssistanEntity {  }
/**
 关闭直播间发送消息
 @param apiCloseLive null
 */
-(void) onCloseLive:(ApiCloseLiveModel* )apiCloseLive {  }
/**
 离开房间给房间发送消息
 @param apiLeaveRoom null
 */
-(void) onUserLeaveRoom:(ApiLeaveRoomModel* )apiLeaveRoom {  }
/**
 主播回来房间
 @param apiJoinRoomAnchor null
 */
-(void) onAnchorJoinRoom:(ApiJoinRoomAnchorModel* )apiJoinRoomAnchor {  }
/**
 获取最新的房间信息
 @param appJoinRoomVO null
 */
-(void) onRoomAssistan:(AppJoinRoomVOModel* )appJoinRoomVO {  }
/**
 修改房间背景图推送公告内容
 @param voicethumb null
 */
-(void) onUserBackground:(NSString *)voicethumb {  }
/**
 踢人消息
 @param apiKickLive null
 */
-(void) onManageKickRoom:(ApiKickLiveModel* )apiKickLive {  }
/**
 加入直播间发送消息
 @param appJoinRoomVO null
 */
-(void) onUserJoinRoom:(AppJoinRoomVOModel* )appJoinRoomVO {  }
/**
 修改直播间标题
 @param content null
 */
-(void) onLiveTitleMsg:(NSString *)content {  }

@end


