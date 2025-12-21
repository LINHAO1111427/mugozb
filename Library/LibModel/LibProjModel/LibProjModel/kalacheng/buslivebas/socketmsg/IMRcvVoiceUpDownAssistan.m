//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvVoiceUpDownAssistan.h"


/**
多人语音上下麦相关
 */
@implementation IMRcvVoiceUpDownAssistan

-(NSString*) getMsgType
{
    return @"VoiceUpDownAssistan";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onVoiceLineRequset"])
{
        [self onVoiceLineRequset:[ApiUsersVoiceAssistanModel getFromDict:content[@"apiUsersVoiceAssistans"]] ];
}else    if([subType isEqualToString:@"onVoiceLineNumber"])
{
        [self onVoiceLineNumber:[content getInt64:@"roomId"] num:[content getInt:@"num"] ];
}else    if([subType isEqualToString:@"onVoiceAssistantPrompt"])
{
        [self onVoiceAssistantPrompt:[content getInt64:@"roomId"] roomAssistantPromptVO:[RoomAssistantPromptVOModel getFromDict:content[@"roomAssistantPromptVO"]] ];
}else    if([subType isEqualToString:@"replyInviteAssistant"])
{
        [self replyInviteAssistant:[content getInt64:@"roomId"] status:[content getInt:@"status"] ];
}else    if([subType isEqualToString:@"refuseUpAstApply"])
{
        [self refuseUpAstApply:[content getInt64:@"roomID"] ];
}else    if([subType isEqualToString:@"cancelApplyUp"])
{
        [self cancelApplyUp:[content getInt64:@"authId"] ];
}else    if([subType isEqualToString:@"applyUpTimeOut"])
{
        [self applyUpTimeOut:[content getInt64:@"applyUid"] ];
}else    if([subType isEqualToString:@"agreeUpAstApply"])
{
        [self agreeUpAstApply:[content getInt64:@"roomID"] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 直播间内游客申请上麦，给主播发送申请通知信息
 @param apiUsersVoiceAssistans null
 */
-(void) onVoiceLineRequset:(ApiUsersVoiceAssistanModel* )apiUsersVoiceAssistans {  }
/**
 直播间内申请上麦的游客数量
 @param roomId null
 @param num null
 */
-(void) onVoiceLineNumber:(int64_t)roomId num:(int)num {  }
/**
 直播间邀请用户上麦
 @param roomId null
 @param roomAssistantPromptVO null
 */
-(void) onVoiceAssistantPrompt:(int64_t)roomId roomAssistantPromptVO:(RoomAssistantPromptVOModel* )roomAssistantPromptVO {  }
/**
 回复邀请上麦申请
 @param roomId null
 @param status 1：同意 2:拒绝 3：超时
 */
-(void) replyInviteAssistant:(int64_t)roomId status:(int)status {  }
/**
 房主拒绝游客的上麦申请
 @param roomID null
 */
-(void) refuseUpAstApply:(int64_t)roomID {  }
/**
 撤销上麦申请
 @param authId 撤销方ID
 */
-(void) cancelApplyUp:(int64_t)authId {  }
/**
 申请上麦超时 两边都发
 @param applyUid 申请人ID
 */
-(void) applyUpTimeOut:(int64_t)applyUid {  }
/**
 房主同意游客的上麦申请
 @param roomID null
 */
-(void) agreeUpAstApply:(int64_t)roomID {  }

@end


