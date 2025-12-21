//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvVoiceInvite.h"


/**
多人语音邀请相关
 */
@implementation IMRcvVoiceInvite

-(NSString*) getMsgType
{
    return @"VoiceInvite";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"invtUserUpAssitan"])
{
        [self invtUserUpAssitan:[AppJoinRoomVOModel getFromDict:content[@"joinRoom"]] inviteInfo:[ApiUserInfoModel getFromDict:content[@"inviteInfo"]] isPay:[content getInt:@"isPay"] ];
}else    if([subType isEqualToString:@"acceptVoice"])
{
        [self acceptVoice:[content getInt64:@"roomID"] ];
}else    if([subType isEqualToString:@"refuseVoice"])
{
        [self refuseVoice:[content getInt64:@"roomID"] ];
}else    if([subType isEqualToString:@"invtTimeOut"])
{
        [self invtTimeOut:[content getInt64:@"sendInvtUid"] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 主播邀请上麦
 @param joinRoom null
 @param inviteInfo null
 @param isPay 门票房间是否付过钱  -1不是门票房间  1是门票房间付过钱 0是门票房间没付过钱
 */
-(void) invtUserUpAssitan:(AppJoinRoomVOModel* )joinRoom inviteInfo:(ApiUserInfoModel* )inviteInfo isPay:(int)isPay {  }
/**
 接受房主的连麦邀请
 @param roomID null
 */
-(void) acceptVoice:(int64_t)roomID {  }
/**
 拒绝房主的连麦邀请
 @param roomID null
 */
-(void) refuseVoice:(int64_t)roomID {  }
/**
 邀请上麦超时(双方都要收到)
 @param sendInvtUid 邀请人ID
 */
-(void) invtTimeOut:(int64_t)sendInvtUid {  }

@end


