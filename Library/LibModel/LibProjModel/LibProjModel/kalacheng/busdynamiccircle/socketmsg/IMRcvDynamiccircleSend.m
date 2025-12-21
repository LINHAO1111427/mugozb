//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvDynamiccircleSend.h"


/**
动态消息发送socket
 */
@implementation IMRcvDynamiccircleSend

-(NSString*) getMsgType
{
    return @"DynamiccircleSend";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onUserVideoCommentCount"])
{
        [self onUserVideoCommentCount:[ApiSendVideoUnReadNumberModel getFromDict:content[@"apiSendVideoUnReadNumber"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 动态评论或回复发送消息显示个数
 @param apiSendVideoUnReadNumber null
 */
-(void) onUserVideoCommentCount:(ApiSendVideoUnReadNumberModel* )apiSendVideoUnReadNumber {  }

@end


