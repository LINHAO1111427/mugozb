//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvAnchorMsgSender.h"


/**
主播相关的socket
 */
@implementation IMRcvAnchorMsgSender

-(NSString*) getMsgType
{
    return @"AnchorMsgSender";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onAnchorAuthUser"])
{
        [self onAnchorAuthUser:[ApiUserInfoModel getFromDict:content[@"user"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 主播认证成功推送socket
 @param user null
 */
-(void) onAnchorAuthUser:(ApiUserInfoModel* )user {  }

@end


