//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvLiveAnchorLineSend.h"


/**
主播互动发送消息
 */
@implementation IMRcvLiveAnchorLineSend

-(NSString*) getMsgType
{
    return @"LiveAnchorLineSend";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onAnchorCloseLine"])
{
        [self onAnchorCloseLine:[ApiCloseLineModel getFromDict:content[@"apiCloseLine"]] ];
}else    if([subType isEqualToString:@"onAnchorLineReq"])
{
        [self onAnchorLineReq:[ApiSendMsgUserModel getFromDict:content[@"apiSendMsgUser"]] ];
}else    if([subType isEqualToString:@"onAnchorLineResp"])
{
        [self onAnchorLineResp:[ApiSendLineMsgRoomModel getFromDict:content[@"apiSendLineMsgRoom"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 主播关闭互动
 @param apiCloseLine null
 */
-(void) onAnchorCloseLine:(ApiCloseLineModel* )apiCloseLine {  }
/**
 主播发送连麦请求
 @param apiSendMsgUser null
 */
-(void) onAnchorLineReq:(ApiSendMsgUserModel* )apiSendMsgUser {  }
/**
 主播在直播间发送是否同意连麦消息
 @param apiSendLineMsgRoom null
 */
-(void) onAnchorLineResp:(ApiSendLineMsgRoomModel* )apiSendLineMsgRoom {  }

@end


