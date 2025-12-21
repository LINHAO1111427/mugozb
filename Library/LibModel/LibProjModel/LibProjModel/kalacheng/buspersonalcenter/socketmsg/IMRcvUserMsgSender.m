//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvUserMsgSender.h"


/**
用户推送公告内容
 */
@implementation IMRcvUserMsgSender

-(NSString*) getMsgType
{
    return @"UserMsgSender";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onUsersBeautifulNumber"])
{
        [self onUsersBeautifulNumber:[ApiBeautifulNumberModel getFromDict:content[@"user"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 赠送靓号推送公告内容
 @param user null
 */
-(void) onUsersBeautifulNumber:(ApiBeautifulNumberModel* )user {  }

@end


