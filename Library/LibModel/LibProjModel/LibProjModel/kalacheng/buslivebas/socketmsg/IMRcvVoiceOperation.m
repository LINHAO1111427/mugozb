//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvVoiceOperation.h"


/**
多人语音操作的推送消息
 */
@implementation IMRcvVoiceOperation

-(NSString*) getMsgType
{
    return @"VoiceOperation";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onUpVoiceAssistan"])
{
        [self onUpVoiceAssistan:[ApiUsersVoiceAssistanModel getFromArr:content[@"apiVoiceAssistanEntity"]] upUid:[content getInt64:@"upUid"] ];
}else    if([subType isEqualToString:@"sendAnchorVotes"])
{
        [self sendAnchorVotes:[content getInt64:@"anchorId"] votes:[content getDouble:@"votes"] ];
}else    if([subType isEqualToString:@"downVoiceAssistan"])
{
        [self downVoiceAssistan:[ApiUsersVoiceAssistanModel getFromArr:content[@"apiVoiceAssistanEntity"]] downUid:[content getInt64:@"downUid"] ];
}else    if([subType isEqualToString:@"sendAnchorSticker"])
{
        [self sendAnchorSticker:[ApiUsersVoiceAssistanModel getFromDict:content[@"presenterAssistant"]] ];
}else    if([subType isEqualToString:@"offVolumn"])
{
        [self offVolumn:[ApiUsersVoiceAssistanModel getFromArr:content[@"apiVoiceAssistanEntity"]] setUid:[content getInt64:@"setUid"] ];
}else    if([subType isEqualToString:@"sendStricker"])
{
        [self sendStricker:[content getInt:@"no"] hGetAssistanList:[ApiUsersVoiceAssistanModel getFromArr:content[@"hGetAssistanList"]] ];
}else    if([subType isEqualToString:@"hostOffVolumn"])
{
        [self hostOffVolumn:[content getInt:@"onOffState"] ];
}else    if([subType isEqualToString:@"kickOutAssistan"])
{
        [self kickOutAssistan:[content getInt64:@"assisId"] assitan:[ApiUsersVoiceAssistanModel getFromArr:content[@"assitan"]] ];
}else    if([subType isEqualToString:@"LockThisAssistan"])
{
        [self LockThisAssistan:[content getInt:@"assistanNo"] assitan:[ApiUsersVoiceAssistanModel getFromArr:content[@"assitan"]] ];
}else    if([subType isEqualToString:@"sendGift"])
{
        [self sendGift:[ApiUsersVoiceAssistanModel getFromArr:content[@"hGetAssistanList"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 观众上麦操作
 @param apiVoiceAssistanEntity null
 @param upUid null
 */
-(void) onUpVoiceAssistan:(NSMutableArray<ApiUsersVoiceAssistanModel*>* )apiVoiceAssistanEntity upUid:(int64_t)upUid {  }
/**
 单独发送主播的火力值
 @param anchorId null
 @param votes null
 */
-(void) sendAnchorVotes:(int64_t)anchorId votes:(double)votes {  }
/**
 副播下麦操作
 @param apiVoiceAssistanEntity null
 @param downUid null
 */
-(void) downVoiceAssistan:(NSMutableArray<ApiUsersVoiceAssistanModel*>* )apiVoiceAssistanEntity downUid:(int64_t)downUid {  }
/**
 语音房间非PK状态下的主播发送表情包
 @param presenterAssistant null
 */
-(void) sendAnchorSticker:(ApiUsersVoiceAssistanModel* )presenterAssistant {  }
/**
 副播开关麦操作
 @param apiVoiceAssistanEntity null
 @param setUid null
 */
-(void) offVolumn:(NSMutableArray<ApiUsersVoiceAssistanModel*>* )apiVoiceAssistanEntity setUid:(int64_t)setUid {  }
/**
 语音房间非PK状态下的副播发送表情包
 @param no null
 @param hGetAssistanList null
 */
-(void) sendStricker:(int)no hGetAssistanList:(NSMutableArray<ApiUsersVoiceAssistanModel*>* )hGetAssistanList {  }
/**
 主播开关麦操作
 @param onOffState null
 */
-(void) hostOffVolumn:(int)onOffState {  }
/**
 主播将指定麦序的麦位上副播踢出
 @param assisId 被踢出的副播id
 @param assitan null
 */
-(void) kickOutAssistan:(int64_t)assisId assitan:(NSMutableArray<ApiUsersVoiceAssistanModel*>* )assitan {  }
/**
 封锁指定麦序的麦位
 @param assistanNo 指定麦序
 @param assitan null
 */
-(void) LockThisAssistan:(int)assistanNo assitan:(NSMutableArray<ApiUsersVoiceAssistanModel*>* )assitan {  }
/**
 语音房间非PK状态下的送礼
 @param hGetAssistanList null
 */
-(void) sendGift:(NSMutableArray<ApiUsersVoiceAssistanModel*>* )hGetAssistanList {  }

@end


