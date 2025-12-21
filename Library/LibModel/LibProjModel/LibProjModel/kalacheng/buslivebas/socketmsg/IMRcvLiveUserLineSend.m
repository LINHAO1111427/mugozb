//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvLiveUserLineSend.h"


/**
用户连麦发送消息
 */
@implementation IMRcvLiveUserLineSend

-(NSString*) getMsgType
{
    return @"LiveUserLineSend";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onSetAnchorLineStatus"])
{
        [self onSetAnchorLineStatus:[ApiAnchorLineStatusModel getFromDict:content[@"apiAnchorLineStatus"]] ];
}else    if([subType isEqualToString:@"onUserLineReq"])
{
        [self onUserLineReq:[ApiSendMsgUserModel getFromDict:content[@"apiSendMsgUser"]] ];
}else    if([subType isEqualToString:@"onUserCloseLine"])
{
        [self onUserCloseLine:[ApiCloseLineModel getFromDict:content[@"apiCloseLine"]] ];
}else    if([subType isEqualToString:@"onUserLineResp"])
{
        [self onUserLineResp:[ApiUserLineRoomModel getFromDict:content[@"apiUserLineRoom"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 设置连麦状态,1:开启连麦,2:关闭连麦
 @param apiAnchorLineStatus null
 */
-(void) onSetAnchorLineStatus:(ApiAnchorLineStatusModel* )apiAnchorLineStatus {  }
/**
 用户发送连麦请求
 @param apiSendMsgUser null
 */
-(void) onUserLineReq:(ApiSendMsgUserModel* )apiSendMsgUser {  }
/**
 用户/主播关闭连麦
 @param apiCloseLine null
 */
-(void) onUserCloseLine:(ApiCloseLineModel* )apiCloseLine {  }
/**
 主播同意用户连麦,给房间发消息
 @param apiUserLineRoom null
 */
-(void) onUserLineResp:(ApiUserLineRoomModel* )apiUserLineRoom {  }

@end


