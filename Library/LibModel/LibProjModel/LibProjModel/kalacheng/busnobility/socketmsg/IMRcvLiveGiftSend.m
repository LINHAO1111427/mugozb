//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvLiveGiftSend.h"


/**
赠送礼物发送消息
 */
@implementation IMRcvLiveGiftSend

-(NSString*) getMsgType
{
    return @"LiveGiftSend";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onSimpleGiftMsgRoom"])
{
        [self onSimpleGiftMsgRoom:[ApiSimpleMsgRoomModel getFromDict:content[@"apiSimpleMsgRoom"]] ];
}else    if([subType isEqualToString:@"onGiftMsgAll"])
{
        [self onGiftMsgAll:[ApiGiftSenderModel getFromDict:content[@"apiGiftSender"]] ];
}else    if([subType isEqualToString:@"onGiveGiftUser"])
{
        [self onGiveGiftUser:[ApiGiftSenderModel getFromDict:content[@"apiGiftSender"]] ];
}else    if([subType isEqualToString:@"onGroupGiveGift"])
{
        [self onGroupGiveGift:[ApiGiftSenderModel getFromDict:content[@"apiGiftSender"]] ];
}else    if([subType isEqualToString:@"onGiveGift"])
{
        [self onGiveGift:[ApiGiftSenderModel getFromDict:content[@"apiGiftSender"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 简单消息
 @param apiSimpleMsgRoom null
 */
-(void) onSimpleGiftMsgRoom:(ApiSimpleMsgRoomModel* )apiSimpleMsgRoom {  }
/**
 全直播间飘屏信息
 @param apiGiftSender null
 */
-(void) onGiftMsgAll:(ApiGiftSenderModel* )apiGiftSender {  }
/**
 赠送礼物后给用户发送消息
 @param apiGiftSender null
 */
-(void) onGiveGiftUser:(ApiGiftSenderModel* )apiGiftSender {  }
/**
 群聊送礼物发送socket
 @param apiGiftSender null
 */
-(void) onGroupGiveGift:(ApiGiftSenderModel* )apiGiftSender {  }
/**
 赠送礼物后给房间发送消息
 @param apiGiftSender null
 */
-(void) onGiveGift:(ApiGiftSenderModel* )apiGiftSender {  }

@end


