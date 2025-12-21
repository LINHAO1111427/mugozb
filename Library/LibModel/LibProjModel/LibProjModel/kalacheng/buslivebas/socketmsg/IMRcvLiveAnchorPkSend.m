//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvLiveAnchorPkSend.h"


/**
主播PK发送消息
 */
@implementation IMRcvLiveAnchorPkSend

-(NSString*) getMsgType
{
    return @"LiveAnchorPkSend";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onGiftPKResult"])
{
        [self onGiftPKResult:[ApiPkResultModel getFromDict:content[@"apiPKResult"]] ];
}else    if([subType isEqualToString:@"onAnchorPKReq"])
{
        [self onAnchorPKReq:[ApiSendMsgUserModel getFromDict:content[@"apiSendMsgUser"]] ];
}else    if([subType isEqualToString:@"onAnchorPKResp"])
{
        [self onAnchorPKResp:[ApiSendPKMsgRoomModel getFromDict:content[@"ApiSendPKMsgRoom"]] ];
}else    if([subType isEqualToString:@"onPKResultResp"])
{
        [self onPKResultResp:[ApiPkResultRoomModel getFromDict:content[@"apiPkResultRoom"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 赠送礼物后血条信息
 @param apiPKResult null
 */
-(void) onGiftPKResult:(ApiPkResultModel* )apiPKResult {  }
/**
 主播发送PK请求
 @param apiSendMsgUser null
 */
-(void) onAnchorPKReq:(ApiSendMsgUserModel* )apiSendMsgUser {  }
/**
 主播在直播间发送是否同意PK请求
 @param ApiSendPKMsgRoom null
 */
-(void) onAnchorPKResp:(ApiSendPKMsgRoomModel* )ApiSendPKMsgRoom {  }
/**
 PK结果响应
 @param apiPkResultRoom null
 */
-(void) onPKResultResp:(ApiPkResultRoomModel* )apiPkResultRoom {  }

@end


