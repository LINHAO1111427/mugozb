//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvSendRedPacket.h"


/**
红包 socket
 */
@implementation IMRcvSendRedPacket

-(NSString*) getMsgType
{
    return @"SendRedPacket";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onSendRedPacket"])
{
        [self onSendRedPacket:[OneRedPacketVOModel getFromDict:content[@"oneRedPacketVO"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 发送红包后,刷新用户剩余红包数
 @param oneRedPacketVO null
 */
-(void) onSendRedPacket:(OneRedPacketVOModel* )oneRedPacketVO {  }

@end


