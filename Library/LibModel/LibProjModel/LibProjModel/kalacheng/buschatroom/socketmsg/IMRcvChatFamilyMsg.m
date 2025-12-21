//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvChatFamilyMsg.h"


/**
聊天室 cocket
 */
@implementation IMRcvChatFamilyMsg

-(NSString*) getMsgType
{
    return @"ChatFamilyMsg";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"sendJoinRoomMsg"])
{
        [self sendJoinRoomMsg:[AppJoinChatRoomMsgVOModel getFromDict:content[@"appJoinChatRoomMsgVO"]] ];
}else    if([subType isEqualToString:@"sendFamilyFirstUser"])
{
        [self sendFamilyFirstUser:[content getInt64:@"familyId"] contributionFirstAvatar:[content getStr:@"contributionFirstAvatar"] ];
}else    if([subType isEqualToString:@"sendLocalTyrantJoinRoomMsg"])
{
        [self sendLocalTyrantJoinRoomMsg:[AppJoinChatRoomMsgVOModel getFromDict:content[@"appJoinChatRoomMsgVO"]] ];
}else    if([subType isEqualToString:@"sendTopMsgToFamily"])
{
        [self sendTopMsgToFamily:[AppChatFamilyMsgTopVOModel getFromDict:content[@"appChatFamilyMsgTopVO"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 聊天家族发送贵族进场消息
 @param appJoinChatRoomMsgVO null
 */
-(void) sendJoinRoomMsg:(AppJoinChatRoomMsgVOModel* )appJoinChatRoomMsgVO {  }
/**
 发送聊天室排名第一的用户头像（日榜贡献榜）
 @param familyId null
 @param contributionFirstAvatar null
 */
-(void) sendFamilyFirstUser:(int64_t)familyId contributionFirstAvatar:(NSString *)contributionFirstAvatar {  }
/**
 聊天家族发送土豪进场消息
 @param appJoinChatRoomMsgVO null
 */
-(void) sendLocalTyrantJoinRoomMsg:(AppJoinChatRoomMsgVOModel* )appJoinChatRoomMsgVO {  }
/**
 更换置顶消息
 @param appChatFamilyMsgTopVO null
 */
-(void) sendTopMsgToFamily:(AppChatFamilyMsgTopVOModel* )appChatFamilyMsgTopVO {  }

@end


